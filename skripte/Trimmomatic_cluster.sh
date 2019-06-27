#!/bin/bash

echo "Trimming..."
for ((i=1; i<=3; i++));
do
R1=$(ls ~/work/PIP3K/raw_data/SRR204954${i}_1.fastq)
R2=$(ls ~/work/PIP3K/raw_data/SRR204954${i}_2.fastq)

trimmomatic PE -phred33 ${R1} ${R2} ${R1}_1_paired.fq.gz ${R1}_1_unpaired.fq.gz ${R2}_2_paired.fq.gz ${R2}_2_unpaired.fq.gz ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36 
done

#echo "mkdir for results..."
#mkdir -p ~/work/PIP3K/trimmed_reads/

#echo "saving..."
#mv *.fq.gz ~/work/PIP3K/trimmed_reads/
#cd ~/work/PIP3K/trimmed_reads/
#for f in *.gz;
#do
#gunzip $f
#done

#echo "fastqc trimmed_reads and saving..."
#fastqc *.fastq
#mkdir -p ~/work/PIP3K/results_trimmed_reads_fastqc/
#mv *.zip ~/work/PIP3K/results_trimmed_reads_fastqc/
#mv *.html ~/work/PIP3K/results_trimmed_reads_fastqc/
