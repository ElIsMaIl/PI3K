#!/bin/bash

#Quality Controll raw_data
echo "Running fastqc..."
cd  ~/work/PIP3K/raw_data/R_1822/

#fastqc *.fastq

echo "mdkir for results_fastqc..."
mkdir -p ~/work/PIP3K/R_1822/results_fastqc/

#echo "saving..."
mv *.zip   ~/work/PIP3K/R_1822/results_fastqc/
mv *.html  ~/work/PIP3K/R_1822/results_fastqc/
cd ~/work/PIP3K/R_1822/

#Trimming
echo "starting the next step..."
echo "Trimming..."
for ((i=1; i<=8; i++));
do
R1=$(ls ~/work/PIP3K/raw_data/R_1822/1822_S2_L00${i}_R1_001.fastq)
R2=$(ls ~/work/PIP3K/raw_data/R_1822/1822_S2_L00${i}_R2_001.fastq)

trimmomatic PE -phred33 -threads 30 ${R1} ${R2} ${R1}_1_paired.fastq.gz ${R1}_1_unpaired.fastq.gz ${R2}_2_paired.fastq.gz ${R2}_2_unpaired.fastq.gz ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:20
done

echo "mkdir for results_trimmed_reads..."
mkdir -p ~/work/PIP3K/R_1822/trimmed_reads/

cd ~/work/PIP3K/raw_data/R_1822/

#echo "saving..."
mv *.fastq_1_paired.fastq.gz    ~/work/PIP3K/R_1822/trimmed_reads/
mv *.fastq_1_unpaired.fastq.gz  ~/work/PIP3K/R_1822/trimmed_reads/
mv *.fastq_2_paired.fastq.gz    ~/work/PIP3K/R_1822/trimmed_reads/
mv *.fastq_2_unpaired.fastq.gz  ~/work/PIP3K/R_1822/trimmed_reads/
cd ~/work/PIP3K/R_1822/trimmed_reads/

for f in *.gz;
do
gunzip $f
done

#Quality Controll trimmed_reads
echo "fastqc for trimmed_reads & saving..."
fastqc *.fastq
mkdir -p ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/
mv *.zip ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/
mv *.html ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/

#prepare-reference
echo "hisat2 reference build..."
mkdir -p ~/work/PIP3K/R_1822/Hisat2/
cd ~/work/PIP3K/R_1822/Hisat2/

hisat2-build -p 20 ~/work/PIP3K/ref_files/GRCm38.primary_assembly.genome.fa hisat2_ref

#Alignment
echo "starting the next step..."
echo "Alignment..."

for ((i=1; i<=8; i++));
do
R1=$(ls ~/work/PIP3K/R_1822/trimmed_reads/1822_S2_L00${i}_R1_001.fastq_1_paired.fastq)
R2=$(ls ~/work/PIP3K/R_1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq_2_paired.fastq)

hisat2 -p 20 -x ~/work/PIP3K/R_1822/Hisat2/hisat2_ref -q -1 ${R1} -2 ${R2} -S align${i}.sam
samtools view -S -b ~/work/PIP3K/R_1822/Hisat2/align${i}.sam > align${i}.bam
samtools sort ~/work/PIP3K/R_1822/Hisat2/align${i}.bam -o align${i}.sorted.bam
rm *.sam
done

#Expression Matriks berechnen
echo "Berechne Expressions Matriks..."
for ((i=1; i<=8; i++));
do
stringtie ~/work/PIP3K/R_1822/Hisat2/align${i}.sorted.bam -l stringtie_${i} -p 20 -G ~/work/PIP3K/ref_files/gencode.vM23.primary_assembly.annotation.gtf -o ~/work/PIP3K/R_1822/stringtie_assembly/stringtie_${i}.gtf
stringtie --merge -p 20 -G ~/work/PIP3K/ref_files/gencode.vM23.primary_assembly.annotation.gtf -o ~/work/PIP3K/R_1822/stringtie_assembly/stringtie_merged.gtf ~/work/PIP3K/R_1822/stringtie_assembly/stringtie_${i}.gtf
done

cd ~/work/PIP3K/R_1822/stringtie_assembly
gffcompare -r ~/work/PIP3K/ref_files/gencode.vM23.primary_assembly.annotation.gtf -G -o merged stringtie_merged.gtf

#Read Coverage Tables
echo "Estimate Transcript abundances..."
for ((i=1; i<=8; i++));
do
stringtie -e -B -p 20 -G ~/work/PIP3K/R_1822/stringtie_assembly/stringtie_merged.gtf -o ballgown/reads${i}/aligned${i}.gtf ~/work/PIP3K/R_1822/Hisat2/align${i}.sorted.bam
done
