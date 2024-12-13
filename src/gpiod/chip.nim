import std/strformat
import ./libgpiod
import ./exception
import ./line_info
import ./line_config
import ./line_settings
import ./info_event
import ./request

export exception, line_info, line_config, line_settings, info_event, request

type
  Chip* = object
    chip: ptr GpiodChip

  ChipInfo* = object
    name*: string
    label*: string
    numLines*: int

proc `=copy`(dest: var Chip; source: Chip) {.error.}
proc `=destroy`(self: var Chip) =
  echo "free chip"
  gpiod_chip_close(self.chip)
  # self.chip = nil

proc openChip*(path: string): Chip =
  result.chip = gpiod_chip_open(path.cstring)
  if result.chip.isNil:
    raise newException(ChipOpenError, "Error opening chip: " & path)

proc path*(self: Chip): string {.inline.} =
  return $gpiod_chip_get_path(self.chip)

proc rawFd*(self: Chip): int {.inline.} =
  return gpiod_chip_get_fd(self.chip)

proc getInfo*(self: Chip): ChipInfo =
  let chipInfo = gpiod_chip_get_info(self.chip)
  if chipInfo.isNil:
    raise newException(ChipGetInfoError, "Could not get chip info")

  defer: gpiod_chip_info_free(chipInfo)
  result.name = $gpiod_chip_info_get_name(chipInfo)
  result.label = $gpiod_chip_info_get_label(chipInfo)
  result.numLines = gpiod_chip_info_get_num_lines(chipInfo).int

proc `$`*(self: Chip): string =
  return &"Chip(path: {self.path}, rawFd: {self.rawFd}, info: {self.getInfo()})"

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

proc waitInfoEvent*(self: Chip; timeout: Duration): bool =
  let ret = gpiod_chip_wait_info_event(self.chip, timeout.inNanoseconds)
  if ret < 0:
    raise newException(ChipWaitInfoEventError, "Error occured when waiting for chip event")
  return ret > 0

proc readInfoEvent*(self: Chip): InfoEvent =
  let event = gpiod_chip_read_info_event(self.chip)
  if event.isNil:
    raise newException(ChipReadInfoEventError, "Couldn't read chip info event")

  return fromInfoEvent(event)

proc lineOffsetFromName*(self: Chip; name: string): Offset =
  let offset = gpiod_chip_get_line_offset_from_name(self.chip, name.cstring)
  if offset < 0:
    raise newException(ChipGetLineOffsetFromNameError, "Couldn't get chip line offset from name")
  return Offset(offset)

proc requestLines*(self: Chip; requestConfig: RequestConfig; lineConfig: LineConfig): Request =
  let request = gpiod_chip_request_lines(self.chip, requestConfig.getPtr(), lineConfig.getPtr())

  if request.isNil:
    raise newException(ChipRequestLinesError, "Failed to request lines from chip - is it busy?")

  return newRequest(request)

