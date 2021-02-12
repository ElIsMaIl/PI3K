#!/bin/bash

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
