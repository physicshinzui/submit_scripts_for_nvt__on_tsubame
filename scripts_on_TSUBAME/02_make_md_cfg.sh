#!/bin/bash
set -Ceu

echo 'Making md control (.cfg) file ...'
path_to_mdcfg_template=../../templates/md.cfg
md_no=$(cat md_stage.inp | awk '{print $1}')

n_nodes=$( basename -a md${md_no}/n* | wc -l )
echo "No. of nodes:" ${n_nodes}

for inode in $(seq 1 ${n_nodes}); do
    cd md${md_no}/n${inode}
    cat $path_to_mdcfg_template | sed -e "s!#{GPUID}!0!g" > md_0.cfg
    cat $path_to_mdcfg_template | sed -e "s!#{GPUID}!1!g" > md_1.cfg
    cat $path_to_mdcfg_template | sed -e "s!#{GPUID}!2!g" > md_2.cfg
    cat $path_to_mdcfg_template | sed -e "s!#{GPUID}!3!g" > md_3.cfg
    cd ../../
done
