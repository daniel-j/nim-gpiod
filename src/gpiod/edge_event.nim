import std/strformat
import ./line_info
import ./exception
import ./libgpiod

export exception, line_info

type
  EdgeEventType* = GpiodEdgeEventType

  EdgeEvent* = object
    event: ptr GpiodEdgeEvent
  
  EdgeEventBuffer* = object
    buffer: ptr GpiodEdgeEventBuffer

proc `=copy`(dest: var EdgeEvent; source: EdgeEvent) {.error.}
proc `=destroy`*(self: var EdgeEvent) =
  echo "free edge event"
  gpiod_edge_event_free(self.event)

proc copy*(self: EdgeEvent): EdgeEvent =
  result.event = gpiod_edge_event_copy(self.event)
  if result.event.isNil:
    raise newException(EdgeEventNewError, "Failed to copy edge event")

proc getType*(self: EdgeEvent): EdgeEventType {.inline.} =
  return gpiod_edge_event_get_event_type(self.event)

proc timestamp*(self: EdgeEvent): Time =
  let ns = gpiod_edge_event_get_timestamp_ns(self.event)
  return initTime(unix = int64 ns div 1_000_000'u64, nanosecond = int64 ns mod 1_000_000'u64)

proc lineOffset*(self: EdgeEvent): Offset {.inline.} =
  return gpiod_edge_event_get_line_offset(self.event)

proc globalSeqNo*(self: EdgeEvent): uint {.inline.} =
  return gpiod_edge_event_get_global_seqno(self.event).uint

proc seqNo*(self: EdgeEvent): uint {.inline.} =
  return gpiod_edge_event_get_line_seqno(self.event).uint

proc `$`*(self: EdgeEvent): string =
  return &"EdgeEvent(type: {self.getType()}, timestamp: {self.timestamp}, offset: {self.lineOffset}, seqNo: {self.seqNo}, globalSeqNo: {self.globalSeqNo})"


proc `=copy`(dest: var EdgeEventBuffer; source: EdgeEventBuffer) {.error.}
proc `=destroy`*(self: var EdgeEventBuffer) =
  echo "free edge event buffer"
  gpiod_edge_event_buffer_free(self.buffer)

proc newEdgeEventBuffer*(capacity: uint): EdgeEventBuffer =
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
  result = EdgeEvent(event: event).copy()

proc len*(self: EdgeEventBuffer): int {.inline.} =
  return gpiod_edge_event_buffer_get_num_events(self.buffer).int

proc `$`*(self: EdgeEventBuffer): string =
  return &"EdgeEventBuffer(capacity: {self.capacity}, len: {self.len})"
