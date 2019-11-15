#!/bin/bash

inputRest=$1
refPdb=$2
outPdb=$3

python /work1/t2g-16IJ0004/siida/MD_progs/celeste/toolkit/restart_to_pdb.py \
       -i $inputRest \
       --i-pdb $refPdb \
       -o $outPdb 
