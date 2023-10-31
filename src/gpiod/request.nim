import std/tables
import ./libgpiod
import ./exception
import ./line
import ./request_config
export exception, line, request_config

type
  Request* = object
    request*: ptr GpiodLineRequest

proc newRequest*(request: ptr GpiodLineRequest): Request =
  result.request = request

proc `=destroy`*(self: var Request) =
  gpiod_line_request_release(self.request)

proc getChipName*(self: Request): string =
  let name = gpiod_line_request_get_chip_name(self.request)
  return $name

proc getNumLines*(self: Request): uint =
  return gpiod_line_request_get_num_requested_lines(self.request)

proc getOffsets*(self: Request): seq[Offset] =
  let numLines = self.getNumLines()
  var offsets = newSeq[Offset](numLines)
  let numOffsets = gpiod_line_request_get_requested_offsets(self.request, offsets[0].addr, numLines)
  offsets.setLen(numOffsets)
  return offsets

proc getRawFd*(self: Request): int =
  return gpiod_line_request_get_fd(self.request)

proc getValue*(self: Request; offset: Offset): Value =
  let value = gpiod_line_request_get_value(self.request, offset)
  if value != Gpiodlinevalueinactive and value != Gpiodlinevalueactive:
    raise newException(LineRequestGetValueError, "Failed to get line request value")
  return value

proc valuesSubset*(self: Request; offsets: openarray[Offset]): Table[Offset, Value] =
  var values = newSeq[Value](offsets.len)
  let ret = gpiod_line_request_get_values_subset(self.request, offsets.len.csize_t, offsets[0].unsafeAddr, values[0].addr)

  if ret < 0:
    raise newException(LineRequestGetValSubsetError, "Failed to get request values")

  for i, v in values:
    result[offsets[i]] = v

proc values*(self: Request): Table[Offset, Value] =
  return self.valuesSubset(self.getOffsets())

proc setValue*(self: Request; offset: Offset; value: Value) =
  let ret = gpiod_line_request_set_value(self.request, offset, value)

  if ret < 0:
    raise newException(LineRequestSetValError, "Failed to set value")

proc setValuesSubset*(self: Request; map: Table[Offset, Value]) =
  var offsets = newSeq[Offset](map.len)
  var values = newSeq[Value](map.len)

  let ret = gpiod_line_request_set_values_subset(
    self.request,
    offsets.len.cuint,
    offsets[0].addr,
    values[0].addr
  )

  if ret < 0:
    raise newException(LineRequestSetValSubsetError, "Failed to set values")

proc setValues*(self: Request; values: openarray[Value]) =
  if values.len.uint != self.getNumLines():
    raise newException(ValueError, "Invalid arguments")

  let ret = gpiod_line_request_set_values(self.request, values[0].unsafeAddr)

  if ret < 0:
    raise newException(LineRequestSetValError, "Failed to set values")

proc reconfigureLines*(self: Request; lconfig: LineConfig) =
  let ret = gpiod_line_request_reconfigure_lines(self.request, lconfig.config)

  if ret < 0:
    raise newException(LineRequestReconfigLinesError, "Failed to reconfigure lines")

proc waitEdgeEvents*(self: Request; timeout: Duration): bool =
  let ret = gpiod_line_request_wait_edge_events(self.request, timeout.inNanoseconds)

  if ret < 0:
    raise newException(LineRequestWaitEdgeEventError, "Failed to wait for edge events")
  return ret > 0

