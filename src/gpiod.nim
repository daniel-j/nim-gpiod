import gpiod/libgpiod
export libgpiod

import gpiod/chip
export chip

proc main() =
  var chip = initChip("/dev/gpiochip0")

  echo chip.isOpen()

  echo chip.getInfo()

main()
