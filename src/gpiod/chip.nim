import ./libgpiod
import ./line
export line

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

proc initChip*(path: string): Chip =
  result.chip = gpiod_chip_open(path.cstring)

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
