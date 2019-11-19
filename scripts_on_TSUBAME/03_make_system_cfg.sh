#!/bin/bash
set -eu

echo 'Making system config (.cfg) file ...'
path_to_mdcfg_template=../../templates/system.cfg
md_no=$(cat md_stage.inp | awk '{print $1}')

n_nodes=$( ls -1 md${md_no} | wc -l )
gpu_id=0
for i in $(seq 1 $n_nodes); do
    cd md${md_no}/n${i}
    cat ${path_to_mdcfg_template} | sed -e "s/#{ORST}/init_0.rst/g" > system_0.cfg
    cat ${path_to_mdcfg_template} | sed -e "s/#{ORST}/init_1.rst/g" > system_1.cfg
    cat ${path_to_mdcfg_template} | sed -e "s/#{ORST}/init_2.rst/g" > system_2.cfg
    cat ${path_to_mdcfg_template} | sed -e "s/#{ORST}/init_3.rst/g" > system_3.cfg
    cd ../..
done
