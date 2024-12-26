# pimoroni blinkt is simply eight apa102 rgb leds
# this file can be used as library or compiled as binary
# see example at the end of file

import gpiod/devices/apa102

export apa102

const
  numPixels* = 8

  PinDat = 23.Offset
  PinClk = 24.Offset

type
  Blinkt* = Apa102

proc initBlinkt*(): Blinkt =
  let chip = openChip("/dev/gpiochip0")
  result = Blinkt(initApa102(chip, numPixels, PinDat, PinClk))

proc setBar*(self: var Blinkt; value: float; p: Pixel) =
  let midpoint = value * numPixels
  for i in 0..<numPixels:
    var pixel = Pixel(header: 0b111)
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
    self.setPixel(i, pixel)


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
    result.header = 0b111

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

    var blinkt = initBlinkt()
    blinkt.show()

    # $ gcc -Wall examples/pw-capture.c -o examples/pw-capture $(pkg-config --cflags --libs libpipewire-0.3) -lm
    # $ examples/pw-capture | nim c -r examples/phat_beat

    let vup = startProcess("examples/pw-capture")
    let vuf = vup.outputStream()

    # var vuf = newFileStream("/dev/stdin")
    # defer: close(vuf)

    var peaks: array[2, float]

    let green = Pixel(
      g: 255,
      brightness: 1,
      header: 0b111
    )

    const SPEED = 50
    const BRIGHTNESS = 0.2
    const SPREAD = 20

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
      if channel == 1:
        blinkt.setBar(peaks[1], green)
        let t = initTime(tv_sec, tv_usec * 1_000)
        if t - lastUpdate >= initDuration(milliseconds = 1000 div 30):
          lastUpdate = getTime()
          echo "update leds ", peaks
          if peaks[0] < 0.001 and peaks[1] < 0.001:
            # rainbow
            for i in 0..<numPixels:
              let h = ((getTime().toUnixFloat() * SPEED + (i.float * SPREAD)) mod 360) / 360.0
              let p = Hsv(h: h, s: 1.0, v: BRIGHTNESS).toPixel()
              blinkt.setPixel(i, p)
          blinkt.show()

          #sleep(100)
      peaks[channel] *= 0.93


  # TODO: listen for SIGINT, to turn off leds before quitting
  main()

