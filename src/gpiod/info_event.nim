import ./libgpiod
import ./line
export line

type
  EventType* = GpiodInfoEventType

  InfoEvent* = object
    # event*: ptr GpiodInfoEvent
    eventType*: EventType
    timestamp*: Duration
    lineInfo*: LineInfo
