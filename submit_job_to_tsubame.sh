#!/bin/bash
#$ -cwd

#export OMP_NUM_THREADS=8
source /etc/profile.d/modules.sh
module load cuda python-extension/2.7
module load intel
module load intel-mpi

#----must be modified depending on your environment----
export KKTOOLS=/gs/hs0/hp170020/kasahara/kktools
export OMGROOT=/gs/hs0/hp170020/kasahara/omegagene/og0_v042i
OMGTK=${OMGROOT}/toolkit
OMG=${OMGROOT}/omegagene_gpu
export LD_LIBRARY_PATH=/gs/hs0/hp170020/kasahara/omegagene/og0_v042i:$LD_LIBRARY_PATH
#-----------------------------------------------------

path_to_input=../../inputs/
python2.7 ${OMGTK}/presto_generate_velocities.py \
    -i      ${path_to_input}/npt_eq.pdb\
    --i-tpl ${path_to_input}/system_1maz_filled.tpl \
    --i-shk ${path_to_input}/system_1maz_filled.shk  \
    -t 310  \
    -s $RANDOM \
    -o init.rst  \
    --mol --check >> init_velo.log &

python2.7 ${OMGTK}/mdinput_generator.py -i system.cfg \
                                        -o system.cls \
                                        -v v.0.40.c  > inputgen.log
${OMG} --cfg md.cfg --inp system.cls > ${OUT} &
