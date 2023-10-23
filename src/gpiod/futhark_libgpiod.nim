
from macros import hint

when not declared(Gpiodlinevalue):
  type
    Gpiodlinevalue* {.size: sizeof(cint).} = enum
      Gpiodlinevalueerror = -1, Gpiodlinevalueinactive = 0,
      Gpiodlinevalueactive = 1
else:
  static :
    hint("Declaration of " & "Gpiodlinevalue" &
        " already exists, not redeclaring")
when not declared(Gpiodlinedirection):
  type
    Gpiodlinedirection* {.size: sizeof(cuint).} = enum
      Gpiodlinedirectionasis = 1, Gpiodlinedirectioninput = 2,
      Gpiodlinedirectionoutput = 3
else:
  static :
    hint("Declaration of " & "Gpiodlinedirection" &
        " already exists, not redeclaring")
when not declared(Gpiodlineedge):
  type
    Gpiodlineedge* {.size: sizeof(cuint).} = enum
      Gpiodlineedgenone = 1, Gpiodlineedgerising = 2, Gpiodlineedgefalling = 3,
      Gpiodlineedgeboth = 4
else:
  static :
    hint("Declaration of " & "Gpiodlineedge" &
        " already exists, not redeclaring")
when not declared(Gpiodlinebias):
  type
    Gpiodlinebias* {.size: sizeof(cuint).} = enum
      Gpiodlinebiasasis = 1, Gpiodlinebiasunknown = 2,
      Gpiodlinebiasdisabled = 3, Gpiodlinebiaspullup = 4,
      Gpiodlinebiaspulldown = 5
else:
  static :
    hint("Declaration of " & "Gpiodlinebias" &
        " already exists, not redeclaring")
when not declared(Gpiodlinedrive):
  type
    Gpiodlinedrive* {.size: sizeof(cuint).} = enum
      Gpiodlinedrivepushpull = 1, Gpiodlinedriveopendrain = 2,
      Gpiodlinedriveopensource = 3
else:
  static :
    hint("Declaration of " & "Gpiodlinedrive" &
        " already exists, not redeclaring")
when not declared(Gpiodlineclock):
  type
    Gpiodlineclock* {.size: sizeof(cuint).} = enum
      Gpiodlineclockmonotonic = 1, Gpiodlineclockrealtime = 2,
      Gpiodlineclockhte = 3
else:
  static :
    hint("Declaration of " & "Gpiodlineclock" &
        " already exists, not redeclaring")
when not declared(Gpiodinfoeventtype):
  type
    Gpiodinfoeventtype* {.size: sizeof(cuint).} = enum
      Gpiodinfoeventlinerequested = 1, Gpiodinfoeventlinereleased = 2,
      Gpiodinfoeventlineconfigchanged = 3
else:
  static :
    hint("Declaration of " & "Gpiodinfoeventtype" &
        " already exists, not redeclaring")
when not declared(Gpiodedgeeventtype):
  type
    Gpiodedgeeventtype* {.size: sizeof(cuint).} = enum
      Gpiodedgeeventrisingedge = 1, Gpiodedgeeventfallingedge = 2
else:
  static :
    hint("Declaration of " & "Gpiodedgeeventtype" &
        " already exists, not redeclaring")
when not declared(Gpiodchip):
  type
    Gpiodchip* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodchip" & " already exists, not redeclaring")
when not declared(Gpiodlinerequest):
  type
    Gpiodlinerequest* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodlinerequest" &
        " already exists, not redeclaring")
when not declared(Gpiodchipinfo):
  type
    Gpiodchipinfo* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodchipinfo" &
        " already exists, not redeclaring")
when not declared(Gpiodlinesettings):
  type
    Gpiodlinesettings* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodlinesettings" &
        " already exists, not redeclaring")
when not declared(Gpiodlineinfo):
  type
    Gpiodlineinfo* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodlineinfo" &
        " already exists, not redeclaring")
