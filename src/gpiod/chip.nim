import ./libgpiod
import ./line
import ./info_event
import ./exception

export line, info_event, exception

type
  Chip* = object
    chip: ptr GpiodChip

  ChipInfo* = object
    name*: string
    label*: string
    numLines*: int

proc isOpen*(self: Chip): bool =
  return not self.chip.isNil

proc `=destroy`(self: var Chip) =
  if not self.isOpen(): return
  gpiod_chip_close(self.chip)
  # self.chip = nil

proc open*(_: typedesc[Chip]; path: string): Chip =
  let chip = gpiod_chip_open(path.cstring)
  if chip.isNil:
    raise newException(OpenChipError, "Error opening chip " & path)
  result.chip = chip

proc getPath*(self: Chip): string =
  if not self.isOpen(): return
  return $gpiod_chip_get_path(self.chip)

proc getFd*(self: Chip): int =
  if not self.isOpen(): return
  return gpiod_chip_get_fd(self.chip)

proc close*(self: var Chip) =
  if not self.isOpen(): return
  gpiod_chip_close(self.chip)
  self.chip = nil

proc getInfo*(self: Chip): ChipInfo =
  if not self.isOpen(): return
  let chipInfo = gpiod_chip_get_info(self.chip)
  if not chipInfo.isNil:
    defer: gpiod_chip_info_free(chipInfo)
    result.name = $gpiod_chip_info_get_name(chipInfo)
    result.label = $gpiod_chip_info_get_label(chipInfo)
    result.numLines = gpiod_chip_info_get_num_lines(chipInfo).int

proc getLineInfo*(self: Chip; offset: uint; watch: bool = false): LineInfo =
  if not self.isOpen(): return
  var info: ptr Gpiodlineinfo
  if watch:
    info = gpiod_chip_watch_line_info(self.chip, offset.cuint)
  else:
    info = gpiod_chip_get_line_info(self.chip, offset.cuint)

  if info.isNil: return

  result = makeLineInfo(info)
  gpiod_line_info_free(info)

proc unwatchLineInfo*(self: Chip; offset: uint) =
  if not self.isOpen(): return
  discard gpiod_chip_unwatch_line_info(self.chip, offset.cuint)

proc readInfoEvent*(self: Chip): InfoEvent =
  if not self.isOpen(): return
  let event = gpiod_chip_read_info_event(self.chip)
  if event.isNil: return
  defer: gpiod_info_event_free(event)

  let info = gpiod_info_event_get_line_info(event)
  let infoObj = makeLineInfo(info)
  gpiod_line_info_free(info)

  let eventObj = InfoEvent(
    eventType: cast[EventType](gpiod_info_event_get_event_type(event)),
    timestampNs: gpiod_info_event_get_timestamp_ns(event),
    lineInfo: infoObj
  )

  return eventObj

proc lineOffsetFromId*(self: Chip; name: string): int =
  let offset = gpiod_chip_get_line_offset_from_name(self.chip, name.cstring)
  if offset < 0:
    ## error
  return offset

proc makeRequestConfig*(consumer: string; eventBufferSize: uint): ptr GpiodRequestConfig =
  if consumer.len == 0: return
  let refCfg = gpiod_request_config_new()
  if refCfg.isNil: return

  gpiod_request_config_set_consumer(refCfg, consumer.cstring)

  gpiod_request_config_set_event_buffer_size(refCfg, eventBufferSize)

  return refCfg


# proc requestLines*(self: Chip; lineConfig: LineConfig; consumer: string; eventBufferSize: uint): Request =
#   let lineCfg = lineConfig.getData()
#   if lineCfg.isNil: return

#   let reqCfg = makeRequestConfig(consumer, eventBufferSize)

#   let request = gpiod_chip_request_lines(self.chip, reqCfg, lineCfg)

#   let reqObj = makeRequestObject(request, gpiod_request_config_get_event_buffer_size(reqCfg))
#   gpiod_request_config_free(reqCfg)
#   gpiod_line_request_release(request)

#   return reqObj
