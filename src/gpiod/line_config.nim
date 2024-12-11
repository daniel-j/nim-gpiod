import std/strformat
import ./line_info
import ./line_settings
import ./libgpiod
import ./exception

export exception, line_info, line_settings

type
  LineConfig* = object
    config: ptr GpiodLineConfig

proc `=copy`(dest: var LineConfig; source: LineConfig) {.error.}
proc `=destroy`*(self: var LineConfig) =
  echo "free line config"
  gpiod_line_config_free(self.config)

proc newLineConfig*(): LineConfig =
  result.config = gpiod_line_config_new()
  if result.config.isNil:
    raise newException(LineConfigNewError, "Failed to create line config")

proc getPtr*(self: LineConfig): ptr GpiodLineConfig {.inline.} =
  return self.config

proc resetConfig*(self: var LineConfig) {.inline.} =
  gpiod_line_config_reset(self.config)

proc addLineSettings*(self: var LineConfig; offsets: openarray[Offset]; settings: LineSettings) =
  let ret = gpiod_line_config_add_line_settings(self.config, offsets[0].unsafeAddr, offsets.len.csize_t, settings.getPtr())
  if ret == -1:
    raise newException(LineConfigAddLineSettingsError, "Failed to add line settings to line config")

proc getLineSettings*(self: LineConfig; offset: Offset): LineSettings =
  return fromLineSettings(gpiod_line_config_get_line_settings(self.config, offset))

proc setOutputValues*(self: var LineConfig; values: openarray[Value]) =
  let ret = gpiod_line_config_set_output_values(self.config, values[0].unsafeAddr, values.len.csize_t)
  if ret == -1:
    raise newException(LineConfigSetOutputValuesError, "Failed to set output values to line config")

proc getNumOffsets*(self: LineConfig): int {.inline.} =
  gpiod_line_config_get_num_configured_offsets(self.config).int

proc getOffsets*(self: LineConfig): seq[Offset] =
  result = newSeq[Offset](self.getNumOffsets())
  if result.len > 0:
    let ln = gpiod_line_config_get_configured_offsets(self.config, result[0].addr, result.len.csize_t)
    result.setLen(ln)

proc `$`*(self: LineConfig): string =
  return &"LineConfig(numOffsets: {self.getNumOffsets()}, offsets: {self.getOffsets()})"
