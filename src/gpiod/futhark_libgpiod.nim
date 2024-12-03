
type
  Gpiod_line_value* {.size: sizeof(cint).} = enum
    GPIOD_LINE_VALUE_ERROR = -1, GPIOD_LINE_VALUE_INACTIVE = 0,
    GPIOD_LINE_VALUE_ACTIVE = 1
type
  Gpiod_line_direction* {.size: sizeof(cuint).} = enum
    GPIOD_LINE_DIRECTION_AS_IS = 1, GPIOD_LINE_DIRECTION_INPUT = 2,
    GPIOD_LINE_DIRECTION_OUTPUT = 3
type
  Gpiod_line_edge* {.size: sizeof(cuint).} = enum
    GPIOD_LINE_EDGE_NONE = 1, GPIOD_LINE_EDGE_RISING = 2,
    GPIOD_LINE_EDGE_FALLING = 3, GPIOD_LINE_EDGE_BOTH = 4
type
  Gpiod_line_bias* {.size: sizeof(cuint).} = enum
    GPIOD_LINE_BIAS_AS_IS = 1, GPIOD_LINE_BIAS_UNKNOWN = 2,
    GPIOD_LINE_BIAS_DISABLED = 3, GPIOD_LINE_BIAS_PULL_UP = 4,
    GPIOD_LINE_BIAS_PULL_DOWN = 5
type
  Gpiod_line_drive* {.size: sizeof(cuint).} = enum
    GPIOD_LINE_DRIVE_PUSH_PULL = 1, GPIOD_LINE_DRIVE_OPEN_DRAIN = 2,
    GPIOD_LINE_DRIVE_OPEN_SOURCE = 3
type
  Gpiod_line_clock* {.size: sizeof(cuint).} = enum
    GPIOD_LINE_CLOCK_MONOTONIC = 1, GPIOD_LINE_CLOCK_REALTIME = 2,
    GPIOD_LINE_CLOCK_HTE = 3
type
  Gpiod_info_event_type* {.size: sizeof(cuint).} = enum
    GPIOD_INFO_EVENT_LINE_REQUESTED = 1, GPIOD_INFO_EVENT_LINE_RELEASED = 2,
    GPIOD_INFO_EVENT_LINE_CONFIG_CHANGED = 3
type
  Gpiod_edge_event_type* {.size: sizeof(cuint).} = enum
    GPIOD_EDGE_EVENT_RISING_EDGE = 1, GPIOD_EDGE_EVENT_FALLING_EDGE = 2
type
  Gpiod_line_settings* = object
type
  Gpiod_edge_event_buffer* = object
type
  Gpiod_info_event* = object
type
  Gpiod_chip* = object
type
  Gpiod_line_info* = object
type
  Gpiod_edge_event* = object
type
  Gpiod_line_config* = object
type
  Gpiod_line_request* = object
type
  Gpiod_chip_info* = object
type
  Gpiod_request_config* = object
proc gpiod_chip_open*(path: cstring): ptr Gpiod_chip {.cdecl,
    importc: "gpiod_chip_open".}
proc gpiod_chip_close*(chip: ptr Gpiod_chip): void {.cdecl,
    importc: "gpiod_chip_close".}
proc gpiod_chip_get_info*(chip: ptr Gpiod_chip): ptr Gpiod_chip_info {.cdecl,
    importc: "gpiod_chip_get_info".}
proc gpiod_chip_get_path*(chip: ptr Gpiod_chip): cstring {.cdecl,
    importc: "gpiod_chip_get_path".}
proc gpiod_chip_get_line_info*(chip: ptr Gpiod_chip; offset: cuint): ptr Gpiod_line_info {.
    cdecl, importc: "gpiod_chip_get_line_info".}
proc gpiod_chip_watch_line_info*(chip: ptr Gpiod_chip; offset: cuint): ptr Gpiod_line_info {.
    cdecl, importc: "gpiod_chip_watch_line_info".}
proc gpiod_chip_unwatch_line_info*(chip: ptr Gpiod_chip; offset: cuint): cint {.
    cdecl, importc: "gpiod_chip_unwatch_line_info".}
