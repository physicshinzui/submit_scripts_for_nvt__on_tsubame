#!/bin/bash
set -Ceu

./01_build_dir

read -p "Local/PBS_TSUBAME?[l/t]" where
if [ $where == "t"  ]; then
    ./scripts_on_TSUBAME/02_make_md_cfg.sh
    ./scripts_on_TSUBAME/03_make_system_cfg.sh
    ./scripts_on_TSUBAME/submit_blocks.sh

elif [ $where == "l"  ]; then
    ./scripts_on_local/02_make_md_cfg.sh
    ./scripts_on_local/03_make_system_cfg.sh
    ./scripts_on_local/04_submit.sh

else
    echo "Wrong typing"
fi
