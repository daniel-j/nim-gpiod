import std/posix
import std/os
import gpiod

type
  Brightness* = range[0.byte .. 31.byte]

const
  ButtonOnOff* = 12.Offset
  ButtonFastForward* = 5.Offset
  ButtonPlayPause* = 6.Offset
  ButtonRewind* = 13.Offset
  ButtonVolumeUp* = 16.Offset
  ButtonVolumeDown* = 26.Offset

  PinDat* = 23.Offset
  PinClk* = 24.Offset

  dataPins = [PinDat, PinClk]
  buttons = [ButtonFastForward, ButtonRewind, ButtonPlayPause, ButtonVolumeUp, ButtonVolumeDown, ButtonOnOff]

  numChannelPixels* = 8
  numPixels* = numChannelPixels * 2

  clockSleepNs = 500
  defaultBrightness* = 7.Brightness

type
  Pixel* = object
    r*: uint8
    g*: uint8
    b*: uint8
    brightness*: Brightness
  Pixels* = array[numPixels, Pixel]

  PhatBeat* = object
    chip*: Chip
    req*: Request
    pixels*: Pixels
    # eventThread: Thread[Request]

  Channel* = enum
    ChannelLeft
    ChannelRight
    ChannelBoth

proc setNanosleep(ns: int64): Timespec =
  result.tv_sec = posix.Time(ns div 1000_000_000)
  result.tv_nsec = int(ns mod 1000_000_000)

var dur = setNanosleep(clockSleepNs)
var rem: Timespec

template nanosleep() =
  #discard posix.nanosleep(dur, rem)
  # sleep(0)
  #asm "nop;"
  discard

proc initPixels(): Pixels =
  for i in 0..<result.len:
    result[i].brightness = defaultBrightness

proc writeByte(req: Request; b: byte) =
  const pins = [PinDat, PinClk]
  var data = [GPIOD_LINE_VALUE_INACTIVE, GPIOD_LINE_VALUE_ACTIVE]

  for i in 0..<8:
    data[0] = if ((b and (1'u8 shl (7-i))) != 0): GPIOD_LINE_VALUE_ACTIVE else: GPIOD_LINE_VALUE_INACTIVE
    req.setValuesSubset(pins, data)
    nanosleep()
    req.setValue(PinClk, GPIOD_LINE_VALUE_INACTIVE)
    nanosleep()

proc startFrame(req: Request) =
  req.setValue(PinDat, GPIOD_LINE_VALUE_INACTIVE)
  for i in 0..<32:
    req.setValue(PinClk, GPIOD_LINE_VALUE_ACTIVE)
    nanosleep()
    req.setValue(PinClk, GPIOD_LINE_VALUE_INACTIVE)
    nanosleep()

proc endFrame(req: Request) =
  req.setValue(PinDat, GPIOD_LINE_VALUE_ACTIVE)
  for i in 0..<32:
    req.setValue(PinClk, GPIOD_LINE_VALUE_ACTIVE)
    nanosleep()
    req.setValue(PinClk, GPIOD_LINE_VALUE_INACTIVE)
    nanosleep()

proc setup(chip: Chip): Request =
  var lineCfg = newLineConfig()

  var settings = newLineSettings()

  # data pins
  settings.direction = GPIOD_LINE_DIRECTION_OUTPUT
  lineCfg.addLineSettings(dataPins, settings)

  # buttons
  settings.direction = GPIOD_LINE_DIRECTION_INPUT
  settings.bias = GPIOD_LINE_BIAS_PULL_UP
  settings.edgeDetection = GPIOD_LINE_EDGE_FALLING
  settings.debouncePeriod = initDuration(milliseconds = 200)
  lineCfg.addLineSettings(buttons, settings)

  var reqCfg = newRequestConfig()
  reqCfg.consumer = "phat-beat"
  # echo reqCfg
  # echo lineCfg

  return chip.requestLines(reqCfg, lineCfg)

# proc eventThreadFunc(req: Request) {.thread.} =
#   var eventBuffer = newEdgeEventBuffer(10)
#   echo "waiting for events"
#   while true:
#     let eventPending = req.waitEdgeEvents(initDuration(seconds = 5))
#     if not eventPending: continue
#     echo "events!"
#     let ln = req.readEdgeEvents(eventBuffer, eventBuffer.capacity)
#     echo (ln, eventBuffer.len)
#     for i in 0..<eventBuffer.len:
#       echo eventBuffer[i]

proc initPhatBeat*(): PhatBeat =
  result.chip = Chip.open("/dev/gpiochip0")
  result.req = setup(result.chip)
  result.pixels = initPixels()

  # createThread(result.eventThread, eventThreadFunc, result.req)

iterator pixelChannels*(self: var PhatBeat; channel: Channel = ChannelBoth): var Pixel =
  let lowPixel = if channel == ChannelRight: numChannelPixels else: 0
  let highPixel = if channel == ChannelLeft: numChannelPixels else: numChannelPixels * 2
  for i in lowPixel..<highPixel:
    yield self.pixels[i]

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
  var index = if channel == ChannelRight: index + numChannelPixels else: index
  self.pixels[index] = p
  if channel == ChannelBoth:
    self.pixels[index + numChannelPixels] = p

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
  startFrame(self.req)

  for i in countdown(self.pixels.len - 1, self.pixels.len div 2):
    let pixel = self.pixels[i]
    writeByte(self.req, 0b11100000.byte or pixel.brightness)
    writeByte(self.req, pixel.b)
    writeByte(self.req, pixel.g)
    writeByte(self.req, pixel.r)

  for i in countup(0, self.pixels.len div 2 - 1):
    let pixel = self.pixels[i]
    writeByte(self.req, 0b11100000.byte or pixel.brightness)
    writeByte(self.req, pixel.b)
    writeByte(self.req, pixel.g)
    writeByte(self.req, pixel.r)

  endFrame(self.req)
  # echo "show: ", now() - st






# example

import std/times
import std/math
import std/streams
import std/strutils

type
  Hsv* = object
    h*, s*, v*: float

func constructPixel*(r, g, b: float): Pixel =
  result.r = uint8 round(r * 255.0f)
  result.g = uint8 round(g * 255.0f)
  result.b = uint8 round(b * 255.0f)
  result.brightness = defaultBrightness

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

  # $ gcc -Wall examples/pw-capture.c -o examples/pw-capture $(pkg-config --cflags --libs libpipewire-0.3) -lm
  # $ examples/pw-capture | nim c -r examples/phat_beat

  var vuf = newFileStream("/dev/stdin")
  defer: close(vuf)

  var peaks: array[2, float]
  var beat: PhatBeat
  try:
    beat = initPhatBeat()
  except:
    discard

  let green = Pixel(
    g: 255,
    brightness: 1
  )

  var lastUpdate = getTime()

  while not vuf.atEnd:
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
      echo peaks
      let t = initTime(tv_sec, tv_usec * 1_000)
      if t - lastUpdate >= initDuration(milliseconds = 5):
        lastUpdate = getTime()
        echo "update leds"
        beat.show()
        #sleep(300)
    peaks[channel] *= 0.93


  const SPEED = 50
  const BRIGHTNESS = 64
  const SPREAD = 20

  # rainbow
  while true:
    for i in 0..<numPixels:
      let h = ((getTime().toUnixFloat() * SPEED + (i.float * SPREAD)) mod 360) / 360.0
      let p = Hsv(h: h, s: 1.0, v: BRIGHTNESS / 1.0).toPixel()
      beat.setPixel(i, p)
    beat.show()
    sleep(5)

when isMainModule:
  # TODO: listen for SIGINT, to turn off leds before quitting
  main()
