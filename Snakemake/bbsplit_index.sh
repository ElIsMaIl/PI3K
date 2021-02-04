#!/bin/bash

mkdir -p /fast/users/${USER}/scratch/tmp/results/bbsplit
cd /fast/users/${USER}/scratch/tmp/results/bbsplit


bbsplit.sh ref=/fast/users/${USER}/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa,/fast/users/${USER}/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa

