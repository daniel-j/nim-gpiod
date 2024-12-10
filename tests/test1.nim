
import gpiod

proc main() =
  try:
    var chip = Chip.open("/dev/gpiochip0")

    echo chip.getInfo()

  except ChipOpenError:
    echo "Couldn't open chip!"

main()
