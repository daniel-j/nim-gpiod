import ./libgpiod
import ./line
export line

type
  EventType* = enum
    LineRequested = GpiodInfoEventLineRequested
    LineReleased = GpiodInfoEventLineReleased
    LineConfigChanged = GpiodInfoEventLineConfigChanged

  InfoEvent* = object
    eventType*: EventType
    timestampNs*: uint
    lineInfo*: LineInfo