when not declared(Gpiodlineconfig):
  type
    Gpiodlineconfig* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodlineconfig" &
        " already exists, not redeclaring")
when not declared(Gpiodedgeevent):
  type
    Gpiodedgeevent* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodedgeevent" &
        " already exists, not redeclaring")
when not declared(Gpiodedgeeventbuffer):
  type
    Gpiodedgeeventbuffer* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodedgeeventbuffer" &
        " already exists, not redeclaring")
when not declared(Gpiodrequestconfig):
  type
    Gpiodrequestconfig* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodrequestconfig" &
        " already exists, not redeclaring")
when not declared(Gpiodinfoevent):
  type
    Gpiodinfoevent* = distinct object
else:
  static :
    hint("Declaration of " & "Gpiodinfoevent" &
        " already exists, not redeclaring")
type
  Gpiodlineclock_1191182707 = (when declared(Gpiodlineclock):
    Gpiodlineclock
   else:
    Gpiodlineclock_1191182706)
  Gpiodlinedrive_1191182705 = (when declared(Gpiodlinedrive):
    Gpiodlinedrive
   else:
    Gpiodlinedrive_1191182704)
  Gpiodlinevalue_1191182697 = (when declared(Gpiodlinevalue):
    Gpiodlinevalue
   else:
    Gpiodlinevalue_1191182696)
  Gpiodinfoeventtype_1191182709 = (when declared(Gpiodinfoeventtype):
    Gpiodinfoeventtype
   else:
    Gpiodinfoeventtype_1191182708)
  Gpiodlinebias_1191182703 = (when declared(Gpiodlinebias):
    Gpiodlinebias
   else:
    Gpiodlinebias_1191182702)
  Gpiodedgeeventtype_1191182711 = (when declared(Gpiodedgeeventtype):
    Gpiodedgeeventtype
   else:
    Gpiodedgeeventtype_1191182710)
  Gpiodlineedge_1191182701 = (when declared(Gpiodlineedge):
    Gpiodlineedge
   else:
    Gpiodlineedge_1191182700)
  Gpiodlinedirection_1191182699 = (when declared(Gpiodlinedirection):
    Gpiodlinedirection
   else:
    Gpiodlinedirection_1191182698)
when not declared(gpiodchipopen):
  proc gpiodchipopen*(path: cstring): ptr Gpiodchip {.cdecl,
      importc: "gpiod_chip_open".}
else:
  static :
    hint("Declaration of " & "gpiodchipopen" &
        " already exists, not redeclaring")
when not declared(gpiodchipclose):
  proc gpiodchipclose*(chip: ptr Gpiodchip): void {.cdecl,
      importc: "gpiod_chip_close".}
else:
  static :
    hint("Declaration of " & "gpiodchipclose" &
        " already exists, not redeclaring")
when not declared(gpiodchipgetinfo):
  proc gpiodchipgetinfo*(chip: ptr Gpiodchip): ptr Gpiodchipinfo {.cdecl,
      importc: "gpiod_chip_get_info".}
else:
  static :
    hint("Declaration of " & "gpiodchipgetinfo" &
        " already exists, not redeclaring")
when not declared(gpiodchipgetpath):
  proc gpiodchipgetpath*(chip: ptr Gpiodchip): cstring {.cdecl,
      importc: "gpiod_chip_get_path".}
else:
  static :
    hint("Declaration of " & "gpiodchipgetpath" &
        " already exists, not redeclaring")
when not declared(gpiodchipgetlineinfo):
  proc gpiodchipgetlineinfo*(chip: ptr Gpiodchip; offset: cuint): ptr Gpiodlineinfo {.
      cdecl, importc: "gpiod_chip_get_line_info".}
else:
  static :
    hint("Declaration of " & "gpiodchipgetlineinfo" &
        " already exists, not redeclaring")
when not declared(gpiodchipwatchlineinfo):
  proc gpiodchipwatchlineinfo*(chip: ptr Gpiodchip; offset: cuint): ptr Gpiodlineinfo {.
      cdecl, importc: "gpiod_chip_watch_line_info".}
