#!/bin/python3

import argparse
from pathlib import Path
import subprocess


def _print_subprocess_error(e: subprocess.CalledProcessError):
    print("stdout >>>>>")
    print(e.stdout)
    print("")
    print("stderr >>>>>")
    print(e.stderr)


def check_irgen_exists(benchmarks_dir: Path) -> bool:
    for entry in benchmarks_dir.iterdir():
        if entry.is_file() and entry.name == "irgen":
            return True
    return False


def build_irgen(clang_dir: Path) -> bool:
    try:
        subprocess.run(["./build-irgen.sh", clang_dir],
                       capture_output=True, check=True, encoding="utf-8")
    except subprocess.CalledProcessError as e:
        print(f"Failed to build irgen")
        _print_subprocess_error(e)
        return False
    return True


def build_ll(source_path: Path, clang_dir: Path) -> bool:
    try:
        subprocess.run(["./c-to-ll.sh", source_path, clang_dir],
                       capture_output=True, check=True, encoding="utf-8")
    except subprocess.CalledProcessError as e:
        print(f"Failed to build ll from {source_path.name}")
        _print_subprocess_error(e)
        return False
    return True


def build_all_lls(benchmarks_dir: Path, clang_dir: Path):
    for entry in benchmarks_dir.iterdir():
        if entry.is_dir() and not entry.stem.startswith("."):
            bm_name = entry.name
            bm_source_path = entry/"src"/f"{bm_name}.c"
            build_ll(bm_source_path, clang_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog='build-ll',
        description='Generate LLVM IR programs from C programs in the directory')
    parser.add_argument('clang_dir')
    args = parser.parse_args()

    cwd = Path()
    clang_dir = args.clang_dir
    if not check_irgen_exists(cwd):
        print("irgen not found... building irgen")
        if not build_irgen(clang_dir):
            print("Aborting")
            exit(1)

    print("Generating IR programs...")
    build_all_lls(cwd, Path(clang_dir))
