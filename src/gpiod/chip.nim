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
  if self.isOpen():
    gpiod_chip_close(self.chip)
    # self.chip = nil

proc initChip*(path: string): Chip =
  result.chip = gpiod_chip_open(path.cstring)

proc getInfo*(self: Chip): ChipInfo =
  if self.isOpen():
    let chipInfo = gpiod_chip_get_info(self.chip)
    if not chipInfo.isNil:
      defer: gpiod_chip_info_free(chipInfo)
      result.name = $gpiod_chip_info_get_name(chipInfo)
      result.label = $gpiod_chip_info_get_label(chipInfo)
      result.numLines = gpiod_chip_info_get_num_lines(chipInfo).int

proc getPath*(self: Chip): string =
  return $gpiod_chip_get_path(self.chip)

proc getLineInfo*(self: Chip; offset: uint; watch: bool = false): LineInfo =
  var info: ptr Gpiodlineinfo
  if watch:
    info = gpiod_chip_watch_line_info(self.chip, offset.cuint)
  else:
    info = gpiod_chip_get_line_info(self.chip, offset.cuint)

  if info.isNil: return

  result = makeLineInfo(info)
  gpiod_line_info_free(info)
