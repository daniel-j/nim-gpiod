# pimoroni phat beat / pirate radio
# has 16 apa102 rgb leds, in two channels of eight each
# has six buttons

import gpiod/devices/apa102

export apa102, edge_event

const
  numChannelPixels* = 8
  numPixels* = numChannelPixels * 2

  PinDat = 23.Offset
  PinClk = 24.Offset

  ButtonOnOff* = 12.Offset
  ButtonFastForward* = 5.Offset
  ButtonPlayPause* = 6.Offset
  ButtonRewind* = 13.Offset
  ButtonVolumeUp* = 16.Offset
  ButtonVolumeDown* = 26.Offset

  buttons* = [ButtonFastForward, ButtonRewind, ButtonPlayPause, ButtonVolumeUp, ButtonVolumeDown, ButtonOnOff]

type
  PhatBeat* = object
    req*: Request
    eventBuffer*: EdgeEventBuffer
    leds*: Apa102

  Channel* = enum
    ChannelLeft
    ChannelRight
    ChannelBoth

proc `=copy`(dest: var PhatBeat; source: PhatBeat) {.error.}

proc setup(chip: Chip): Request =
  var lineCfg = newLineConfig()

  var settings = newLineSettings()

  # buttons
  settings.direction = GPIOD_LINE_DIRECTION_INPUT
  settings.bias = GPIOD_LINE_BIAS_PULL_UP
  settings.edgeDetection = GPIOD_LINE_EDGE_BOTH
  settings.debouncePeriod = initDuration(milliseconds = 30)
  lineCfg.addLineSettings(buttons, settings)

  var reqCfg = newRequestConfig()
  reqCfg.consumer = "phat-beat-buttons"

  return chip.requestLines(reqCfg, lineCfg)

proc initPhatBeat*(): PhatBeat =
  let chip = openChip("/dev/gpiochip0")
  result.leds = initApa102(chip, numPixels, PinDat, PinClk)
  result.req = setup(chip)
  result.eventBuffer = newEdgeEventBuffer(10)

iterator pixelChannels*(self: var PhatBeat; channel: Channel = ChannelBoth): var Pixel =
  let lowPixel = if channel == ChannelRight: numChannelPixels else: 0
  let highPixel = if channel == ChannelLeft: numChannelPixels else: numChannelPixels * 2
  for i in lowPixel..<highPixel:
    yield self.leds.pixels[i]

proc setBrightness*(self: var PhatBeat; brightness: Brightness; channel: Channel = ChannelBoth) =
  for pixel in self.pixelChannels(channel):
    pixel.brightness = brightness

proc clear*(self: var PhatBeat; channel: Channel = ChannelBoth) =
  for pixel in self.pixelChannels(channel):
    pixel.r = 0
    pixel.g = 0
    pixel.b = 0

proc setAll*(self: var PhatBeat; p: Pixel; channel: Channel = ChannelBoth) =
  for pixel in self.pixelChannels(channel):
    pixel = p

proc setPixel*(self: var PhatBeat; index: int; p: Pixel; channel: Channel = ChannelLeft) =
  if index < 0 or index >= self.leds.pixels.len: return
  var index = if channel == ChannelRight: index + numChannelPixels else: index
  self.leds.pixels[index] = p
  if channel == ChannelBoth:
    self.leds.pixels[index + numChannelPixels] = p

proc setBar*(self: var PhatBeat; value: float; p: Pixel; channel: Channel = ChannelBoth) =
  let midpoint = value * numChannelPixels
  for i in 0..<numChannelPixels:
    var pixel = Pixel()
    if i < int(midpoint):
      pixel = p
    elif i < int(midpoint + 1):
      pixel = p
      let level = midpoint - float(int(midpoint))
      pixel.r = uint8 pixel.r.float * level
      pixel.g = uint8 pixel.g.float * level
      pixel.b = uint8 pixel.b.float * level
    else:
      discard
    self.setPixel(i, pixel, channel)

proc show*(self: PhatBeat) =
  # let st = now()
  self.leds.show()
  # echo "show: ", now() - st

proc readEvents*(self: var PhatBeat): bool =
  if not self.req.waitEdgeEvents(initDuration(seconds = 0)):
    return false
  let ln = self.req.readEdgeEvents(self.eventBuffer, 10)
  return ln > 0





# example
when isMainModule:
  import std/times
  import std/math
  import std/osproc
  import std/streams
  import std/strutils

  type
    Hsv* = object
      h*, s*, v*: float

  func constructPixel*(r, g, b: float): Pixel =
    result.r = uint8 round(r * 255.0f)
    result.g = uint8 round(g * 255.0f)
    result.b = uint8 round(b * 255.0f)
    result.brightness = 1

  func toPixel*(hsv: Hsv): Pixel =
    ## Converts from HSV to Pixel
    ## HSV values are between 0.0 and 1.0
    let s = hsv.s
    let v = hsv.v
    if s <= 0.0:
      return constructPixel(v, v, v)

    let h = hsv.h

    let i = int(h * 6.0f)
    let f = h * 6.0f - float32(i)
    let p = v * (1.0f - s)
    let q = v * (1.0f - f * s)
    let t = v * (1.0f - (1.0f - f) * s)

    case i mod 6:
      of 0: return constructPixel(v, t, p)
      of 1: return constructPixel(q, v, p)
      of 2: return constructPixel(p, v, t)
      of 3: return constructPixel(p, q, v)
      of 4: return constructPixel(t, p, v)
      of 5: return constructPixel(v, p, q)
      else: return constructPixel(0, 0, 0)

  proc main() =
    var beat = initPhatBeat()

    # $ gcc -Wall examples/pw-capture.c -o examples/pw-capture $(pkg-config --cflags --libs libpipewire-0.3) -lm
    # $ examples/pw-capture | nim c -r examples/phat_beat

    let vup = startProcess("examples/pw-capture")
    let vuf = vup.outputStream()

    # var vuf = newFileStream("/dev/stdin")
    # defer: close(vuf)

    var peaks: array[2, float]

    let green = Pixel(
      g: 255,
      brightness: 1
    )

    const SPEED = 50
    const BRIGHTNESS = 0.2
    const SPREAD = 20

    var lastUpdate = getTime()

    while not vuf.atEnd:
      if beat.readEvents():
        for event in beat.eventBuffer.items:
          echo event

      let line = vuf.readLine().split(", ")
      if line.len != 4: continue
      let tv_sec = parseInt(line[0])
      let tv_usec = parseInt(line[1])
      let channel = parseInt(line[2])
      var peak = parseFloat(line[3])
      peak = clamp((20 * log10(peak) + 48) / 48, 0, 1)
      peaks[channel] = max(peak, peaks[channel])
      if channel == 0:
        beat.setBar(peaks[channel], green, ChannelLeft)
      if channel == 1:
        beat.setBar(peaks[channel], green, ChannelRight)
        let t = initTime(tv_sec, tv_usec * 1_000)
        if t - lastUpdate >= initDuration(milliseconds = 1000 div 30):
          lastUpdate = getTime()
          echo "update leds ", peaks
          if peaks[0] < 0.001 and peaks[1] < 0.001:
            # rainbow
            for i in 0..<numPixels:
              let h = ((getTime().toUnixFloat() * SPEED + (i.float * SPREAD)) mod 360) / 360.0
              let p = Hsv(h: h, s: 1.0, v: BRIGHTNESS).toPixel()
              beat.setPixel(i, p)
          beat.show()

          #sleep(100)
      peaks[channel] *= 0.93


  # TODO: listen for SIGINT, to turn off leds before quitting
  main()
