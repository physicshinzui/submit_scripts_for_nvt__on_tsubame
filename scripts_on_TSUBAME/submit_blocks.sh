#!/bin/bash
set -eu

PATH_SCRIPTS=../../script_on_TSUBAME/
md_no=$(cat md_stage.inp | awk '{print $1}')

# Submit each job block to nodes on TSUBAME
n_nodes=$(ls -1 md${md_no} | wc -l)
for i in $(seq 1 ${n_nodes}); do
  cd md${md_no}/n${i}
  echo "qsub -l f_node=1 -l h_rt=00:10:00 -N "NVT" ${PATH_SCRIPTS%/}/job_block.sh"
  qsub -l f_node=1 -l h_rt=00:10:00 -N "NVT" ${PATH_SCRIPTS%/}/job_block.sh
  cd ../..
  sleep 0.1s
done
