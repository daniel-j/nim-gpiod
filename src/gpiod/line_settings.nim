import std/times, std/strformat
import ./line_info
import ./libgpiod
import ./exception

export exception, line_info, times

type
  LineSettings* = object
    settings: ptr GpiodLineSettings

proc `=copy`(dest: var LineSettings; source: LineSettings) {.error.}
proc `=destroy`*(self: var LineSettings) =
  echo "free line settings"
  gpiod_line_settings_free(self.settings)

proc newLineSettings*(): LineSettings =
  result.settings = gpiod_line_settings_new()
  if result.settings.isNil:
    raise newException(LineSettingsNewError, "Failed to create new line settings")

proc fromLineSettings*(settings: ptr GpiodLineSettings): LineSettings =
  result.settings = settings
  if result.settings.isNil:
    raise newException(LineSettingsNewError, "Failed to create line settings from pointer")

proc copy*(self: LineSettings): LineSettings =
  result.settings = gpiod_line_settings_copy(self.settings)
  if result.settings.isNil:
    raise newException(LineSettingsNewError, "Failed to copy line settings")

proc getPtr*(self: LineSettings): ptr GpiodLineSettings {.inline.} =
  return self.settings

proc `direction=`*(self: var LineSettings; direction: Direction) =
  let ret = gpiod_line_settings_set_direction(self.settings, direction)
  assert(ret == 0)
proc direction*(self: LineSettings): Direction  {.inline.} =
  return gpiod_line_settings_get_direction(self.settings)

proc `edgeDetection=`*(self: var LineSettings; edge: Edge) =
  let ret = gpiod_line_settings_set_edge_detection(self.settings, edge)
  assert(ret == 0)
proc edgeDetection*(self: LineSettings): Edge {.inline.} =
  return gpiod_line_settings_get_edge_detection(self.settings)

proc `bias=`*(self: var LineSettings; bias: Bias) =
  let ret = gpiod_line_settings_set_bias(self.settings, bias)
  assert(ret == 0)
proc bias*(self: LineSettings): Bias {.inline.} =
  return gpiod_line_settings_get_bias(self.settings)

proc `drive=`*(self: var LineSettings; drive: Drive) =
  let ret = gpiod_line_settings_set_drive(self.settings, drive)
  assert(ret == 0)
proc drive*(self: LineSettings): Drive =
  return gpiod_line_settings_get_drive(self.settings)

proc `activeLow=`*(self: var LineSettings; activeLow: bool) =
  gpiod_line_settings_set_active_low(self.settings, activeLow)
proc activeLow*(self: LineSettings): bool {.inline.} =
  return gpiod_line_settings_get_active_low(self.settings)

proc `debouncePeriod=`*(self: var LineSettings; debouncePeriod: Duration) =
  gpiod_line_settings_set_debounce_period_us(self.settings, debouncePeriod.inMicroseconds.culong)
proc debouncePeriod*(self: LineSettings): Duration =
  return initDuration(microseconds = gpiod_line_settings_get_debounce_period_us(self.settings).int64)

proc `outputValue=`*(self: var LineSettings; outputValue: Value) =
  let ret = gpiod_line_settings_set_output_value(self.settings, outputValue)
  assert(ret == 0)
proc outputValue*(self: LineSettings): Value {.inline.} =
  return gpiod_line_settings_get_output_value(self.settings)

proc `eventClock=`*(self: var LineSettings; eventClock: Clock) =
  let ret = gpiod_line_settings_set_event_clock(self.settings, eventClock)
  assert(ret == 0)
proc eventClock*(self: LineSettings): Clock {.inline.} =
  return gpiod_line_settings_get_event_clock(self.settings)

proc resetSettings*(self: var LineSettings) =
  gpiod_line_settings_reset(self.settings)

proc `$`*(self: LineSettings): string =
  return &"LineSettings(direction: {self.direction}, edgeDetection: {self.edgeDetection}, bias: {self.bias}, drive: {self.drive}, activeLow: {self.activeLow}, debouncePeriod: {self.debouncePeriod}, outputValue: {self.outputValue}, eventClock: {self.eventClock})"