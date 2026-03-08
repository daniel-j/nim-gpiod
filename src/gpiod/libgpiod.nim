import std/strutils
import std/os


const libgpiodPath = currentSourcePath.parentDir / "libgpiod"

#{.passC: "-I" & libgpiodPath / "include".}
{.passL: libgpiodPath / "lib" / "libgpiod.a".}

#{.push header: "gpiod.h".}

when defined(nimcheck) or not defined(futharkgen):
  include ./futhark_libgpiod
else:
  import futhark

  func futharkRenameCallback*(name: string, kind: SymbolKind, partof: string, overloading: var bool): string =
    result = name
    if kind in [Struct, Anon, Typedef, Enum] and result.len > 0:
      removePrefix(result, "struct_")
      removePrefix(result, "enum_")
      if result.len > 0:
        result[0] = result[0].toUpperAscii()

  importc:
    outputPath currentSourcePath.parentDir / "futhark_libgpiod.nim"

    path libgpiodPath / "include"

    compilerArg "-fsigned-char"

    renameCallback futharkRenameCallback

    "gpiod.h"

#{.pop.}
