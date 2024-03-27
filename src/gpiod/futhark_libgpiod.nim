
type
  Gpiodlinevalue* {.size: sizeof(cint).} = enum
    Gpiodlinevalueerror = -1, Gpiodlinevalueinactive = 0,
    Gpiodlinevalueactive = 1
type
  Gpiodlinedirection* {.size: sizeof(cuint).} = enum
    Gpiodlinedirectionasis = 1, Gpiodlinedirectioninput = 2,
    Gpiodlinedirectionoutput = 3
type
  Gpiodlineedge* {.size: sizeof(cuint).} = enum
    Gpiodlineedgenone = 1, Gpiodlineedgerising = 2, Gpiodlineedgefalling = 3,
    Gpiodlineedgeboth = 4
type
  Gpiodlinebias* {.size: sizeof(cuint).} = enum
    Gpiodlinebiasasis = 1, Gpiodlinebiasunknown = 2, Gpiodlinebiasdisabled = 3,
    Gpiodlinebiaspullup = 4, Gpiodlinebiaspulldown = 5
type
  Gpiodlinedrive* {.size: sizeof(cuint).} = enum
    Gpiodlinedrivepushpull = 1, Gpiodlinedriveopendrain = 2,
    Gpiodlinedriveopensource = 3
type
  Gpiodlineclock* {.size: sizeof(cuint).} = enum
    Gpiodlineclockmonotonic = 1, Gpiodlineclockrealtime = 2,
    Gpiodlineclockhte = 3
type
  Gpiodinfoeventtype* {.size: sizeof(cuint).} = enum
    Gpiodinfoeventlinerequested = 1, Gpiodinfoeventlinereleased = 2,
    Gpiodinfoeventlineconfigchanged = 3
type
  Gpiodedgeeventtype* {.size: sizeof(cuint).} = enum
    Gpiodedgeeventrisingedge = 1, Gpiodedgeeventfallingedge = 2
type
  Gpiodchip* = object
type
  Gpiodlinerequest* = object
type
  Gpiodchipinfo* = object
type
  Gpiodlinesettings* = object
type
  Gpiodlineinfo* = object
type
  Gpiodlineconfig* = object
type
  Gpiodedgeevent* = object
type
  Gpiodedgeeventbuffer* = object
type
  Gpiodrequestconfig* = object
type
  Gpiodinfoevent* = object
proc gpiodchipopen*(path: cstring): ptr Gpiodchip {.cdecl,
    importc: "gpiod_chip_open".}
proc gpiodchipclose*(chip: ptr Gpiodchip): void {.cdecl,
    importc: "gpiod_chip_close".}
proc gpiodchipgetinfo*(chip: ptr Gpiodchip): ptr Gpiodchipinfo {.cdecl,
    importc: "gpiod_chip_get_info".}
proc gpiodchipgetpath*(chip: ptr Gpiodchip): cstring {.cdecl,
    importc: "gpiod_chip_get_path".}
proc gpiodchipgetlineinfo*(chip: ptr Gpiodchip; offset: cuint): ptr Gpiodlineinfo {.
    cdecl, importc: "gpiod_chip_get_line_info".}
proc gpiodchipwatchlineinfo*(chip: ptr Gpiodchip; offset: cuint): ptr Gpiodlineinfo {.
    cdecl, importc: "gpiod_chip_watch_line_info".}
proc gpiodchipunwatchlineinfo*(chip: ptr Gpiodchip; offset: cuint): cint {.
    cdecl, importc: "gpiod_chip_unwatch_line_info".}
proc gpiodchipgetfd*(chip: ptr Gpiodchip): cint {.cdecl,
    importc: "gpiod_chip_get_fd".}
proc gpiodchipwaitinfoevent*(chip: ptr Gpiodchip; timeoutns: int64): cint {.
    cdecl, importc: "gpiod_chip_wait_info_event".}
proc gpiodchipreadinfoevent*(chip: ptr Gpiodchip): ptr Gpiodinfoevent {.cdecl,
    importc: "gpiod_chip_read_info_event".}
