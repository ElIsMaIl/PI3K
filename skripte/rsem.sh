#!/bin/bash

#echo "mkdir ref_rsem & prepare-reference..."
#mkdir -p ~/work/PIP3K/ref_rsem

#rsem-prepare-reference --gtf ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
#                       --star \
#                       -p 15 \
#                       ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
#                       ~/work/PIP3K/ref_rsem/

echo "Berechne Expressions Matriks..."
for ((i=1; i<=3; i++));
do
rsem-calculate-expression --paired-end \ 
                          --bam ~/work/PIP3K/Hisat2/align${i}.sorted.bam \ 
                          -p 20 \ 
                          /fast/users/elismaim_c/work/PIP3K/ref_rsem/ref_rsem.grp \ 
                          rsem_exp
done                                    



                       

                        