proc gpiod_chip_get_fd*(chip: ptr Gpiod_chip): cint {.cdecl,
    importc: "gpiod_chip_get_fd".}
proc gpiod_chip_wait_info_event*(chip: ptr Gpiod_chip; timeout_ns: int64): cint {.
    cdecl, importc: "gpiod_chip_wait_info_event".}
proc gpiod_chip_read_info_event*(chip: ptr Gpiod_chip): ptr Gpiod_info_event {.
    cdecl, importc: "gpiod_chip_read_info_event".}
proc gpiod_chip_get_line_offset_from_name*(chip: ptr Gpiod_chip; name: cstring): cint {.
    cdecl, importc: "gpiod_chip_get_line_offset_from_name".}
proc gpiod_chip_request_lines*(chip: ptr Gpiod_chip;
                               req_cfg: ptr Gpiod_request_config;
                               line_cfg: ptr Gpiod_line_config): ptr Gpiod_line_request {.
    cdecl, importc: "gpiod_chip_request_lines".}
proc gpiod_chip_info_free*(info: ptr Gpiod_chip_info): void {.cdecl,
    importc: "gpiod_chip_info_free".}
proc gpiod_chip_info_get_name*(info: ptr Gpiod_chip_info): cstring {.cdecl,
    importc: "gpiod_chip_info_get_name".}
proc gpiod_chip_info_get_label*(info: ptr Gpiod_chip_info): cstring {.cdecl,
    importc: "gpiod_chip_info_get_label".}
proc gpiod_chip_info_get_num_lines*(info: ptr Gpiod_chip_info): csize_t {.cdecl,
    importc: "gpiod_chip_info_get_num_lines".}
proc gpiod_line_info_free*(info: ptr Gpiod_line_info): void {.cdecl,
    importc: "gpiod_line_info_free".}
proc gpiod_line_info_copy*(info: ptr Gpiod_line_info): ptr Gpiod_line_info {.
    cdecl, importc: "gpiod_line_info_copy".}
proc gpiod_line_info_get_offset*(info: ptr Gpiod_line_info): cuint {.cdecl,
    importc: "gpiod_line_info_get_offset".}
proc gpiod_line_info_get_name*(info: ptr Gpiod_line_info): cstring {.cdecl,
    importc: "gpiod_line_info_get_name".}
proc gpiod_line_info_is_used*(info: ptr Gpiod_line_info): bool {.cdecl,
    importc: "gpiod_line_info_is_used".}
proc gpiod_line_info_get_consumer*(info: ptr Gpiod_line_info): cstring {.cdecl,
    importc: "gpiod_line_info_get_consumer".}
proc gpiod_line_info_get_direction*(info: ptr Gpiod_line_info): Gpiod_line_direction {.
    cdecl, importc: "gpiod_line_info_get_direction".}
proc gpiod_line_info_get_edge_detection*(info: ptr Gpiod_line_info): Gpiod_line_edge {.
    cdecl, importc: "gpiod_line_info_get_edge_detection".}
proc gpiod_line_info_get_bias*(info: ptr Gpiod_line_info): Gpiod_line_bias {.
    cdecl, importc: "gpiod_line_info_get_bias".}
proc gpiod_line_info_get_drive*(info: ptr Gpiod_line_info): Gpiod_line_drive {.
    cdecl, importc: "gpiod_line_info_get_drive".}
proc gpiod_line_info_is_active_low*(info: ptr Gpiod_line_info): bool {.cdecl,
    importc: "gpiod_line_info_is_active_low".}
proc gpiod_line_info_is_debounced*(info: ptr Gpiod_line_info): bool {.cdecl,
    importc: "gpiod_line_info_is_debounced".}
proc gpiod_line_info_get_debounce_period_us*(info: ptr Gpiod_line_info): culong {.
    cdecl, importc: "gpiod_line_info_get_debounce_period_us".}
proc gpiod_line_info_get_event_clock*(info: ptr Gpiod_line_info): Gpiod_line_clock {.
    cdecl, importc: "gpiod_line_info_get_event_clock".}
proc gpiod_info_event_free*(event: ptr Gpiod_info_event): void {.cdecl,
    importc: "gpiod_info_event_free".}
