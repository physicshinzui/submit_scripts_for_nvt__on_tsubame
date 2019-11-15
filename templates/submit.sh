#!/bin/bash
#$ -cwd
#$ -l f_node=1
#$ -l h_rt=10:00:00
set -Ceu

JOB_SCRIPT="omega_exe.sh"

for i in $(seq 1 4); do
  cd run${i}
  bash ${JOB_SCRIPT} &
  cd ..
done
wait
