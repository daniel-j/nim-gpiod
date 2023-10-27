type
  OpenChipError* = object of CatchableError
  ChipGetInfoError* = object of CatchableError
  ChipLineInfoError* = object of CatchableError
  ChipWaitInfoEventError* = object of CatchableError
  ChipReadInfoEventError* = object of CatchableError
  ChipGetLineOffsetFromNameError* = object of CatchableError
  RequestReleasedError* = object of CatchableError
