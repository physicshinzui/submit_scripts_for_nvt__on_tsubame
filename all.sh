#!/bin/bash
set -Ceu

echo "3" | ./01_build_dir
./02_make_md_cfg.sh
./03_make_system_cfg.sh
./script_on_TSUBAME/submit_blocks.sh
