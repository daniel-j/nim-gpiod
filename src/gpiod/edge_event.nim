import std/strformat
import ./line_info
import ./exception
import ./libgpiod

export exception, line_info

type
  EdgeEventType* = GpiodEdgeEventType

  EdgeEvent* = object
    eventType*: EdgeEventType
    timestamp*: Time
    lineOffset*: Offset
    globalSeqNo*: uint
    lineSeqNo*: uint
  
proc makeEdgeEvent*(event: ptr GpiodEdgeEvent): EdgeEvent =
  result.eventType = gpiod_edge_event_get_event_type(event)
  let ns = gpiod_edge_event_get_timestamp_ns(event)
  result.timestamp = initTime(unix = int64 ns div 1_000_000_000'u64, nanosecond = int64 ns mod 1_000_000_000'u64)
  result.lineOffset = gpiod_edge_event_get_line_offset(event)
  result.globalSeqNo = gpiod_edge_event_get_global_seqno(event)
  result.lineSeqNo = gpiod_edge_event_get_line_seqno(event)


type
  EdgeEventBuffer* = object
    buffer: ptr GpiodEdgeEventBuffer

proc `=copy`(dest: var EdgeEventBuffer; source: EdgeEventBuffer) {.error.}
proc `=destroy`*(self: var EdgeEventBuffer) =
  echo "free edge event buffer"
  gpiod_edge_event_buffer_free(self.buffer)

proc newEdgeEventBuffer*(capacity: int): EdgeEventBuffer =
  result.buffer = gpiod_edge_event_buffer_new(capacity.csize_t)
  if result.buffer.isNil:
    raise newException(EdgeEventBufferNewError, "Failed to create new edge event buffer")

proc getPtr*(self: EdgeEventBuffer): ptr GpiodEdgeEventBuffer {.inline.} =
  return self.buffer

proc capacity*(self: EdgeEventBuffer): int {.inline.} =
  return gpiod_edge_event_buffer_get_capacity(self.buffer).int

proc `[]`*(self: EdgeEventBuffer, index: int): EdgeEvent =
  let event = gpiod_edge_event_buffer_get_event(self.buffer, index.culong)
  if event.isNil:
    raise newException(EdgeEventBufferGetEventError, "Failed to get event from event buffer")
  result = makeEdgeEvent(event)

proc len*(self: EdgeEventBuffer): int {.inline.} =
  return gpiod_edge_event_buffer_get_num_events(self.buffer).int

proc `$`*(self: EdgeEventBuffer): string =
  return &"EdgeEventBuffer(capacity: {self.capacity}, len: {self.len})"

iterator items*(self: EdgeEventBuffer): EdgeEvent {.inline.} =
  ## Iterates over each item of `a`.
  var i = 0
  let ln = len(self)
  while i < ln:
    yield self[i]
    inc(i)
