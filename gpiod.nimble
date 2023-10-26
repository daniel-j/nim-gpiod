# Package

version       = "0.1.0"
author        = "djazz"
description   = "Nim wrapper of libgpiod v2"
license       = "LGPL-2.1-or-later"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"

when compiles(taskRequires):
  taskRequires "futharkgen", "futhark >= 0.11.0"
else:
  requires "futhark >= 0.11.0"

import std/os

task libgpiod, "Build libgpiod library":
  exec("rm -rf build && cd vendor/libgpiod && ./autogen.sh --prefix=\"/libgpiod\" && sed -i -e 's/ -shared / -Wl,-O1,--as-needed\\0/g' libtool && make && make DESTDIR=\"" & (currentSourcePath.parentDir / "src" / "gpiod") & "\" install")

task futharkgen, "Generate wrapper with futhark":
  rmFile "src/gpiod/futhark_libgpiod.nim"
  exec("nim c -d:release --nimcache:build/futharkgen/nimcache --out:build/futharkgen/nimcache/futharkgen src/gpiod/futharkgen")
  exec("build/futharkgen/nimcache/futharkgen")
  rmDir "build/futharkgen"

# before test:
#   libgpiodTask()
#   futharkgenTask()

before install:
  libgpiodTask()