proc gpiodchipgetlineoffsetfromname*(chip: ptr Gpiodchip; name: cstring): cint {.
    cdecl, importc: "gpiod_chip_get_line_offset_from_name".}
proc gpiodchiprequestlines*(chip: ptr Gpiodchip; reqcfg: ptr Gpiodrequestconfig;
                            linecfg: ptr Gpiodlineconfig): ptr Gpiodlinerequest {.
    cdecl, importc: "gpiod_chip_request_lines".}
proc gpiodchipinfofree*(info: ptr Gpiodchipinfo): void {.cdecl,
    importc: "gpiod_chip_info_free".}
proc gpiodchipinfogetname*(info: ptr Gpiodchipinfo): cstring {.cdecl,
    importc: "gpiod_chip_info_get_name".}
proc gpiodchipinfogetlabel*(info: ptr Gpiodchipinfo): cstring {.cdecl,
    importc: "gpiod_chip_info_get_label".}
proc gpiodchipinfogetnumlines*(info: ptr Gpiodchipinfo): csize_t {.cdecl,
    importc: "gpiod_chip_info_get_num_lines".}
proc gpiodlineinfofree*(info: ptr Gpiodlineinfo): void {.cdecl,
    importc: "gpiod_line_info_free".}
proc gpiodlineinfocopy*(info: ptr Gpiodlineinfo): ptr Gpiodlineinfo {.cdecl,
    importc: "gpiod_line_info_copy".}
proc gpiodlineinfogetoffset*(info: ptr Gpiodlineinfo): cuint {.cdecl,
    importc: "gpiod_line_info_get_offset".}
proc gpiodlineinfogetname*(info: ptr Gpiodlineinfo): cstring {.cdecl,
    importc: "gpiod_line_info_get_name".}
proc gpiodlineinfoisused*(info: ptr Gpiodlineinfo): bool {.cdecl,
    importc: "gpiod_line_info_is_used".}
proc gpiodlineinfogetconsumer*(info: ptr Gpiodlineinfo): cstring {.cdecl,
    importc: "gpiod_line_info_get_consumer".}
proc gpiodlineinfogetdirection*(info: ptr Gpiodlineinfo): Gpiodlinedirection {.
    cdecl, importc: "gpiod_line_info_get_direction".}
proc gpiodlineinfogetedgedetection*(info: ptr Gpiodlineinfo): Gpiodlineedge {.
    cdecl, importc: "gpiod_line_info_get_edge_detection".}
proc gpiodlineinfogetbias*(info: ptr Gpiodlineinfo): Gpiodlinebias {.cdecl,
    importc: "gpiod_line_info_get_bias".}
proc gpiodlineinfogetdrive*(info: ptr Gpiodlineinfo): Gpiodlinedrive {.cdecl,
    importc: "gpiod_line_info_get_drive".}
proc gpiodlineinfoisactivelow*(info: ptr Gpiodlineinfo): bool {.cdecl,
    importc: "gpiod_line_info_is_active_low".}
proc gpiodlineinfoisdebounced*(info: ptr Gpiodlineinfo): bool {.cdecl,
    importc: "gpiod_line_info_is_debounced".}
proc gpiodlineinfogetdebounceperiodus*(info: ptr Gpiodlineinfo): culong {.cdecl,
    importc: "gpiod_line_info_get_debounce_period_us".}
proc gpiodlineinfogeteventclock*(info: ptr Gpiodlineinfo): Gpiodlineclock {.
    cdecl, importc: "gpiod_line_info_get_event_clock".}
proc gpiodinfoeventfree*(event: ptr Gpiodinfoevent): void {.cdecl,
    importc: "gpiod_info_event_free".}
proc gpiodinfoeventgeteventtype*(event: ptr Gpiodinfoevent): Gpiodinfoeventtype {.
    cdecl, importc: "gpiod_info_event_get_event_type".}
proc gpiodinfoeventgettimestampns*(event: ptr Gpiodinfoevent): uint64 {.cdecl,
    importc: "gpiod_info_event_get_timestamp_ns".}
