import gpiod
export gpiod

type
  Brightness* = range[0.byte .. 31.byte]

  Pixel* = object
    r*: uint8
    g*: uint8
    b*: uint8
    brightness*: Brightness

  Pixels* = seq[Pixel]

  Apa102* = object of RootObj
    datPin: Offset
    clkPin: Offset
    req: Request
    pixels*: Pixels

const defaultBrightness* = 7.Brightness

proc `=copy`(dest: var Apa102; source: Apa102) {.error.}

proc initPixels(size: int): Pixels =
  result.setLen(size)
  for i in 0..<size:
    result[i].brightness = defaultBrightness

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

proc startFrame(self: Apa102) =
  self.req.setValue(self.datPin, GPIOD_LINE_VALUE_INACTIVE)
  for i in 0..<8*4:
    self.req.setValue(self.clkPin, GPIOD_LINE_VALUE_ACTIVE)
    self.req.setValue(self.clkPin, GPIOD_LINE_VALUE_INACTIVE)

proc endFrame(self: Apa102) =
  let count = ((self.pixels.len + 14) div 16) * 8
  self.req.setValue(self.datPin, GPIOD_LINE_VALUE_INACTIVE)
  for i in 0..<count:
    self.req.setValue(self.clkPin, GPIOD_LINE_VALUE_ACTIVE)
    self.req.setValue(self.clkPin, GPIOD_LINE_VALUE_INACTIVE)


proc initApa102*(chip: Chip; size: int; datPin: Offset; clkPin: Offset): Apa102 =
  result.datPin = datPin
  result.clkPin = clkPin
  result.pixels = initPixels(size)
  result.req = result.setup(chip)

proc show*(self: Apa102) =
  self.startFrame()

  for pixel in self.pixels:
    self.writeByte(0b11100000.byte or pixel.brightness)
    self.writeByte(pixel.b)
    self.writeByte(pixel.g)
    self.writeByte(pixel.r)

  self.endFrame()

proc setBrightness*(self: var Apa102; brightness: Brightness) =
  for pixel in self.pixels.mitems:
    pixel.brightness = brightness

proc clear*(self: var Apa102) =
  for pixel in self.pixels.mitems:
    pixel.r = 0
    pixel.g = 0
    pixel.b = 0
    pixel.brightness = defaultBrightness

proc setAll*(self: var Apa102; p: Pixel) =
  for pixel in self.pixels.mitems:
    pixel = p

proc setPixel*(self: var Apa102; index: int; p: Pixel) =
  self.pixels[index] = p