proc gpiod_info_event_get_event_type*(event: ptr Gpiod_info_event): Gpiod_info_event_type {.
    cdecl, importc: "gpiod_info_event_get_event_type".}
proc gpiod_info_event_get_timestamp_ns*(event: ptr Gpiod_info_event): uint64 {.
    cdecl, importc: "gpiod_info_event_get_timestamp_ns".}
proc gpiod_info_event_get_line_info*(event: ptr Gpiod_info_event): ptr Gpiod_line_info {.
    cdecl, importc: "gpiod_info_event_get_line_info".}
proc gpiod_line_settings_new*(): ptr Gpiod_line_settings {.cdecl,
    importc: "gpiod_line_settings_new".}
proc gpiod_line_settings_free*(settings: ptr Gpiod_line_settings): void {.cdecl,
    importc: "gpiod_line_settings_free".}
proc gpiod_line_settings_reset*(settings: ptr Gpiod_line_settings): void {.
    cdecl, importc: "gpiod_line_settings_reset".}
proc gpiod_line_settings_copy*(settings: ptr Gpiod_line_settings): ptr Gpiod_line_settings {.
    cdecl, importc: "gpiod_line_settings_copy".}
proc gpiod_line_settings_set_direction*(settings: ptr Gpiod_line_settings;
                                        direction: Gpiod_line_direction): cint {.
    cdecl, importc: "gpiod_line_settings_set_direction".}
proc gpiod_line_settings_get_direction*(settings: ptr Gpiod_line_settings): Gpiod_line_direction {.
    cdecl, importc: "gpiod_line_settings_get_direction".}
proc gpiod_line_settings_set_edge_detection*(settings: ptr Gpiod_line_settings;
    edge: Gpiod_line_edge): cint {.cdecl, importc: "gpiod_line_settings_set_edge_detection".}
proc gpiod_line_settings_get_edge_detection*(settings: ptr Gpiod_line_settings): Gpiod_line_edge {.
    cdecl, importc: "gpiod_line_settings_get_edge_detection".}
proc gpiod_line_settings_set_bias*(settings: ptr Gpiod_line_settings;
                                   bias: Gpiod_line_bias): cint {.cdecl,
    importc: "gpiod_line_settings_set_bias".}
proc gpiod_line_settings_get_bias*(settings: ptr Gpiod_line_settings): Gpiod_line_bias {.
    cdecl, importc: "gpiod_line_settings_get_bias".}
proc gpiod_line_settings_set_drive*(settings: ptr Gpiod_line_settings;
                                    drive: Gpiod_line_drive): cint {.cdecl,
    importc: "gpiod_line_settings_set_drive".}
proc gpiod_line_settings_get_drive*(settings: ptr Gpiod_line_settings): Gpiod_line_drive {.
    cdecl, importc: "gpiod_line_settings_get_drive".}
proc gpiod_line_settings_set_active_low*(settings: ptr Gpiod_line_settings;
    active_low: bool): void {.cdecl,
                              importc: "gpiod_line_settings_set_active_low".}
proc gpiod_line_settings_get_active_low*(settings: ptr Gpiod_line_settings): bool {.
    cdecl, importc: "gpiod_line_settings_get_active_low".}
proc gpiod_line_settings_set_debounce_period_us*(
    settings: ptr Gpiod_line_settings; period: culong): void {.cdecl,
    importc: "gpiod_line_settings_set_debounce_period_us".}
proc gpiod_line_settings_get_debounce_period_us*(
    settings: ptr Gpiod_line_settings): culong {.cdecl,
    importc: "gpiod_line_settings_get_debounce_period_us".}
proc gpiod_line_settings_set_event_clock*(settings: ptr Gpiod_line_settings;
    event_clock: Gpiod_line_clock): cint {.cdecl,
    importc: "gpiod_line_settings_set_event_clock".}
proc gpiod_line_settings_get_event_clock*(settings: ptr Gpiod_line_settings): Gpiod_line_clock {.
    cdecl, importc: "gpiod_line_settings_get_event_clock".}
proc gpiod_line_settings_set_output_value*(settings: ptr Gpiod_line_settings;
    value: Gpiod_line_value): cint {.cdecl, importc: "gpiod_line_settings_set_output_value".}
