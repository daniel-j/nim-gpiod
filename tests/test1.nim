
import gpiod

proc main() =
  try:
    var chip = openChip("/dev/gpiochip0")

    echo chip.getInfo()

  except ChipOpenError:
    echo "Couldn't open chip!"

main()
