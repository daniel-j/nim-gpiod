type
  OpenChipError* = object of CatchableError
  ChipClosedError* = object of CatchableError
  RequestReleasedError* = object of CatchableError
