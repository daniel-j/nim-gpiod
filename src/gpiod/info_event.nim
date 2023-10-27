import ./libgpiod
import ./line
export line

type
  EventType* = enum
    LineRequested = GpiodInfoEventLineRequested
    LineReleased = GpiodInfoEventLineReleased
    LineConfigChanged = GpiodInfoEventLineConfigChanged

  InfoEvent* = object
    # event*: ptr GpiodInfoEvent
    eventType*: EventType
    timestampNs*: uint64
    lineInfo*: LineInfo
