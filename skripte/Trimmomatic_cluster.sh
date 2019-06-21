#!/bin/bash

echo "Trimming..."
for f1 in ~/work/PIP3K/raw_data/*.fastq;
do
trimmomatic SE -phred33 $f1 ${f1%%.fastq}"trimmed_reads.fq.gz"
ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
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
