#!/bin/bash

N=$( basename run* | wc -l )
for i in $(seq 1 $N); do
    cd run${i}
    qsub -l f_node=1 -l h_rt=00:10:00 -N "nvt" -v OUT="md.out" ../job.sh
    #qsub -g hp170020 -l f_node=1 -l h_rt=00:10:00 -N "nvt" -v OUT="md.out" ../job.sh
    cd ..
done
