#!/bin/bash

mkdir -p /fast/projects/scrnaseq_pdx/work/PI3K/indexes/bbsplit
cd /fast/projects/scrnaseq_pdx/work/PI3K/indexes/bbsplit

bbsplit.sh ref=/fast/projects/scrnaseq_pdx/work/PI3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa,/fast/projects/scrnaseq_pdx/work/PI3K/ref_files/Human/GRCh38.primary_assembly.genome.fa

