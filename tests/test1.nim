
import gpiod

proc main() =
  try:
    var chip = Chip.open("/dev/gpiochip0")

    echo chip.isOpen()

    echo chip.getInfo()

  except OpenChipError:
    echo "Couldn't open chip!"

main()
