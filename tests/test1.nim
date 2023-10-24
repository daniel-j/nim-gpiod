
import gpiod

proc main() =
  var chip = initChip("/dev/gpiochip0")

  echo chip.isOpen()

  echo chip.getInfo()

main()
