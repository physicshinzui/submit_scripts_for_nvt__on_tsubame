#!/bin/bash
#$ -cwd

source /etc/profile.d/modules.sh
module load cuda python-extension/2.7
module load intel
module load intel-mpi

# og0_v039p works on tsubame anyway.
WORK=/gs/hs0/hp170020/kasahara/
export KKTOOLS=${WORK}/kktools
OMGROOT=${WORK}/omegagene/og0_v039p
OMGTK=${WORK}/omegagene/og0_v039p/toolkit
OMG=${OMGROOT}/omegagene_gpu
export LD_LIBRARY_PATH=/gs/hs0/hp170020/kasahara/omegagene/og0_v039p:$LD_LIBRARY_PATH

path_to_input=../../inputs
upper_gpuid=3
for id in $(seq 0 ${upper_gpuid})
do
    echo ${gpuid}

    python2.7 ${OMGTK}/presto_generate_velocities.py \
        -i      ${path_to_input}/npt_eq.pdb\
        --i-tpl ${path_to_input}/system_1maz_filled.tpl \
        --i-shk ${path_to_input}/system_1maz_filled.shk  \
        -t 310  \
        -s $RANDOM \
        -o init_${id}.rst  \
        --mol --check >> init_velo_${id}.log &

    python2.7 ${OMGTK}/mdinput_generator.py -i system.cfg \
                                            -o system.cls \
                                            -v v.0.39.h  > inputgen_${id}.log

    ${OMG} --cfg md_${id}.cfg --inp system.cls > md_${id}.out &

done
wait
