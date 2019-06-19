#!/bin/bash

cd ~/work/PIP3K/star/basic/

for ((i=4; i<=6; i++));  
do
STAR --runThreadN 12 \
--genomeDir ~/work/PIP3K/star/genome/ \
--sjdbGTFfile ~/work/PIP3K/star/Homo_sapiens.GRCh38.83.gtf \
--sjdbOverhang 35 \
--readFilesIn ~/work/PIP3K/trimmed_reads/SRR95498${i}_trimmed_reads.fastq \
--outFileNamePrefix SRR95498_${i}
done