proc gpiodinfoeventgetlineinfo*(event: ptr Gpiodinfoevent): ptr Gpiodlineinfo {.
    cdecl, importc: "gpiod_info_event_get_line_info".}
proc gpiodlinesettingsnew*(): ptr Gpiodlinesettings {.cdecl,
    importc: "gpiod_line_settings_new".}
proc gpiodlinesettingsfree*(settings: ptr Gpiodlinesettings): void {.cdecl,
    importc: "gpiod_line_settings_free".}
proc gpiodlinesettingsreset*(settings: ptr Gpiodlinesettings): void {.cdecl,
    importc: "gpiod_line_settings_reset".}
proc gpiodlinesettingscopy*(settings: ptr Gpiodlinesettings): ptr Gpiodlinesettings {.
    cdecl, importc: "gpiod_line_settings_copy".}
proc gpiodlinesettingssetdirection*(settings: ptr Gpiodlinesettings;
                                    direction: Gpiodlinedirection): cint {.
    cdecl, importc: "gpiod_line_settings_set_direction".}
proc gpiodlinesettingsgetdirection*(settings: ptr Gpiodlinesettings): Gpiodlinedirection {.
    cdecl, importc: "gpiod_line_settings_get_direction".}
proc gpiodlinesettingssetedgedetection*(settings: ptr Gpiodlinesettings;
                                        edge: Gpiodlineedge): cint {.cdecl,
    importc: "gpiod_line_settings_set_edge_detection".}
proc gpiodlinesettingsgetedgedetection*(settings: ptr Gpiodlinesettings): Gpiodlineedge {.
    cdecl, importc: "gpiod_line_settings_get_edge_detection".}
proc gpiodlinesettingssetbias*(settings: ptr Gpiodlinesettings;
                               bias: Gpiodlinebias): cint {.cdecl,
    importc: "gpiod_line_settings_set_bias".}
proc gpiodlinesettingsgetbias*(settings: ptr Gpiodlinesettings): Gpiodlinebias {.
    cdecl, importc: "gpiod_line_settings_get_bias".}
proc gpiodlinesettingssetdrive*(settings: ptr Gpiodlinesettings;
                                drive: Gpiodlinedrive): cint {.cdecl,
    importc: "gpiod_line_settings_set_drive".}
proc gpiodlinesettingsgetdrive*(settings: ptr Gpiodlinesettings): Gpiodlinedrive {.
    cdecl, importc: "gpiod_line_settings_get_drive".}
proc gpiodlinesettingssetactivelow*(settings: ptr Gpiodlinesettings;
                                    activelow: bool): void {.cdecl,
    importc: "gpiod_line_settings_set_active_low".}
proc gpiodlinesettingsgetactivelow*(settings: ptr Gpiodlinesettings): bool {.
    cdecl, importc: "gpiod_line_settings_get_active_low".}
proc gpiodlinesettingssetdebounceperiodus*(settings: ptr Gpiodlinesettings;
    period: culong): void {.cdecl, importc: "gpiod_line_settings_set_debounce_period_us".}
proc gpiodlinesettingsgetdebounceperiodus*(settings: ptr Gpiodlinesettings): culong {.
    cdecl, importc: "gpiod_line_settings_get_debounce_period_us".}
proc gpiodlinesettingsseteventclock*(settings: ptr Gpiodlinesettings;
                                     eventclock: Gpiodlineclock): cint {.cdecl,
    importc: "gpiod_line_settings_set_event_clock".}
proc gpiodlinesettingsgeteventclock*(settings: ptr Gpiodlinesettings): Gpiodlineclock {.
    cdecl, importc: "gpiod_line_settings_get_event_clock".}
