#!/usr/bin/env python3
from __future__ import annotations
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def run(script: str, *args: str, isolated: bool = False):
    cmd = [sys.executable] + (["-I"] if isolated else []) + [str(HERE / script), *args]
    print(f"== {script} {' '.join(args)}", flush=True)
    subprocess.run(cmd, check=True, cwd=HERE)


def main():
    run("migrate.py", *(["--reset"] if "--reset" in sys.argv else []))
    run("parse_as3_protos.py")
    run("infer_opcode_messages.py")
    if (ROOT / "data/tpl/tempinfos.xml").exists():
        run("tempinfos.py", isolated=True)
    run("load_client.py")
    run("load_catalog.py")
    run("load_meta.py")
    run("load_raw.py")
    run("load_game.py")
    run("derive.py")
    run("derive_maps.py")
    run("load_map_files.py")
    run("annotate.py")
    run("build_docs.py")
    print("ok")


if __name__ == "__main__":
    main()
