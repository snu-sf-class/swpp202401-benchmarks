# Benchmarks for SWPP Team Project

This repository contains C programs and input/outputs for the team project of SWPP.
Note that in the final competition TAs can add more test cases or programs.

### Authors

Sung-Hwan Lee, Juneyoung Lee, Seunghyeon Nam, Woohyeon Baek

### How to build .ll file from your own C program?

1. Build `irgen`.

```
./build-irgen.sh <clang-dir>
```

2. Convert .c to .ll using c-to-ll.sh.

```
./c-to-ll.sh <.c file> <clang-dir>
```

Or, use `build-lls.py`.
This script will automatically build irgen if it does not exist,
and generate LLVM IR programs from all C programs in the subdirectory.

```
./build-lls.py <clang-dir>
```

### How to build assembly program from .ll file?

1. Build `swpp-compiler`
2. use `build-asms.py`.
This script will generate assembly programs from all LLVM IR programs
in the subdirectory.
```
./build-asms.py <full-path-to/swpp-compiler>
```
