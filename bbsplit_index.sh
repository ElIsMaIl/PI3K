#!/bin/bash

SBATCH --job-name=bbsplit_indexing
SBATCH --output=/fast/users/${USER}/PI3K/Snakemake/logs/%x-%j.log
SBATCH --ntasks=8
SBATCH --nodes=1
SBATCH --mem=32G

export REFDIRM=/fast/users/${USER}/work/PIP3K/ref_files/Mouse
export REFDIRH=/fast/users/${USER}/work/PIP3K/ref_files/Human
mkdir -p /fast/users/${USER}/scratch/tmp/bbsplit
cd /fast/users/${USER}/scratch/tmp/bbsplit


bbsplit.sh ref=$REFDIRM/GRCm38.primary_assembly.genome.fa,$REFDIRH/GRCh38.primary_assembly.genome.fa

