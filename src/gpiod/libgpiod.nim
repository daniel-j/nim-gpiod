import std/strutils
import std/os

func futharkRenameCallback*(name: string; kind: string; partof: string): string =
  result = name
  if kind in ["struct", "anon", "typedef", "enum"] and result.len > 0:
    removePrefix(result, "struct_")
    removePrefix(result, "enum_")
    if result.len > 0:
      result[0] = result[0].toUpperAscii()


const libgpiodPath = currentSourcePath.parentDir / "libgpiod"

{.passC: "-I" & libgpiodPath / "include".}
{.passL: libgpiodPath / "lib" / "libgpiod.a".}

when defined(nimcheck) or not defined(futharkgen):
  {.push header: "gpiod.h".}
  include ./futhark_libgpiod
  {.pop.}
else:
  import futhark
  importc:
    outputPath currentSourcePath.parentDir / "futhark_libgpiod.nim"

    path libgpiodPath / "include"

    compilerArg "-fsigned-char"

    renameCallback futharkRenameCallback

    "gpiod.h"
