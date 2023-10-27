import ./libgpiod
import ./exception

type
  RequestConfig* = object
    config*: ptr GpiodRequestConfig

proc `=destroy`*(self: var RequestConfig) =
  gpiod_request_config_free(self.config)

proc newRequestConfig*(): RequestConfig =
  let config = gpiod_request_config_new()
  if config.isNil:
    raise newException(RequestConfigNewError, "Failed to create new request config")

  result.config = config

proc setConsumer*(self: RequestConfig; consumer: string) =
  gpiod_request_config_set_consumer(self.config, consumer.cstring)

proc getConsumer*(self: RequestConfig): string =
  let consumer = gpiod_request_config_get_consumer(self.config)
  if consumer.isNil:
    raise newException(RequestConfigGetConsumerError, "Failed to get request config consumer")

  return $consumer

proc setEventBufferSize*(self: RequestConfig; size: uint) =
  gpiod_request_config_set_event_buffer_size(self.config, size)

proc getEventBufferSize*(self: RequestConfig): uint =
  return gpiod_request_config_get_event_buffer_size(self.config)
