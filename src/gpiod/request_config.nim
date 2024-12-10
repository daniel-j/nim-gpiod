import std/strformat
import ./libgpiod
import ./exception

export exception

type
  RequestConfig* = object
    config: ptr GpiodRequestConfig

proc `=copy`(dest: var RequestConfig; source: RequestConfig) {.error.}
proc `=destroy`*(self: var RequestConfig) =
  echo "free request config"
  gpiod_request_config_free(self.config)

proc newRequestConfig*(): RequestConfig =
  let config = gpiod_request_config_new()
  if config.isNil:
    raise newException(RequestConfigNewError, "Failed to create new request config")

  result.config = config

proc getPtr*(self: RequestConfig): ptr GpiodRequestConfig {.inline.} =
  return self.config

proc `consumer=`*(self: RequestConfig; consumer: string) =
  gpiod_request_config_set_consumer(self.config, consumer.cstring)
proc consumer*(self: RequestConfig): string =
  return $gpiod_request_config_get_consumer(self.config)

proc `eventBufferSize=`*(self: RequestConfig; size: uint) =
  gpiod_request_config_set_event_buffer_size(self.config, size)
proc eventBufferSize*(self: RequestConfig): uint =
  return gpiod_request_config_get_event_buffer_size(self.config)

proc `$`*(self: RequestConfig): string =
  return &"RequestConfig(consumer: {repr self.consumer}, eventBufferSize: {self.eventBufferSize})"
