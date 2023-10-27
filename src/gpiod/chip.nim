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

proc open*(_: typedesc[Chip]; path: string): Chip =
  let chip = gpiod_chip_open(path.cstring)
  if chip.isNil:
    raise newException(OpenChipError, "Error opening chip " & path)
  result.chip = chip

proc `=destroy`(self: var Chip) =
  gpiod_chip_close(self.chip)
  # self.chip = nil

proc getPath*(self: Chip): string =
  return $gpiod_chip_get_path(self.chip)

proc getFd*(self: Chip): int =
  return gpiod_chip_get_fd(self.chip)

proc getInfo*(self: Chip): ChipInfo =
  let chipInfo = gpiod_chip_get_info(self.chip)
  if chipInfo.isNil:
    raise newException(ChipGetInfoError, "Could not get chip info")

  defer: gpiod_chip_info_free(chipInfo)
  result.name = $gpiod_chip_info_get_name(chipInfo)
  result.label = $gpiod_chip_info_get_label(chipInfo)
  result.numLines = gpiod_chip_info_get_num_lines(chipInfo).int

proc getLineInfo*(self: Chip; offset: Offset): LineInfo =
  let info = gpiod_chip_get_line_info(self.chip, offset.cuint)
  if info.isNil:
    raise newException(ChipLineInfoError, "Couldn't get chip line info")

  result = makeLineInfo(info)
  gpiod_line_info_free(info)

proc watchLineInfo*(self: Chip; offset: Offset): LineInfo =
  let info = gpiod_chip_watch_line_info(self.chip, offset.cuint)
  if info.isNil:
    raise newException(ChipLineInfoError, "Couldn't get chip line info")

  result = makeLineInfo(info)
  gpiod_line_info_free(info)

proc unwatchLineInfo*(self: Chip; offset: Offset) =
  discard gpiod_chip_unwatch_line_info(self.chip, offset.cuint)

proc waitInfoEvent*(self: Chip; timeout: int64 = -1): bool =
  let ret = gpiod_chip_wait_info_event(self.chip, timeout)
  if ret < 0:
    raise newException(ChipWaitInfoEventError, "Error occured when waiting for chip event")
  return ret > 0

proc readInfoEvent*(self: Chip): InfoEvent =
  let event = gpiod_chip_read_info_event(self.chip)
  if event.isNil:
    raise newException(ChipReadInfoEventError, "Couldn't read chip info event")
  defer: gpiod_info_event_free(event)

  let info = gpiod_info_event_get_line_info(event)
  let infoObj = makeLineInfo(info)

  let eventObj = InfoEvent(
    eventType: cast[EventType](gpiod_info_event_get_event_type(event)),
    timestampNs: gpiod_info_event_get_timestamp_ns(event),
    lineInfo: infoObj
  )

  return eventObj

proc lineOffsetFromName*(self: Chip; name: string): Offset =
  let offset = gpiod_chip_get_line_offset_from_name(self.chip, name.cstring)
  if offset < 0:
    raise newException(ChipGetLineOffsetFromNameError, "Couldn't get chip line offset from name")
  return Offset(offset)

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
