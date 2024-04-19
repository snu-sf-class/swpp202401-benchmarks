#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "c-to-ll.sh <.c file> <clang dir>"
  echo "ex)  ./c-to-ll.sh ./bubble_sort/src/bubble_sort.c ~/llvm-18.1.0/bin"
  exit 1
fi

IRGEN=`dirname "$BASH_SOURCE"`/irgen
if [[ ! -f "$IRGEN" ]]; then
  echo "irgen is not built! please run ./build.sh <clang dir>"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  ISYSROOT=
fi

CXX=$2/clang
set -e
$CXX -S -emit-llvm $ISYSROOT -O1 -fno-strict-aliasing -fno-discard-value-names -g0 $1 \
    -mllvm -disable-llvm-optzns -o /tmp/a.ll
$IRGEN /tmp/a.ll "${1%.c}.ll"
