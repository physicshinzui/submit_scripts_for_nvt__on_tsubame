#!/bin/bash

inputRest=$1
refPdb=$2
outPdb=$3

OMGTK=../../../omegagene/omegagene-master/toolkit
python ${OMGTK}/restart_to_pdb.py \
       -i $inputRest \
       --i-pdb $refPdb \
       -o $outPdb 