else:
  static :
    hint("Declaration of " & "gpiodchipwatchlineinfo" &
        " already exists, not redeclaring")
when not declared(gpiodchipunwatchlineinfo):
  proc gpiodchipunwatchlineinfo*(chip: ptr Gpiodchip; offset: cuint): cint {.
      cdecl, importc: "gpiod_chip_unwatch_line_info".}
else:
  static :
    hint("Declaration of " & "gpiodchipunwatchlineinfo" &
        " already exists, not redeclaring")
when not declared(gpiodchipgetfd):
  proc gpiodchipgetfd*(chip: ptr Gpiodchip): cint {.cdecl,
      importc: "gpiod_chip_get_fd".}
else:
  static :
    hint("Declaration of " & "gpiodchipgetfd" &
        " already exists, not redeclaring")
when not declared(gpiodchipwaitinfoevent):
  proc gpiodchipwaitinfoevent*(chip: ptr Gpiodchip; timeoutns: clong): cint {.
      cdecl, importc: "gpiod_chip_wait_info_event".}
else:
  static :
    hint("Declaration of " & "gpiodchipwaitinfoevent" &
        " already exists, not redeclaring")
when not declared(gpiodchipreadinfoevent):
  proc gpiodchipreadinfoevent*(chip: ptr Gpiodchip): ptr Gpiodinfoevent {.cdecl,
      importc: "gpiod_chip_read_info_event".}
else:
  static :
    hint("Declaration of " & "gpiodchipreadinfoevent" &
        " already exists, not redeclaring")
when not declared(gpiodchipgetlineoffsetfromname):
  proc gpiodchipgetlineoffsetfromname*(chip: ptr Gpiodchip; name: cstring): cint {.
      cdecl, importc: "gpiod_chip_get_line_offset_from_name".}
else:
  static :
    hint("Declaration of " & "gpiodchipgetlineoffsetfromname" &
        " already exists, not redeclaring")
when not declared(gpiodchiprequestlines):
  proc gpiodchiprequestlines*(chip: ptr Gpiodchip;
                              reqcfg: ptr Gpiodrequestconfig;
                              linecfg: ptr Gpiodlineconfig): ptr Gpiodlinerequest {.
      cdecl, importc: "gpiod_chip_request_lines".}
else:
  static :
    hint("Declaration of " & "gpiodchiprequestlines" &
        " already exists, not redeclaring")
when not declared(gpiodchipinfofree):
  proc gpiodchipinfofree*(info: ptr Gpiodchipinfo): void {.cdecl,
      importc: "gpiod_chip_info_free".}
else:
  static :
    hint("Declaration of " & "gpiodchipinfofree" &
        " already exists, not redeclaring")
when not declared(gpiodchipinfogetname):
  proc gpiodchipinfogetname*(info: ptr Gpiodchipinfo): cstring {.cdecl,
      importc: "gpiod_chip_info_get_name".}
else:
  static :
    hint("Declaration of " & "gpiodchipinfogetname" &
        " already exists, not redeclaring")
when not declared(gpiodchipinfogetlabel):
  proc gpiodchipinfogetlabel*(info: ptr Gpiodchipinfo): cstring {.cdecl,
      importc: "gpiod_chip_info_get_label".}
else:
  static :
    hint("Declaration of " & "gpiodchipinfogetlabel" &
        " already exists, not redeclaring")
when not declared(gpiodchipinfogetnumlines):
  proc gpiodchipinfogetnumlines*(info: ptr Gpiodchipinfo): culong {.cdecl,
      importc: "gpiod_chip_info_get_num_lines".}
