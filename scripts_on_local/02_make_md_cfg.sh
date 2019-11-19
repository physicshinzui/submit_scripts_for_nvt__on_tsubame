#!/bin/bash
set -eu

echo 'Making md control (.cfg) file ...'
path_to_mdcfg_template=../../templates/md.cfg
md_no=$(cat md_stage.inp | awk '{print $1}')

n_nodes=$( basename -a md${md_no}/n* | wc -l )
echo "No. of nodes:" ${n_nodes}

for inode in $(seq 1 ${n_nodes}); do
    cd md${md_no}/n${inode}
    cat $path_to_mdcfg_template > md.cfg
    cd ../../
done
