#!/bin/bash

echo "Trimming..."
for f1 in ~/work/PIP3K/raw_data/*.fastq;
do
cutadapt -a
file:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa -o ${f1%%.fastq}"_trimmed_reads.fastq.gz" $f1
done

echo "mkdir for results..."
mkdir -p ~/work/PIP3K/trimmed_reads/

cd ~/work/PIP3K/raw_data/

echo "saving..."
mv *.gz ~/work/PIP3K/trimmed_reads/
cd ~/work/PIP3K/trimmed_reads/

for f in *.gz;
do
gunzip $f
done

echo "fastqc trimmed_reads and saving..."
fastqc *.fastq
mkdir -p ~/work/PIP3K/results_trimmed_reads_fastqc/
mv *.zip ~/work/PIP3K/results_trimmed_reads_fastqc/
mv *.html ~/work/PIP3K/results_trimmed_reads_fastqc/