proc gpiod_line_settings_get_output_value*(settings: ptr Gpiod_line_settings): Gpiod_line_value {.
    cdecl, importc: "gpiod_line_settings_get_output_value".}
proc gpiod_line_config_new*(): ptr Gpiod_line_config {.cdecl,
    importc: "gpiod_line_config_new".}
proc gpiod_line_config_free*(config: ptr Gpiod_line_config): void {.cdecl,
    importc: "gpiod_line_config_free".}
proc gpiod_line_config_reset*(config: ptr Gpiod_line_config): void {.cdecl,
    importc: "gpiod_line_config_reset".}
proc gpiod_line_config_add_line_settings*(config: ptr Gpiod_line_config;
    offsets: ptr cuint; num_offsets: csize_t; settings: ptr Gpiod_line_settings): cint {.
    cdecl, importc: "gpiod_line_config_add_line_settings".}
proc gpiod_line_config_get_line_settings*(config: ptr Gpiod_line_config;
    offset: cuint): ptr Gpiod_line_settings {.cdecl,
    importc: "gpiod_line_config_get_line_settings".}
proc gpiod_line_config_set_output_values*(config: ptr Gpiod_line_config;
    values: ptr Gpiod_line_value; num_values: csize_t): cint {.cdecl,
    importc: "gpiod_line_config_set_output_values".}
proc gpiod_line_config_get_num_configured_offsets*(config: ptr Gpiod_line_config): csize_t {.
    cdecl, importc: "gpiod_line_config_get_num_configured_offsets".}
proc gpiod_line_config_get_configured_offsets*(config: ptr Gpiod_line_config;
    offsets: ptr cuint; max_offsets: csize_t): csize_t {.cdecl,
    importc: "gpiod_line_config_get_configured_offsets".}
proc gpiod_request_config_new*(): ptr Gpiod_request_config {.cdecl,
    importc: "gpiod_request_config_new".}
proc gpiod_request_config_free*(config: ptr Gpiod_request_config): void {.cdecl,
    importc: "gpiod_request_config_free".}
proc gpiod_request_config_set_consumer*(config: ptr Gpiod_request_config;
                                        consumer: cstring): void {.cdecl,
    importc: "gpiod_request_config_set_consumer".}
proc gpiod_request_config_get_consumer*(config: ptr Gpiod_request_config): cstring {.
    cdecl, importc: "gpiod_request_config_get_consumer".}
proc gpiod_request_config_set_event_buffer_size*(
    config: ptr Gpiod_request_config; event_buffer_size: csize_t): void {.cdecl,
    importc: "gpiod_request_config_set_event_buffer_size".}
proc gpiod_request_config_get_event_buffer_size*(
    config: ptr Gpiod_request_config): csize_t {.cdecl,
    importc: "gpiod_request_config_get_event_buffer_size".}
proc gpiod_line_request_release*(request: ptr Gpiod_line_request): void {.cdecl,
    importc: "gpiod_line_request_release".}
proc gpiod_line_request_get_chip_name*(request: ptr Gpiod_line_request): cstring {.
    cdecl, importc: "gpiod_line_request_get_chip_name".}
proc gpiod_line_request_get_num_requested_lines*(request: ptr Gpiod_line_request): csize_t {.
    cdecl, importc: "gpiod_line_request_get_num_requested_lines".}
proc gpiod_line_request_get_requested_offsets*(request: ptr Gpiod_line_request;
    offsets: ptr cuint; max_offsets: csize_t): csize_t {.cdecl,
    importc: "gpiod_line_request_get_requested_offsets".}
proc gpiod_line_request_get_value*(request: ptr Gpiod_line_request;
                                   offset: cuint): Gpiod_line_value {.cdecl,
    importc: "gpiod_line_request_get_value".}
proc gpiod_line_request_get_values_subset*(request: ptr Gpiod_line_request;
    num_values: csize_t; offsets: ptr cuint; values: ptr Gpiod_line_value): cint {.
    cdecl, importc: "gpiod_line_request_get_values_subset".}
