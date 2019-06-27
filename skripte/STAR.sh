#!/bin/bash

mkdir -p ~/work/PIp3K/ref_star/genome/
cd ~/work/PIP3K/ref_star/genome/
 
STAR --runThreadN 15 \
     --runMode genomeGenerate \
     --sjdbOverhang 35 \
     --genomeDir ~/work/PIP3K/ref_star/genome \
     --genomeFastaFiles ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
     --sjdbGTFfile ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
     --limitGenomeGenerateRAM 139239734656 

#Alignment
echo "starting the next step..."
echo "Alignment..."

cd ~/work/PIP3K/
mkdir -p ~/work/PIP3K/star_alignment/
cd ~/work/PIP3K/star_alignment/

for ((i=4; i<=6; i++));
do
STAR  --runThreadN 15 \
      --genomeDir ~/work/PIP3K/ref_star/genome \
      --sjdbGTFfile ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
      --sjdbOverhang 35 \
      --outSAMunmapped Within \
      --outFilterType BySJout \
      --outSAMattributes NH HI AS NM MD \
      --outSAMstrandField intronMotif \
      --alignSJoverhangMin 8 \
      --alignSJDBoverhangMin 1 \
      --alignIntronMin 20 \
      --alignIntronMax 1000000 \
      --alignMatesGapMax 1000000 \
      --outSAMtype BAM SortedByCoordinate \
      --quantMode TranscriptomeSAM \
      --quantTranscriptomeBan IndelSoftclipSingleend \
      --readFilesIn ~/work/PIP3K/trimmed_reads/SRR95498${i}_trimmed_reads.fastq \
      --outFileNamePrefix SRR95498${i}_
done

