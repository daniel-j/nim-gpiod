
import gpiod

const
  ButtonOnOff* = 12.Offset
  ButtonFastForward* = 5.Offset
  ButtonPlayPause* = 6.Offset
  ButtonRewind* = 13.Offset
  ButtonVolumeUp* = 16.Offset
  ButtonVolumeDown* = 26.Offset

  buttons = [ButtonFastForward, ButtonRewind, ButtonPlayPause, ButtonVolumeUp, ButtonVolumeDown, ButtonOnOff]

proc main() =
  let chip = Chip.open("/dev/gpiochip0")

  echo chip

  echo chip.getInfo()
  block:
    let line = chip.getLineInfo(ButtonFastForward)
    echo line
  
  let req = block:
    var settings = newLineSettings()
    settings.direction = GPIOD_LINE_DIRECTION_INPUT
    settings.bias = GPIOD_LINE_BIAS_PULL_UP
    settings.edgeDetection = GPIOD_LINE_EDGE_FALLING
    settings.debouncePeriod = initDuration(milliseconds = 10)
    echo settings
    var lineCfg = newLineConfig()
    lineCfg.addLineSettings(buttons, settings)
    echo lineCfg
    var reqCfg = newRequestConfig()
    reqCfg.consumer = "phat-beat"
    echo reqCfg
    chip.requestLines(reqCfg, lineCfg)

  echo req.getValue(ButtonFastForward)
  echo req

  var eventBuffer = newEdgeEventBuffer(10)

  while true:
    let eventPending = req.waitEdgeEvents(initDuration(seconds = 5))
    if not eventPending: continue
    echo "events!"
    let l = req.readEdgeEvents(eventBuffer, eventBuffer.capacity)
    echo (l, eventBuffer.len)
    for i in 0..<eventBuffer.len:
      echo eventBuffer[i]

main()
