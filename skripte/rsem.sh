#!/bin/bash

#echo "mkdir ref_rsem & prepare-reference..."
#mkdir -p ~/work/PIP3K/ref_rsem

#rsem-prepare-reference --gtf ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
#                       --star \
#                       -p 15 \
#                       ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
#                       ~/work/PIP3K/ref_rsem/

mkdir -p ~/work/PIP3K/test/

#for ((i=4; i<=6; i++));
#do
rsem-calculate-expression -p 15 \
                          --estimate-rspd \
                          --append-names \
                          --no-bam-output \
                      --bam ~/work/PIP3K/star_alignment/SRR954984_Aligned.toTranscriptome.out.bam \
                      /fast/users/elismaim_c/work/PIP3K/ref_rsem/ref_rsem.grp \
                      Test_exp 
                          
#done



                       

                        
