#!/bin/bash

#Quality Controll raw_data
echo "Running fastqc..."
cd  ~/work/PIP3K/raw_data/
fastqc *.fastq

echo "mdkir for results_fastqc..."
mkdir -p ~/work/PIP3K/results_fastqc/

echo "saving..."
mv *.zip   ~/work/PIP3K/results_fastqc/
mv *.html ~/work/PIP3K/results_fastqc/

cd ~/work/PIP3K/

#Trimming
echo "starting the next step..."
echo "Trimming..."
for ((i=1; i<=3; i++));
do
R1=$(ls ~/work/PIP3K/raw_data/SRR204954${i}_1.fastq)
R2=$(ls ~/work/PIP3K/raw_data/SRR204954${i}_2.fastq)
 
trimmomatic PE -phred33 -threads 20 ${R1} ${R2} ${R1}_1_paired.fq.gz ${R1}_1_unpaired.fq.gz ${R2}_2_paired.fq.gz ${R2}_2_unpaired.fq.gz ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36
done

echo "mkdir for results_trimmed_reads..."
mkdir -p ~/work/PIP3K/trimmed_reads/

cd ~/work/PIP3K/raw_data/
 
echo "saving..."
mv *.gz ~/work/PIP3K/trimmed_reads/
cd ~/work/PIP3K/trimmed_reads/
 
for f in *.gz;
do
gunzip $f
done

#Quality Controll trimmed_reads
echo "fastqc for trimmed_reads & saving..."
fastqc *.fastq
mkdir -p ~/work/PIP3K/results_trimmed_reads_fastqc/
mv *.zip ~/work/PIP3K/results_trimmed_reads_fastqc/
mv *.html ~/work/PIP3K/results_trimmed_reads_fastqc/

#prepare-reference
echo "mkdir ref_rsem & prepare-reference..."
echo "rsem-prepare-reference..."
mkdir -p ~/work/PIP3K/ref_rsem/
cd ~/work/PIP3K/ref_rsem

rsem-prepare-reference --gtf ~/work/PIP3K/ref_files/Homo_sapiens.GRCh37.75.gtf \
                       --bowtie2 \
                       -p 20 \
                       ~/work/PIP3K/ref_files/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa \
                       ~/work/PIP3K/ref_rsem

#mv *.tab ~/work/PIP3K/ref_rsem/
#mv *.fa  ~/work/PIP3K/ref_rsem/
#mv *.txt ~/work/PIP3K/ref_rsem/
#mv SA SAindex ref_rsemLog.out ref_rsem.seq ref_rsem.ti ref_rsem.chrlist ref_rsem.grp Genome ~/work/PIP3K/ref_rsem/

echo "hisat2 reference build..."
mkdir -p ~/work/PIP3K/Hisat2/
cd ~/work/PIP3K/Hisat2/
 
hisat2-build -p 20 ~/work/PIP3K/ref_files/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa hisat2_ref

#Alignment
#echo "starting the next step..."
#echo "Alignment..."


