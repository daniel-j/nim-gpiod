import std/tables, std/strformat
import ./exception
import ./line_info
import ./line_config
import ./request_config
import ./edge_event
import ./libgpiod

export exception, tables, line_info, line_config, request_config, edge_event

type
  Request* = object
    request: ptr GpiodLineRequest

proc newRequest*(request: ptr GpiodLineRequest): Request =
  result.request = request

proc `=copy`(dest: var Request; source: Request) {.error.}
proc `=destroy`*(self: var Request) =
  echo "free line request"
  gpiod_line_request_release(self.request)

proc chipName*(self: Request): string =
  return $gpiod_line_request_get_chip_name(self.request)

proc numLines*(self: Request): int =
  return gpiod_line_request_get_num_requested_lines(self.request).int

proc getOffsets*(self: Request): seq[Offset] =
  result = newSeq[Offset](self.numLines())
  if result.len > 0:
    let numOffsets = gpiod_line_request_get_requested_offsets(self.request, result[0].addr, result.len.csize_t)
    result.setLen(numOffsets)

proc rawFd*(self: Request): int =
  return gpiod_line_request_get_fd(self.request)

proc getValue*(self: Request; offset: Offset): Value =
  let value = gpiod_line_request_get_value(self.request, offset)
  if value != Gpiodlinevalueinactive and value != Gpiodlinevalueactive:
    raise newException(LineRequestGetValueError, "Failed to get line request value")
  return value

proc getValues*(self: Request; offsets: openarray[Offset]): Table[Offset, Value] =
  var values = newSeq[Value](offsets.len)
  let ret = gpiod_line_request_get_values_subset(self.request, offsets.len.csize_t, offsets[0].unsafeAddr, values[0].addr)

  if ret < 0:
    raise newException(LineRequestGetValSubsetError, "Failed to get request values")

  for i, v in values:
    result[offsets[i]] = v

proc getValues*(self: Request): Table[Offset, Value] =
  return self.getValues(self.getOffsets())

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

proc setValuesSubset*(self: Request; offsets: openarray[Offset], values: openarray[Value]) =
  assert(offsets.len == values.len and offsets.len > 0)
  let ret = gpiod_line_request_set_values_subset(
    self.request,
    offsets.len.cuint,
    offsets[0].unsafeAddr,
    values[0].unsafeAddr
  )

  if ret < 0:
    raise newException(LineRequestSetValSubsetError, "Failed to set values")

proc setValues*(self: Request; values: openarray[Value]) =
  if values.len != self.numLines():
    raise newException(ValueError, "Invalid arguments")

  let ret = gpiod_line_request_set_values(self.request, values[0].unsafeAddr)

  if ret < 0:
    raise newException(LineRequestSetValError, "Failed to set values")

proc reconfigureLines*(self: Request; lconfig: LineConfig) =
  let ret = gpiod_line_request_reconfigure_lines(self.request, lconfig.getPtr())

  if ret < 0:
    raise newException(LineRequestReconfigLinesError, "Failed to reconfigure lines")

proc waitEdgeEvents*(self: Request; timeout: Duration): bool =
  let ret = gpiod_line_request_wait_edge_events(self.request, timeout.inNanoseconds)

  if ret < 0:
    raise newException(LineRequestWaitEdgeEventError, "Failed to wait for edge events")
  return ret > 0

proc readEdgeEvents*(self: Request; buffer: EdgeEventBuffer; maxEvents: int): int =
  return gpiod_line_request_read_edge_events(self.request, buffer.getPtr(), maxEvents.csize_t)

proc `$`*(self: Request): string =
  return &"Request(chip: {self.chipName}, offsets: {self.getOffsets()}, rawFd: {self.rawFd}, values: {self.getValues()})"