else:
  static :
    hint("Declaration of " & "gpiodchipinfogetnumlines" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfofree):
  proc gpiodlineinfofree*(info: ptr Gpiodlineinfo): void {.cdecl,
      importc: "gpiod_line_info_free".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfofree" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfocopy):
  proc gpiodlineinfocopy*(info: ptr Gpiodlineinfo): ptr Gpiodlineinfo {.cdecl,
      importc: "gpiod_line_info_copy".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfocopy" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetoffset):
  proc gpiodlineinfogetoffset*(info: ptr Gpiodlineinfo): cuint {.cdecl,
      importc: "gpiod_line_info_get_offset".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetoffset" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetname):
  proc gpiodlineinfogetname*(info: ptr Gpiodlineinfo): cstring {.cdecl,
      importc: "gpiod_line_info_get_name".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetname" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfoisused):
  proc gpiodlineinfoisused*(info: ptr Gpiodlineinfo): bool {.cdecl,
      importc: "gpiod_line_info_is_used".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfoisused" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetconsumer):
  proc gpiodlineinfogetconsumer*(info: ptr Gpiodlineinfo): cstring {.cdecl,
      importc: "gpiod_line_info_get_consumer".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetconsumer" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetdirection):
  proc gpiodlineinfogetdirection*(info: ptr Gpiodlineinfo): Gpiodlinedirection_1191182699 {.
      cdecl, importc: "gpiod_line_info_get_direction".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetdirection" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetedgedetection):
  proc gpiodlineinfogetedgedetection*(info: ptr Gpiodlineinfo): Gpiodlineedge_1191182701 {.
      cdecl, importc: "gpiod_line_info_get_edge_detection".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetedgedetection" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetbias):
  proc gpiodlineinfogetbias*(info: ptr Gpiodlineinfo): Gpiodlinebias_1191182703 {.
      cdecl, importc: "gpiod_line_info_get_bias".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetbias" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetdrive):
  proc gpiodlineinfogetdrive*(info: ptr Gpiodlineinfo): Gpiodlinedrive_1191182705 {.
      cdecl, importc: "gpiod_line_info_get_drive".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetdrive" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfoisactivelow):
  proc gpiodlineinfoisactivelow*(info: ptr Gpiodlineinfo): bool {.cdecl,
      importc: "gpiod_line_info_is_active_low".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfoisactivelow" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfoisdebounced):
  proc gpiodlineinfoisdebounced*(info: ptr Gpiodlineinfo): bool {.cdecl,
      importc: "gpiod_line_info_is_debounced".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfoisdebounced" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogetdebounceperiodus):
  proc gpiodlineinfogetdebounceperiodus*(info: ptr Gpiodlineinfo): culong {.
      cdecl, importc: "gpiod_line_info_get_debounce_period_us".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogetdebounceperiodus" &
        " already exists, not redeclaring")
when not declared(gpiodlineinfogeteventclock):
  proc gpiodlineinfogeteventclock*(info: ptr Gpiodlineinfo): Gpiodlineclock_1191182707 {.
      cdecl, importc: "gpiod_line_info_get_event_clock".}
else:
  static :
    hint("Declaration of " & "gpiodlineinfogeteventclock" &
        " already exists, not redeclaring")
when not declared(gpiodinfoeventfree):
  proc gpiodinfoeventfree*(event: ptr Gpiodinfoevent): void {.cdecl,
      importc: "gpiod_info_event_free".}
else:
  static :
    hint("Declaration of " & "gpiodinfoeventfree" &
        " already exists, not redeclaring")
when not declared(gpiodinfoeventgeteventtype):
  proc gpiodinfoeventgeteventtype*(event: ptr Gpiodinfoevent): Gpiodinfoeventtype_1191182709 {.
      cdecl, importc: "gpiod_info_event_get_event_type".}
else:
  static :
    hint("Declaration of " & "gpiodinfoeventgeteventtype" &
        " already exists, not redeclaring")
when not declared(gpiodinfoeventgettimestampns):
  proc gpiodinfoeventgettimestampns*(event: ptr Gpiodinfoevent): culong {.cdecl,
      importc: "gpiod_info_event_get_timestamp_ns".}
else:
  static :
    hint("Declaration of " & "gpiodinfoeventgettimestampns" &
        " already exists, not redeclaring")
when not declared(gpiodinfoeventgetlineinfo):
  proc gpiodinfoeventgetlineinfo*(event: ptr Gpiodinfoevent): ptr Gpiodlineinfo {.
      cdecl, importc: "gpiod_info_event_get_line_info".}
else:
  static :
    hint("Declaration of " & "gpiodinfoeventgetlineinfo" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsnew):
  proc gpiodlinesettingsnew*(): ptr Gpiodlinesettings {.cdecl,
      importc: "gpiod_line_settings_new".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsnew" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsfree):
  proc gpiodlinesettingsfree*(settings: ptr Gpiodlinesettings): void {.cdecl,
      importc: "gpiod_line_settings_free".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsfree" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsreset):
  proc gpiodlinesettingsreset*(settings: ptr Gpiodlinesettings): void {.cdecl,
      importc: "gpiod_line_settings_reset".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsreset" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingscopy):
  proc gpiodlinesettingscopy*(settings: ptr Gpiodlinesettings): ptr Gpiodlinesettings {.
      cdecl, importc: "gpiod_line_settings_copy".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingscopy" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetdirection):
  proc gpiodlinesettingssetdirection*(settings: ptr Gpiodlinesettings;
                                      direction: Gpiodlinedirection_1191182699): cint {.
      cdecl, importc: "gpiod_line_settings_set_direction".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetdirection" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetdirection):
  proc gpiodlinesettingsgetdirection*(settings: ptr Gpiodlinesettings): Gpiodlinedirection_1191182699 {.
      cdecl, importc: "gpiod_line_settings_get_direction".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetdirection" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetedgedetection):
  proc gpiodlinesettingssetedgedetection*(settings: ptr Gpiodlinesettings;
      edge: Gpiodlineedge_1191182701): cint {.cdecl,
      importc: "gpiod_line_settings_set_edge_detection".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetedgedetection" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetedgedetection):
  proc gpiodlinesettingsgetedgedetection*(settings: ptr Gpiodlinesettings): Gpiodlineedge_1191182701 {.
      cdecl, importc: "gpiod_line_settings_get_edge_detection".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetedgedetection" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetbias):
  proc gpiodlinesettingssetbias*(settings: ptr Gpiodlinesettings;
                                 bias: Gpiodlinebias_1191182703): cint {.cdecl,
      importc: "gpiod_line_settings_set_bias".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetbias" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetbias):
  proc gpiodlinesettingsgetbias*(settings: ptr Gpiodlinesettings): Gpiodlinebias_1191182703 {.
      cdecl, importc: "gpiod_line_settings_get_bias".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetbias" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetdrive):
  proc gpiodlinesettingssetdrive*(settings: ptr Gpiodlinesettings;
                                  drive: Gpiodlinedrive_1191182705): cint {.
      cdecl, importc: "gpiod_line_settings_set_drive".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetdrive" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetdrive):
  proc gpiodlinesettingsgetdrive*(settings: ptr Gpiodlinesettings): Gpiodlinedrive_1191182705 {.
      cdecl, importc: "gpiod_line_settings_get_drive".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetdrive" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetactivelow):
  proc gpiodlinesettingssetactivelow*(settings: ptr Gpiodlinesettings;
                                      activelow: bool): void {.cdecl,
      importc: "gpiod_line_settings_set_active_low".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetactivelow" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetactivelow):
  proc gpiodlinesettingsgetactivelow*(settings: ptr Gpiodlinesettings): bool {.
      cdecl, importc: "gpiod_line_settings_get_active_low".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetactivelow" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetdebounceperiodus):
  proc gpiodlinesettingssetdebounceperiodus*(settings: ptr Gpiodlinesettings;
      period: culong): void {.cdecl, importc: "gpiod_line_settings_set_debounce_period_us".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetdebounceperiodus" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetdebounceperiodus):
  proc gpiodlinesettingsgetdebounceperiodus*(settings: ptr Gpiodlinesettings): culong {.
      cdecl, importc: "gpiod_line_settings_get_debounce_period_us".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetdebounceperiodus" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsseteventclock):
  proc gpiodlinesettingsseteventclock*(settings: ptr Gpiodlinesettings;
                                       eventclock: Gpiodlineclock_1191182707): cint {.
      cdecl, importc: "gpiod_line_settings_set_event_clock".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsseteventclock" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgeteventclock):
  proc gpiodlinesettingsgeteventclock*(settings: ptr Gpiodlinesettings): Gpiodlineclock_1191182707 {.
      cdecl, importc: "gpiod_line_settings_get_event_clock".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgeteventclock" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingssetoutputvalue):
  proc gpiodlinesettingssetoutputvalue*(settings: ptr Gpiodlinesettings;
                                        value: Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_settings_set_output_value".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingssetoutputvalue" &
        " already exists, not redeclaring")
when not declared(gpiodlinesettingsgetoutputvalue):
  proc gpiodlinesettingsgetoutputvalue*(settings: ptr Gpiodlinesettings): Gpiodlinevalue_1191182697 {.
      cdecl, importc: "gpiod_line_settings_get_output_value".}
else:
  static :
    hint("Declaration of " & "gpiodlinesettingsgetoutputvalue" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfignew):
  proc gpiodlineconfignew*(): ptr Gpiodlineconfig {.cdecl,
      importc: "gpiod_line_config_new".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfignew" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfigfree):
  proc gpiodlineconfigfree*(config: ptr Gpiodlineconfig): void {.cdecl,
      importc: "gpiod_line_config_free".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfigfree" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfigreset):
  proc gpiodlineconfigreset*(config: ptr Gpiodlineconfig): void {.cdecl,
      importc: "gpiod_line_config_reset".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfigreset" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfigaddlinesettings):
  proc gpiodlineconfigaddlinesettings*(config: ptr Gpiodlineconfig;
                                       offsets: ptr cuint; numoffsets: culong;
                                       settings: ptr Gpiodlinesettings): cint {.
      cdecl, importc: "gpiod_line_config_add_line_settings".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfigaddlinesettings" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfiggetlinesettings):
  proc gpiodlineconfiggetlinesettings*(config: ptr Gpiodlineconfig;
                                       offset: cuint): ptr Gpiodlinesettings {.
      cdecl, importc: "gpiod_line_config_get_line_settings".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfiggetlinesettings" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfigsetoutputvalues):
  proc gpiodlineconfigsetoutputvalues*(config: ptr Gpiodlineconfig;
                                       values: ptr Gpiodlinevalue_1191182697;
                                       numvalues: culong): cint {.cdecl,
      importc: "gpiod_line_config_set_output_values".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfigsetoutputvalues" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfiggetnumconfiguredoffsets):
  proc gpiodlineconfiggetnumconfiguredoffsets*(config: ptr Gpiodlineconfig): culong {.
      cdecl, importc: "gpiod_line_config_get_num_configured_offsets".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfiggetnumconfiguredoffsets" &
        " already exists, not redeclaring")
when not declared(gpiodlineconfiggetconfiguredoffsets):
  proc gpiodlineconfiggetconfiguredoffsets*(config: ptr Gpiodlineconfig;
      offsets: ptr cuint; maxoffsets: culong): culong {.cdecl,
      importc: "gpiod_line_config_get_configured_offsets".}
else:
  static :
    hint("Declaration of " & "gpiodlineconfiggetconfiguredoffsets" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfignew):
  proc gpiodrequestconfignew*(): ptr Gpiodrequestconfig {.cdecl,
      importc: "gpiod_request_config_new".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfignew" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfigfree):
  proc gpiodrequestconfigfree*(config: ptr Gpiodrequestconfig): void {.cdecl,
      importc: "gpiod_request_config_free".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfigfree" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfigsetconsumer):
  proc gpiodrequestconfigsetconsumer*(config: ptr Gpiodrequestconfig;
                                      consumer: cstring): void {.cdecl,
      importc: "gpiod_request_config_set_consumer".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfigsetconsumer" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfiggetconsumer):
  proc gpiodrequestconfiggetconsumer*(config: ptr Gpiodrequestconfig): cstring {.
      cdecl, importc: "gpiod_request_config_get_consumer".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfiggetconsumer" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfigseteventbuffersize):
  proc gpiodrequestconfigseteventbuffersize*(config: ptr Gpiodrequestconfig;
      eventbuffersize: culong): void {.cdecl, importc: "gpiod_request_config_set_event_buffer_size".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfigseteventbuffersize" &
        " already exists, not redeclaring")
when not declared(gpiodrequestconfiggeteventbuffersize):
  proc gpiodrequestconfiggeteventbuffersize*(config: ptr Gpiodrequestconfig): culong {.
      cdecl, importc: "gpiod_request_config_get_event_buffer_size".}
else:
  static :
    hint("Declaration of " & "gpiodrequestconfiggeteventbuffersize" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestrelease):
  proc gpiodlinerequestrelease*(request: ptr Gpiodlinerequest): void {.cdecl,
      importc: "gpiod_line_request_release".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestrelease" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetchipname):
  proc gpiodlinerequestgetchipname*(request: ptr Gpiodlinerequest): cstring {.
      cdecl, importc: "gpiod_line_request_get_chip_name".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetchipname" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetnumrequestedlines):
  proc gpiodlinerequestgetnumrequestedlines*(request: ptr Gpiodlinerequest): culong {.
      cdecl, importc: "gpiod_line_request_get_num_requested_lines".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetnumrequestedlines" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetrequestedoffsets):
  proc gpiodlinerequestgetrequestedoffsets*(request: ptr Gpiodlinerequest;
      offsets: ptr cuint; maxoffsets: culong): culong {.cdecl,
      importc: "gpiod_line_request_get_requested_offsets".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetrequestedoffsets" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetvalue):
  proc gpiodlinerequestgetvalue*(request: ptr Gpiodlinerequest; offset: cuint): Gpiodlinevalue_1191182697 {.
      cdecl, importc: "gpiod_line_request_get_value".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetvalue" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetvaluessubset):
  proc gpiodlinerequestgetvaluessubset*(request: ptr Gpiodlinerequest;
                                        numvalues: culong; offsets: ptr cuint;
                                        values: ptr Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_request_get_values_subset".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetvaluessubset" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetvalues):
  proc gpiodlinerequestgetvalues*(request: ptr Gpiodlinerequest;
                                  values: ptr Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_request_get_values".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetvalues" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestsetvalue):
  proc gpiodlinerequestsetvalue*(request: ptr Gpiodlinerequest; offset: cuint;
                                 value: Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_request_set_value".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestsetvalue" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestsetvaluessubset):
  proc gpiodlinerequestsetvaluessubset*(request: ptr Gpiodlinerequest;
                                        numvalues: culong; offsets: ptr cuint;
                                        values: ptr Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_request_set_values_subset".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestsetvaluessubset" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestsetvalues):
  proc gpiodlinerequestsetvalues*(request: ptr Gpiodlinerequest;
                                  values: ptr Gpiodlinevalue_1191182697): cint {.
      cdecl, importc: "gpiod_line_request_set_values".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestsetvalues" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestreconfigurelines):
  proc gpiodlinerequestreconfigurelines*(request: ptr Gpiodlinerequest;
      config: ptr Gpiodlineconfig): cint {.cdecl,
      importc: "gpiod_line_request_reconfigure_lines".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestreconfigurelines" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestgetfd):
  proc gpiodlinerequestgetfd*(request: ptr Gpiodlinerequest): cint {.cdecl,
      importc: "gpiod_line_request_get_fd".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestgetfd" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestwaitedgeevents):
  proc gpiodlinerequestwaitedgeevents*(request: ptr Gpiodlinerequest;
                                       timeoutns: clong): cint {.cdecl,
      importc: "gpiod_line_request_wait_edge_events".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestwaitedgeevents" &
        " already exists, not redeclaring")
when not declared(gpiodlinerequestreadedgeevents):
  proc gpiodlinerequestreadedgeevents*(request: ptr Gpiodlinerequest;
                                       buffer: ptr Gpiodedgeeventbuffer;
                                       maxevents: culong): cint {.cdecl,
      importc: "gpiod_line_request_read_edge_events".}
else:
  static :
    hint("Declaration of " & "gpiodlinerequestreadedgeevents" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventfree):
  proc gpiodedgeeventfree*(event: ptr Gpiodedgeevent): void {.cdecl,
      importc: "gpiod_edge_event_free".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventfree" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventcopy):
  proc gpiodedgeeventcopy*(event: ptr Gpiodedgeevent): ptr Gpiodedgeevent {.
      cdecl, importc: "gpiod_edge_event_copy".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventcopy" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventgeteventtype):
  proc gpiodedgeeventgeteventtype*(event: ptr Gpiodedgeevent): Gpiodedgeeventtype_1191182711 {.
      cdecl, importc: "gpiod_edge_event_get_event_type".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventgeteventtype" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventgettimestampns):
  proc gpiodedgeeventgettimestampns*(event: ptr Gpiodedgeevent): culong {.cdecl,
      importc: "gpiod_edge_event_get_timestamp_ns".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventgettimestampns" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventgetlineoffset):
  proc gpiodedgeeventgetlineoffset*(event: ptr Gpiodedgeevent): cuint {.cdecl,
      importc: "gpiod_edge_event_get_line_offset".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventgetlineoffset" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventgetglobalseqno):
  proc gpiodedgeeventgetglobalseqno*(event: ptr Gpiodedgeevent): culong {.cdecl,
      importc: "gpiod_edge_event_get_global_seqno".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventgetglobalseqno" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventgetlineseqno):
  proc gpiodedgeeventgetlineseqno*(event: ptr Gpiodedgeevent): culong {.cdecl,
      importc: "gpiod_edge_event_get_line_seqno".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventgetlineseqno" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventbuffernew):
  proc gpiodedgeeventbuffernew*(capacity: culong): ptr Gpiodedgeeventbuffer {.
      cdecl, importc: "gpiod_edge_event_buffer_new".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventbuffernew" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventbuffergetcapacity):
  proc gpiodedgeeventbuffergetcapacity*(buffer: ptr Gpiodedgeeventbuffer): culong {.
      cdecl, importc: "gpiod_edge_event_buffer_get_capacity".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventbuffergetcapacity" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventbufferfree):
  proc gpiodedgeeventbufferfree*(buffer: ptr Gpiodedgeeventbuffer): void {.
      cdecl, importc: "gpiod_edge_event_buffer_free".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventbufferfree" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventbuffergetevent):
  proc gpiodedgeeventbuffergetevent*(buffer: ptr Gpiodedgeeventbuffer;
                                     index: culong): ptr Gpiodedgeevent {.cdecl,
      importc: "gpiod_edge_event_buffer_get_event".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventbuffergetevent" &
        " already exists, not redeclaring")
when not declared(gpiodedgeeventbuffergetnumevents):
  proc gpiodedgeeventbuffergetnumevents*(buffer: ptr Gpiodedgeeventbuffer): culong {.
      cdecl, importc: "gpiod_edge_event_buffer_get_num_events".}
else:
  static :
    hint("Declaration of " & "gpiodedgeeventbuffergetnumevents" &
        " already exists, not redeclaring")
when not declared(gpiodisgpiochipdevice):
  proc gpiodisgpiochipdevice*(path: cstring): bool {.cdecl,
      importc: "gpiod_is_gpiochip_device".}
else:
  static :
    hint("Declaration of " & "gpiodisgpiochipdevice" &
        " already exists, not redeclaring")
when not declared(gpiodapiversion):
  proc gpiodapiversion*(): cstring {.cdecl, importc: "gpiod_api_version".}
else:
  static :
    hint("Declaration of " & "gpiodapiversion" &
        " already exists, not redeclaring")