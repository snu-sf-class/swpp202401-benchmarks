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


def check_compiler_exists(compiler_dir: Path) -> bool:
    if compiler_dir.is_file() and compiler_dir.name == "swpp-compiler":
        return True
    return False


def build_asm(source_path: Path, asm_path: Path, compiler_dir: Path) -> bool:
    # TOFIX
    try:
        subprocess.run([compiler_dir, source_path, asm_path],
                       capture_output=True, check=True, encoding="utf-8")
    except subprocess.CalledProcessError as e:
        print(f"Failed to build ll from {source_path.name}")
        _print_subprocess_error(e)
        return False
    return True


def build_all_lls(benchmarks_dir: Path, compiler_dir: Path):
    for entry in benchmarks_dir.iterdir():
        if entry.is_dir() and not entry.stem.startswith("."):
            bm_name = entry.name
            bm_source_path = entry/"src"/f"{bm_name}.ll"
            bm_asm_path = entry/"src"/f"{bm_name}.s"
            build_asm(bm_source_path, bm_asm_path, compiler_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog='build-asm',
        description='Generate SWPP ASM programs from LLVM IR programs in the directory')
    parser.add_argument('compiler_dir')
    args = parser.parse_args()

    cwd = Path()
    compiler_dir = Path(args.compiler_dir)
    if not check_compiler_exists(compiler_dir):
        print("swpp-compiler not found... aborting")
        exit(1)

    print("Generating assemblies...")
    build_all_lls(cwd, compiler_dir)
