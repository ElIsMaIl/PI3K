#!/bin/bash

#Quality Controll raw_data
#echo "Running fastqc..."
#cd  ~/work/PIP3K/raw_data/
#fastqc *.fastq

#echo "mdkir for results_fastqc..."
#mkdir -p ~/work/PIP3K/results_fastqc/

#echo "saving..."
#mv *.zip   ~/work/PIP3K/results_fastqc/
#mv *.html ~/work/PIP3K/results_fastqc/

#cd ~/work/PIP3K/

#Trimming
#echo "starting the next step..."
#echo "Trimming..."
#for f1 in ~/work/PIP3K/raw_data/*.fastq;
#do
#cutadapt -a file:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-SE.fa -o ${f1%%.fastq}"_trimmed_reads.fastq.gz" $f1
#done
 
#echo "mkdir for results_trimmed_reads..."
#mkdir -p ~/work/PIP3K/trimmed_reads/

#cd ~/work/PIP3K/raw_data/
 
#echo "saving..."
#mv *.gz ~/work/PIP3K/trimmed_reads/
#cd ~/work/PIP3K/trimmed_reads/
 
#for f in *.gz;
#do
#gunzip $f
#done

#Quality Controll trimmed_reads
#echo "fastqc for trimmed_reads & saving..."
#fastqc *.fastq
#mkdir -p ~/work/PIP3K/results_trimmed_reads_fastqc/
#mv *.zip ~/work/PIP3K/results_trimmed_reads_fastqc/
#mv *.html ~/work/PIP3K/results_trimmed_reads_fastqc/

#prepare-reference
#echo "mkdir ref_rsem & prepare-reference..."
#mkdir -p ~/work/PIP3K/ref_rsem/

#rsem-prepare-reference --gtf ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
 #                      --star \
 #                      -p 15 \
 #                      ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
 #                      ~/work/PIP3K/ref_rsem

#mv *.tab ~/work/PIP3K/ref_rsem/
#mv *.fa  ~/work/PIP3K/ref_rsem/
#mv *.txt ~/work/PIP3K/ref_rsem/
#mv SA SAindex ref_rsemLog.out ref_rsem.seq ref_rsem.ti ref_rsem.chrlist ref_rsem.grp Genome ~/work/PIP3K/ref_rsem/

#mkdir -p ~/work/PIP3K/ref_star/genome/
#cd ~/work/PIP3K/ref_star/genome/

#STAR --runThreadN 15 \
#     --runMode genomeGenerate \
#     --sjdbOverhang 35 \
#     --genomeDir ~/work/PIP3K/ref_star/genome \
#     --genomeFastaFiles ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
#     --sjdbGTFfile ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf

#Alignment
#echo "starting the next step..."
#echo "Alignment..."

#cd ~/work/PIP3K/
#mkdir -p ~/work/PIP3K/star_alignment/
cd ~/work/PIP3K/star_alignment/

for ((i=4; i<=6; i++));
do
STAR  --runThreadN 15 \
      --genomeDir ~/work/PIP3K/ref_star/genome \
      --sjdbGTFfile ~/work/PIP3K/ref_files/Homo_sapiens.GRCh38.83.gtf \
      --sjdbOverhang 35 \
      --outFilterType BySJout \
      --alignSJoverhangMin 8 \
      --alignSJDBoverhangMin 1 \
      --alignIntronMin 20 \
      --alignIntronMax 1000000 \
      --alignMatesGapMax 1000000 \
      --outSAMtype BAM SortedByCoordinate \
      --readFilesIn ~/work/PIP3K/trimmed_reads/SRR95498${i}_trimmed_reads.fastq \
      --outFileNamePrefix SRR95498${i}_
done
