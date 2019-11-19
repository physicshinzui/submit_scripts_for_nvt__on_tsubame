#!/bin/bash
set -eu

echo 'Making system config (.cfg) file ...'
path_to_mdcfg_template=../../templates/system.cfg
md_no=$(cat md_stage.inp | awk '{print $1}')

n_nodes=$( ls -1 md${md_no} | wc -l )
gpu_id=0
for i in $(seq 1 $n_nodes); do
    cd md${md_no}/n${i}
    cat ${path_to_mdcfg_template} | sed -e "s/#{ORST}/init.rst/g" > system.cfg
    cd ../..
done
