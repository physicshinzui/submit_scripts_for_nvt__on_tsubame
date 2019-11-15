#!/bin/bash

#----must be modified depending on your environment----
export PATH=/gs/hs0/hp170025/local/anaconda2/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/gs/hs0/hp170025/local/omegagene/og0_v039m/ ##cuda for lib.so
export PYTHONPATH=${KKTOOLS}:${PYTHONPATH}
export OMGTK=../../omegagene-master/toolkit
WORKDIR=/gs/hs0/hp170025
KKTOOLS=$WORKDIR/local/kktools
OMG=${WORKDIR}/local/omegagene/og0_v039m/omegagene_gpu
#-----------------------------------------------------

path_to_input=/Users/siida/Dropbox/01code/prestoPrep/work/mcmd/inputs
for i in $(seq 0 3); do

    python2.7 ${OMGTK}/presto_generate_velocities.py \
        -i      ${path_to_input}/npt_eq.pdb\
        --i-tpl ${path_to_input}/system_1maz_filled.tpl \
        --i-shk ${path_to_input}/system_1maz_filled.shk  \
        -t 310  \
        -s $RANDOM \
        -o init.rst  \
        --mol --check >> init_velo.log &

    python2.7 ${OMGTK}/mdinput_generator.py -i md.cfg \
                                            -o system.cls \
                                            -v v.0.39.h > inputgen.log
    ${OMG}  --cfg md.cfg --inp system.cls system.cls > ${OUT} &
done
