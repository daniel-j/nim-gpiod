type
  ChipOpenError* = object of CatchableError
  ChipGetInfoError* = object of CatchableError
  ChipLineInfoError* = object of CatchableError
  ChipWaitInfoEventError* = object of CatchableError
  ChipReadInfoEventError* = object of CatchableError
  ChipGetLineOffsetFromNameError* = object of CatchableError
  ChipRequestLinesError* = object of CatchableError
  RequestConfigNewError* = object of CatchableError
  RequestConfigGetConsumerError* = object of CatchableError
  LineConfigNewError* = object of CatchableError
  LineConfigAddLineSettingsError* = object of CatchableError
  LineConfigSetOutputValuesError* = object of CatchableError
  LineSettingsNewError* = object of CatchableError
  LineRequestGetValueError* = object of CatchableError
  LineRequestGetValSubsetError* = object of CatchableError
  LineRequestSetValError* = object of CatchableError
  LineRequestSetValSubsetError* = object of CatchableError
  LineRequestReconfigLinesError* = object of CatchableError
  LineRequestWaitEdgeEventError* = object of CatchableError
  EdgeEventNewError* = object of CatchableError
  EdgeEventBufferNewError* = object of CatchableError
  EdgeEventBufferGetEventError* = object of CatchableError
  InfoEventNewError* = object of CatchableError
