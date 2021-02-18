#!/bin/bash

export LOGDIR=/fast/projects/scrnaseq_pdx/work/PI3K/output/logs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
mkdir -p $LOGDIR


unset DRMAA_LIBRARY_PATH
eval "$($(which conda) shell.bash hook)"


set -x

snakemake \
    --drmaa " \
    --nodes=1 \
    --mem=64000 \
    -n 8 \
    -o $LOGDIR/%x-%j.log" \
    -j 17 \
    -p \
    --latency-wait 60 \