proc gpiodlinesettingssetoutputvalue*(settings: ptr Gpiodlinesettings;
                                      value: Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_settings_set_output_value".}
proc gpiodlinesettingsgetoutputvalue*(settings: ptr Gpiodlinesettings): Gpiodlinevalue {.
    cdecl, importc: "gpiod_line_settings_get_output_value".}
proc gpiodlineconfignew*(): ptr Gpiodlineconfig {.cdecl,
    importc: "gpiod_line_config_new".}
proc gpiodlineconfigfree*(config: ptr Gpiodlineconfig): void {.cdecl,
    importc: "gpiod_line_config_free".}
proc gpiodlineconfigreset*(config: ptr Gpiodlineconfig): void {.cdecl,
    importc: "gpiod_line_config_reset".}
proc gpiodlineconfigaddlinesettings*(config: ptr Gpiodlineconfig;
                                     offsets: ptr cuint; numoffsets: csize_t;
                                     settings: ptr Gpiodlinesettings): cint {.
    cdecl, importc: "gpiod_line_config_add_line_settings".}
proc gpiodlineconfiggetlinesettings*(config: ptr Gpiodlineconfig; offset: cuint): ptr Gpiodlinesettings {.
    cdecl, importc: "gpiod_line_config_get_line_settings".}
proc gpiodlineconfigsetoutputvalues*(config: ptr Gpiodlineconfig;
                                     values: ptr Gpiodlinevalue;
                                     numvalues: csize_t): cint {.cdecl,
    importc: "gpiod_line_config_set_output_values".}
proc gpiodlineconfiggetnumconfiguredoffsets*(config: ptr Gpiodlineconfig): csize_t {.
    cdecl, importc: "gpiod_line_config_get_num_configured_offsets".}
proc gpiodlineconfiggetconfiguredoffsets*(config: ptr Gpiodlineconfig;
    offsets: ptr cuint; maxoffsets: csize_t): csize_t {.cdecl,
    importc: "gpiod_line_config_get_configured_offsets".}
proc gpiodrequestconfignew*(): ptr Gpiodrequestconfig {.cdecl,
    importc: "gpiod_request_config_new".}
proc gpiodrequestconfigfree*(config: ptr Gpiodrequestconfig): void {.cdecl,
    importc: "gpiod_request_config_free".}
proc gpiodrequestconfigsetconsumer*(config: ptr Gpiodrequestconfig;
                                    consumer: cstring): void {.cdecl,
    importc: "gpiod_request_config_set_consumer".}
proc gpiodrequestconfiggetconsumer*(config: ptr Gpiodrequestconfig): cstring {.
    cdecl, importc: "gpiod_request_config_get_consumer".}
proc gpiodrequestconfigseteventbuffersize*(config: ptr Gpiodrequestconfig;
    eventbuffersize: csize_t): void {.cdecl, importc: "gpiod_request_config_set_event_buffer_size".}
proc gpiodrequestconfiggeteventbuffersize*(config: ptr Gpiodrequestconfig): csize_t {.
    cdecl, importc: "gpiod_request_config_get_event_buffer_size".}
proc gpiodlinerequestrelease*(request: ptr Gpiodlinerequest): void {.cdecl,
    importc: "gpiod_line_request_release".}
proc gpiodlinerequestgetchipname*(request: ptr Gpiodlinerequest): cstring {.
    cdecl, importc: "gpiod_line_request_get_chip_name".}
proc gpiodlinerequestgetnumrequestedlines*(request: ptr Gpiodlinerequest): csize_t {.
    cdecl, importc: "gpiod_line_request_get_num_requested_lines".}
proc gpiodlinerequestgetrequestedoffsets*(request: ptr Gpiodlinerequest;
    offsets: ptr cuint; maxoffsets: csize_t): csize_t {.cdecl,
    importc: "gpiod_line_request_get_requested_offsets".}
proc gpiodlinerequestgetvalue*(request: ptr Gpiodlinerequest; offset: cuint): Gpiodlinevalue {.
    cdecl, importc: "gpiod_line_request_get_value".}
proc gpiodlinerequestgetvaluessubset*(request: ptr Gpiodlinerequest;
                                      numvalues: csize_t; offsets: ptr cuint;
                                      values: ptr Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_request_get_values_subset".}
proc gpiodlinerequestgetvalues*(request: ptr Gpiodlinerequest;
                                values: ptr Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_request_get_values".}
proc gpiodlinerequestsetvalue*(request: ptr Gpiodlinerequest; offset: cuint;
                               value: Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_request_set_value".}
proc gpiodlinerequestsetvaluessubset*(request: ptr Gpiodlinerequest;
                                      numvalues: csize_t; offsets: ptr cuint;
                                      values: ptr Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_request_set_values_subset".}
proc gpiodlinerequestsetvalues*(request: ptr Gpiodlinerequest;
                                values: ptr Gpiodlinevalue): cint {.cdecl,
    importc: "gpiod_line_request_set_values".}
proc gpiodlinerequestreconfigurelines*(request: ptr Gpiodlinerequest;
                                       config: ptr Gpiodlineconfig): cint {.
    cdecl, importc: "gpiod_line_request_reconfigure_lines".}
proc gpiodlinerequestgetfd*(request: ptr Gpiodlinerequest): cint {.cdecl,
    importc: "gpiod_line_request_get_fd".}
proc gpiodlinerequestwaitedgeevents*(request: ptr Gpiodlinerequest;
                                     timeoutns: int64): cint {.cdecl,
    importc: "gpiod_line_request_wait_edge_events".}
proc gpiodlinerequestreadedgeevents*(request: ptr Gpiodlinerequest;
                                     buffer: ptr Gpiodedgeeventbuffer;
                                     maxevents: csize_t): cint {.cdecl,
    importc: "gpiod_line_request_read_edge_events".}
proc gpiodedgeeventfree*(event: ptr Gpiodedgeevent): void {.cdecl,
    importc: "gpiod_edge_event_free".}
proc gpiodedgeeventcopy*(event: ptr Gpiodedgeevent): ptr Gpiodedgeevent {.cdecl,
    importc: "gpiod_edge_event_copy".}
proc gpiodedgeeventgeteventtype*(event: ptr Gpiodedgeevent): Gpiodedgeeventtype {.
    cdecl, importc: "gpiod_edge_event_get_event_type".}
proc gpiodedgeeventgettimestampns*(event: ptr Gpiodedgeevent): uint64 {.cdecl,
    importc: "gpiod_edge_event_get_timestamp_ns".}
proc gpiodedgeeventgetlineoffset*(event: ptr Gpiodedgeevent): cuint {.cdecl,
    importc: "gpiod_edge_event_get_line_offset".}
proc gpiodedgeeventgetglobalseqno*(event: ptr Gpiodedgeevent): culong {.cdecl,
    importc: "gpiod_edge_event_get_global_seqno".}
proc gpiodedgeeventgetlineseqno*(event: ptr Gpiodedgeevent): culong {.cdecl,
    importc: "gpiod_edge_event_get_line_seqno".}
proc gpiodedgeeventbuffernew*(capacity: csize_t): ptr Gpiodedgeeventbuffer {.
    cdecl, importc: "gpiod_edge_event_buffer_new".}
proc gpiodedgeeventbuffergetcapacity*(buffer: ptr Gpiodedgeeventbuffer): csize_t {.
    cdecl, importc: "gpiod_edge_event_buffer_get_capacity".}
proc gpiodedgeeventbufferfree*(buffer: ptr Gpiodedgeeventbuffer): void {.cdecl,
    importc: "gpiod_edge_event_buffer_free".}
proc gpiodedgeeventbuffergetevent*(buffer: ptr Gpiodedgeeventbuffer;
                                   index: culong): ptr Gpiodedgeevent {.cdecl,
    importc: "gpiod_edge_event_buffer_get_event".}
proc gpiodedgeeventbuffergetnumevents*(buffer: ptr Gpiodedgeeventbuffer): csize_t {.
    cdecl, importc: "gpiod_edge_event_buffer_get_num_events".}
proc gpiodisgpiochipdevice*(path: cstring): bool {.cdecl,
    importc: "gpiod_is_gpiochip_device".}
proc gpiodapiversion*(): cstring {.cdecl, importc: "gpiod_api_version".}