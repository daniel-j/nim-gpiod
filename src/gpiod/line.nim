import std/times
import ./libgpiod
import ./exception

export exception, times

type
  Offset* = cuint
  Value* = GpiodLineValue
  Direction* = GpiodLineDirection
  Bias* = GpiodLineBias
  Drive* = GpiodLineDrive
  Edge* = GpiodLineEdge
  Clock* = GpiodLineClock

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

  LineConfig* = object
    config*: ptr GpiodLineConfig

proc `=destroy`*(self: var LineConfig) =
  gpiod_line_config_free(self.config)

proc makeLineInfo*(info: ptr GpiodLineInfo): LineInfo =
  if info.isNil: return
  result.offset = gpiod_line_info_get_offset(info).int
  result.name = $gpiod_line_info_get_name(info)
  result.used = gpiod_line_info_is_used(info)
  result.consumer = $gpiod_line_info_get_consumer(info)
  result.direction = gpiod_line_info_get_direction(info)
  result.activeLow = gpiod_line_info_is_active_low(info)
  result.bias = gpiod_line_info_get_bias(info)
  result.drive = gpiod_line_info_get_drive(info)
  result.edgeDetection = gpiod_line_info_get_edge_detection(info)
  result.eventClock = gpiod_line_info_get_event_clock(info)
  result.debounced = gpiod_line_info_is_debounced(info)
  result.debouncePeriod = initDuration(microseconds = gpiod_line_info_get_debounce_period_us(info).int64)

proc newLineConfig*(): LineConfig =
  result.config = gpiod_line_config_new()
  if result.config.isNil:
    raise newException(LineConfigNewError, "Failed to create line config")

