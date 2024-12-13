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



# example
when isMainModule:

  import std/times
  import std/os
  import std/math

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

    var blinkt = initBlinkt()
    blinkt.show()

    const SPEED = 50
    const BRIGHTNESS = 0.2
    const SPREAD = 20

    # rainbow
    while true:
      for i in 0..<numPixels:
        let h = ((getTime().toUnixFloat() * SPEED + (i.float * SPREAD)) mod 360) / 360.0
        let p = Hsv(h: h, s: 1.0, v: BRIGHTNESS).toPixel()
        blinkt.setPixel(i, p)
      blinkt.show()
      sleep(10)


  # TODO: listen for SIGINT, to turn off leds before quitting
  main()