proc gpiod_line_request_get_values*(request: ptr Gpiod_line_request;
                                    values: ptr Gpiod_line_value): cint {.cdecl,
    importc: "gpiod_line_request_get_values".}
proc gpiod_line_request_set_value*(request: ptr Gpiod_line_request;
                                   offset: cuint; value: Gpiod_line_value): cint {.
    cdecl, importc: "gpiod_line_request_set_value".}
proc gpiod_line_request_set_values_subset*(request: ptr Gpiod_line_request;
    num_values: csize_t; offsets: ptr cuint; values: ptr Gpiod_line_value): cint {.
    cdecl, importc: "gpiod_line_request_set_values_subset".}
proc gpiod_line_request_set_values*(request: ptr Gpiod_line_request;
                                    values: ptr Gpiod_line_value): cint {.cdecl,
    importc: "gpiod_line_request_set_values".}
proc gpiod_line_request_reconfigure_lines*(request: ptr Gpiod_line_request;
    config: ptr Gpiod_line_config): cint {.cdecl,
    importc: "gpiod_line_request_reconfigure_lines".}
proc gpiod_line_request_get_fd*(request: ptr Gpiod_line_request): cint {.cdecl,
    importc: "gpiod_line_request_get_fd".}
proc gpiod_line_request_wait_edge_events*(request: ptr Gpiod_line_request;
    timeout_ns: int64): cint {.cdecl,
                               importc: "gpiod_line_request_wait_edge_events".}
proc gpiod_line_request_read_edge_events*(request: ptr Gpiod_line_request;
    buffer: ptr Gpiod_edge_event_buffer; max_events: csize_t): cint {.cdecl,
    importc: "gpiod_line_request_read_edge_events".}
proc gpiod_edge_event_free*(event: ptr Gpiod_edge_event): void {.cdecl,
    importc: "gpiod_edge_event_free".}
proc gpiod_edge_event_copy*(event: ptr Gpiod_edge_event): ptr Gpiod_edge_event {.
    cdecl, importc: "gpiod_edge_event_copy".}
proc gpiod_edge_event_get_event_type*(event: ptr Gpiod_edge_event): Gpiod_edge_event_type {.
    cdecl, importc: "gpiod_edge_event_get_event_type".}
proc gpiod_edge_event_get_timestamp_ns*(event: ptr Gpiod_edge_event): uint64 {.
    cdecl, importc: "gpiod_edge_event_get_timestamp_ns".}
proc gpiod_edge_event_get_line_offset*(event: ptr Gpiod_edge_event): cuint {.
    cdecl, importc: "gpiod_edge_event_get_line_offset".}
proc gpiod_edge_event_get_global_seqno*(event: ptr Gpiod_edge_event): culong {.
    cdecl, importc: "gpiod_edge_event_get_global_seqno".}
proc gpiod_edge_event_get_line_seqno*(event: ptr Gpiod_edge_event): culong {.
    cdecl, importc: "gpiod_edge_event_get_line_seqno".}
proc gpiod_edge_event_buffer_new*(capacity: csize_t): ptr Gpiod_edge_event_buffer {.
    cdecl, importc: "gpiod_edge_event_buffer_new".}
proc gpiod_edge_event_buffer_get_capacity*(buffer: ptr Gpiod_edge_event_buffer): csize_t {.
    cdecl, importc: "gpiod_edge_event_buffer_get_capacity".}
proc gpiod_edge_event_buffer_free*(buffer: ptr Gpiod_edge_event_buffer): void {.
    cdecl, importc: "gpiod_edge_event_buffer_free".}
proc gpiod_edge_event_buffer_get_event*(buffer: ptr Gpiod_edge_event_buffer;
                                        index: culong): ptr Gpiod_edge_event {.
    cdecl, importc: "gpiod_edge_event_buffer_get_event".}
proc gpiod_edge_event_buffer_get_num_events*(buffer: ptr Gpiod_edge_event_buffer): csize_t {.
    cdecl, importc: "gpiod_edge_event_buffer_get_num_events".}
proc gpiod_is_gpiochip_device*(path: cstring): bool {.cdecl,
    importc: "gpiod_is_gpiochip_device".}
proc gpiod_api_version*(): cstring {.cdecl, importc: "gpiod_api_version".}