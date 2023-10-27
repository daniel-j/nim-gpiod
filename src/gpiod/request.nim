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

proc getValue*(self: Request; offset: Offset): Value =
  let value = gpiod_line_request_get_value(self.request, offset)
  if value != Gpiodlinevalueinactive and value != Gpiodlinevalueactive:
    raise newException(LineRequestGetValueError, "Failed to get line request value")
  return cast[Value](value)

# proc valuesSubset*(self: Request; offsets: openarray[Offset]): ValueMap =
#   var values = newSeq[GpiodLineValue](offsets.len)
#   let ret = gpiod_line_request_get_values_subset(self.request, offsets.len.csize_t, offsets[0].unsafeAddr, values[0].addr)

#   if ret < 0:
#     raise newException(LineRequestGetValSubsetError, "Failed to get request values")

#   # todo: insert values into map
