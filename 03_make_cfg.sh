#!/bin/bash
set -eu

echo 'Making md control (.cfg) file ...'
path_to_mdcfg_template=../templates/md.cfg

N=$( basename -a run* | wc -l )
gpu_id=0
for i in $(seq 1 $N); do
    cd run${i}
    cat $path_to_mdcfg_template | sed -e "s!#{GPUID}!${gpu_id}!g" > md.cfg

    if [ ${gpu_id} -lt 3 ]; then
        gpu_id=$((${gpu_id} + 1))
    elif [ ${gpu_id} -eq 3 ]; then
        gpu_id=0
    fi
    cd ..
done
