#!/bin/bash


export TMPDIR=/fast/users/${USER}/scratch/tmp/bbsplit
export LOGDIR=/fast/users/${USER}/scratch/tmp/bbsplit/logs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
mkdir -p $LOGDIR
mkdir -p $TMPDIR

unset DRMAA_LIBRARY_PATH
eval "$($(which conda) shell.bash hook)"
conda activate bbsplit_snakemake

set -x

snakemake \
    --drmaa " \
    --nodes=1 \
    --mem=64000 \
    -n 8 \
    -o $LOGDIR/%x-%j.log" \
    -j 16 \
    -p \
    --latency-wait 60 \
    --use-conda
