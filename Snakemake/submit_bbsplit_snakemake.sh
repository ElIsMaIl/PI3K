#!/bin/bash

#SBATCH --job-name=bbsplit_snakemake
#SBATCH --output=logs/%x-%j.log
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --mem=64G

export DATDIR=/fast/users/${USER}/scratch/tmp/R1820/trimmed_reads/
export DATDIR2=/fast/users/${USER}/scratch/tmp/R1822/trimmed_reads/
export REFDIRM=/fast/users/${USER}/work/PIP3K/ref_files/Mouse/
export REFDIRH=/fast/users/${USER}/work/PIP3K/ref_files/Human/
export TMPDIR=/fast/users/${USER}/scratch/tmp/bbsplit/
export LOGDIR=logs/${SLURM_JOB_NAME}-${SLURM_JOB_ID}
mkdir -p $LOGDIR
mkdir -p $TMPDIR

unset DRMAA_LIBRARY_PATH
eval "$($(which conda) shell.bash hook)"
conda activate bbsplit_snakemake

set -x

snakemake \
    --drmaa " \
    --nodes=1 \
    --mem=65,536 \
    -n 8 \
    -o $LOGDIR/%x-%j.log" \
    -j 2 \
    -p