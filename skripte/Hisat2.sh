#!/bin/bash

mkdir -p ~/work/PIP3K/Hisat2/
cd ~/work/PIP3K/Hisat2/

hisat2-build -p 20 ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa hisat2_ref

hisat2 -p 20 --dta ~/work/PIP3K/Hisat2/hisat2_ref \
~/work/PIP3K/trimmed_reads/SRR954984_trimmed_reads.fastq -S Test.sa \
--summary-file hisat2_summary.txt
