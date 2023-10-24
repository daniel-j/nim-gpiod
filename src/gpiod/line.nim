import std/times
export times

import ./libgpiod

type
  Value* {.pure.} = enum
    ValueError = GpiodLineValueError
    Inactive = GpiodLineValueInactive
    Active = GpiodLineValueActive

  Direction* {.pure.} = enum
    AsIs = GpiodLinedirectionAsIs
    Input = GpiodLinedirectionInput
    Output = GpiodLinedirectionOutput

  Bias* {.pure.} = enum
    AsIs = GpiodLineBiasAsIs
    Unknown = GpiodLineBiasUnknown
    Disabled = GpiodLineBiasDisabled
    PullUp = GpiodLineBiasPullUp
    PullDown = GpiodLineBiasPullDown

  Drive* {.pure.} = enum
    PushPull = GpiodLineDrivePushPull
    OpenDrain = GpiodLineDriveOpenDrain
    OpenSource = GpiodLineDriveOpenSource

  Edge* {.pure.} = enum
    None = GpiodLineEdgeNone
    Rising = GpiodLineEdgeRising
    Falling = GpiodLineEdgeFalling
    Both = GpiodLineEdgeBoth

  Clock* {.pure.} = enum
    Monotonic = GpiodLineClockMonotonic
    Realtime = GpiodLineClockRealtime
    Hte = GpiodLineClockHte

  LineInfo* = object
    offset*: int
    name*: string
    used*: bool
    consumer*: string
    direction*: Direction
    activeLow*: bool
    bias*: Bias
    drive*: Drive
    edgeDetection*: Edge
    eventClock*: Clock
    debounced*: bool
    debouncePeriod*: Duration

proc makeLineInfo*(info: ptr GpiodLineInfo): LineInfo =
  if info.isNil: return
  result.offset = gpiod_line_info_get_offset(info).int
  result.name = $gpiod_line_info_get_name(info)
  result.used = gpiod_line_info_is_used(info)
  result.consumer = $gpiod_line_info_get_consumer(info)
  result.direction = cast[Direction](gpiod_line_info_get_direction(info))
  result.activeLow = gpiod_line_info_is_active_low(info)
  result.bias = cast[Bias](gpiod_line_info_get_bias(info))
  result.drive = cast[Drive](gpiod_line_info_get_drive(info))
  result.edgeDetection = cast[Edge](gpiod_line_info_get_edge_detection(info))
  result.eventClock = cast[Clock](gpiod_line_info_get_event_clock(info))
  result.debounced = gpiod_line_info_is_debounced(info)
  result.debouncePeriod = initDuration(microseconds = gpiod_line_info_get_debounce_period_us(info).int64)
