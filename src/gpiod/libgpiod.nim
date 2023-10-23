import std/strutils
import std/os
import futhark

func futharkRenameCallback*(name: string; kind: string; partof: string): string =
  result = name
  if kind in ["struct", "anon", "typedef", "enum"] and result.len > 0:
    removePrefix(result, "struct_")
    removePrefix(result, "enum_")
    if result.len > 0:
      result[0] = result[0].toUpperAscii()


const libgpiodPath = currentSourcePath.parentDir / ".." / ".." / "build" / "libgpiod"

{.passL: libgpiodPath / "lib" / "libgpiod.a".}

importc:
  outputPath currentSourcePath.parentDir / "futhark_libgpiod.nim"

  path libgpiodPath / "include"

  compilerArg "-fsigned-char"

  renameCallback futharkRenameCallback

  "gpiod.h"
