#!/bin/bash

#echo "mkdir ref_rsem & prepare-reference..."
#mkdir -p ~/work/PIP3K/ref_rsem

#rsem-prepare-reference --gtf ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
#                       --star \
#                       -p 15 \
#                       ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
#                       ~/work/PIP3K/ref_rsem/

mkdir -p ~/work/PIP3K/test/
cd ~/work/PIP3K/test/

for ((i=4; i<=6; i++));
do
rsem-calculate-expression --p15 \
                          --star \
                          --output-genome-bam \
                          ~/work/PIP3K/trimmed_reads/SRR95498${i}_trimmed_reads.fastq\
                          ~/work/PIP3K/ref_rsem 
done



                       

                        
