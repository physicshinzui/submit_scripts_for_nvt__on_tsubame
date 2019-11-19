#!/bin/bash
set -Ceu

md_no=$(cat md_stage.inp | awk '{print $1}')

n_nodes=$(ls -1 md${md_no} | wc -l)
for i in $(seq 1 ${n_nodes}); do
    cd md${md_no}/n${i}

    path_to_input=../../inputs

    echo md${md_no}/n${i} "--Pseudo output lines--"
    
#    python2.7 presto_generate_velocities.py \
#        -i      ${path_to_input}/npt_eq.pdb\
#        --i-tpl ${path_to_input}/system_1maz_filled.tpl \
#        --i-shk ${path_to_input}/system_1maz_filled.shk  \
#        -t 310  \
#        -s $RANDOM \
#        -o init.rst \
#        --mol --check >> init_velo.log
#
#    python2.7 mdinput_generator.py -i system.cfg \
#                                   -o system.cls \
#                                   -v v.0.39.h  > inputgen.log

    echo "omegagene --cfg --inp system.cls > md.out"
#    ${OMG} --cfg md.cfg --inp system.cls > md.out 

    cd ../../
    sleep 0.5
done
