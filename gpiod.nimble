# Package

version       = "0.1.0"
author        = "djazz"
description   = "Nim wrapper of libgpiod v2"
license       = "LGPL-2.1-or-later"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"
requires "futhark >= 0.9.3"

import std/os

before build:
  # build libgpiod C library
  exec("rm -rf build; cd vendor/libgpiod/; ./autogen.sh --prefix=\"/libgpiod\"; sed -i -e 's/ -shared / -Wl,-O1,--as-needed\\0/g' libtool; make; make DESTDIR=\"" & (currentSourcePath.parentDir / "build") & "\" install")
