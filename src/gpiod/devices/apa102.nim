import gpiod
export gpiod

type
  Brightness* = range[0.uint8 .. 31.uint8]

  Pixel* {.packed.} = object
    brightness* {.bitsize: 5.}: Brightness
    header* {.bitsize: 3.}: uint8
    b*: uint8
    g*: uint8
    r*: uint8

  Apa102* = object of RootObj
    datPin: Offset
    clkPin: Offset
    req: Request
    size: int
    buffer: seq[Pixel]

const defaultBrightness* = 7.Brightness

proc `=copy`(dest: var Apa102; source: Apa102) {.error.}

proc setup(self: Apa102; chip: Chip): Request =
  var lineCfg = newLineConfig()

  var settings = newLineSettings()

  # data pins
  settings.direction = GPIOD_LINE_DIRECTION_OUTPUT
  lineCfg.addLineSettings([self.datPin, self.clkPin], settings)

  var reqCfg = newRequestConfig()
  reqCfg.consumer = "apa102"

  return chip.requestLines(reqCfg, lineCfg)

proc writeByte(self: Apa102; b: byte) =
  let pins = [self.datPin, self.clkPin]
  var data = [GPIOD_LINE_VALUE_INACTIVE, GPIOD_LINE_VALUE_ACTIVE]

  var i = 7
  while i >= 0:
    data[0] = if ((b shr i) and 1).bool: GPIOD_LINE_VALUE_ACTIVE else: GPIOD_LINE_VALUE_INACTIVE
    self.req.setValuesSubset(pins, data)
    self.req.setValue(self.clkPin, GPIOD_LINE_VALUE_INACTIVE)
    dec(i)

iterator pixels*(self: var Apa102): var Pixel =
  for i in 0..<self.size:
    yield self.buffer[i]

proc initApa102*(chip: Chip; size: int; datPin: Offset; clkPin: Offset): Apa102 =
  result.size = size
  result.datPin = datPin
  result.clkPin = clkPin
  result.buffer.setLen(size)
  for pixel in result.pixels:
    pixel.header = 0b111
    pixel.brightness = defaultBrightness
  result.req = result.setup(chip)

proc show*(self: Apa102) =
  self.writeByte(0)
  self.writeByte(0)
  self.writeByte(0)
  self.writeByte(0)
  let buf = cast[ptr UncheckedArray[uint8]](self.buffer[0].unsafeAddr)
  for i in 0..<self.size*4:
    self.writeByte(buf[i])

  self.writeByte(0)
  self.writeByte(0)
  self.writeByte(0)
  self.writeByte(0)
  let count = (self.size + 14) div 16
  for i in 0..<count:
    self.writeByte(0)

proc setBrightness*(self: var Apa102; brightness: Brightness) =
  for pixel in self.pixels:
    pixel.brightness = brightness

proc clear*(self: var Apa102) =
  for pixel in self.pixels:
    pixel.r = 0
    pixel.g = 0
    pixel.b = 0
    pixel.brightness = defaultBrightness

proc setAll*(self: var Apa102; p: Pixel) =
  for pixel in self.pixels:
    pixel = p

proc setPixel*(self: var Apa102; index: int; p: Pixel) =
  copyMem(self.buffer[index].addr, p.unsafeAddr, sizeof(Pixel))

