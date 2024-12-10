import std/times
import std/strformat
import ./line_info
import ./libgpiod

export line_info, times

type
  InfoEventType* = GpiodInfoEventType

  InfoEvent* = object
    event: ptr GpiodInfoEvent

proc `=copy`(dest: var InfoEvent; source: InfoEvent) {.error.}
proc `=destroy`*(self: var InfoEvent) =
  echo "free info event"
  gpiod_info_event_free(self.event)

proc fromInfoEvent*(event: ptr GpiodInfoEvent): InfoEvent =
  result.event = event
  if result.event.isNil:
    raise newException(InfoEventNewError, "Failed to create info event from pointer")

proc getType*(self: InfoEvent): InfoEventType {.inline.} =
  return gpiod_info_event_get_event_type(self.event)

proc timestamp*(self: InfoEvent): Time =
  let ns = gpiod_info_event_get_timestamp_ns(self.event)
  return initTime(unix = int64 ns div 1_000_000'u64, nanosecond = int64 ns mod 1_000_000'u64)

proc getLineInfo*(self: InfoEvent): LineInfo =
  return makeLineInfo(gpiod_info_event_get_line_info(self.event))

proc `$`*(self: InfoEvent): string =
  return &"InfoEvent(type: {self.getType()}, timestamp: {self.timestamp})"
