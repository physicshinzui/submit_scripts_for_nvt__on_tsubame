#!/bin/bash
set -eu

echo 'Making system config (.cfg) file ...'
path_to_mdcfg_template=../templates/system.cfg

N=$( basename -a run* | wc -l )
gpu_id=0
for i in $(seq 1 $N); do
    cd run${i}
    cp ${path_to_mdcfg_template} system.cfg
    cd ..
done
