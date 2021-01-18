#!/bin/bash

#Quality Controll raw_data
#echo "Running fastqc..."
#cd  ~/work/PIP3K/samples/raw_data/R1820/

#fastqc *.fastq.gz

#echo "mdkir for results_fastqc..."
#mkdir -p ~/work/output/R_1820/results_fastqc/

#echo "saving..."
#mv *.zip   ~/work/output/R_1820/results_fastqc/
#mv *.html  ~/work/output/R_1820/results_fastqc/
#cd ~/work/PIP3K/samples/raw_data/R1820/

#Trimming
#echo "starting the next step..."
#echo "Trimming..."
#for ((i=1; i<=8; i++));
#do
#R1=$(ls ~/work/PIP3K/samples/raw_data/R1820/1820_S1_L00${i}_R1_001.fastq.gz)
#R2=$(ls ~/work/PIP3K/samples/raw_data/R1820/1820_S1_L00${i}_R2_001.fastq.gz)

#trimmomatic PE -phred33 -threads 40 ${R1} ${R2} ${R1}_1_paired.fastq.gz ${R1}_1_unpaired.fastq.gz ${R2}_2_paired.fastq.gz  ${R2}_2_unpaired.fastq.gz ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa:2:30:10 LEADING:20 TRAILING:20 MINLEN:42
#done

#echo "mkdir for results_trimmed_reads..."
#mkdir -p ~/work/output/R_1820/trimmed_reads/

#cd ~/work/PIP3K/samples/raw_data/R1820/

#echo "saving..."
#mv *.fastq.gz_1_paired.fastq.gz    ~/work/output/R_1820/trimmed_reads/
#mv *.fastq.gz_1_unpaired.fastq.gz  ~/work/output/R_1820/trimmed_reads/
#mv *.fastq.gz_2_paired.fastq.gz    ~/work/output/R_1820/trimmed_reads/
#mv *.fastq.gz_2_unpaired.fastq.gz  ~/work/output/R_1820/trimmed_reads/
#cd ~/work/output/R_1820/trimmed_reads/

#for f in *.gz;
#do
#gunzip $f
#done

#Quality Controll trimmed_reads
#echo "fastqc for trimmed_reads & saving..."
#fastqc *.fastq
#mkdir -p ~/work/output/R_1820/results_trimmed_reads_fastqc/
#mv *.zip ~/work/output/R_1820/results_trimmed_reads_fastqc/
#mv *.html ~/work/output/R_1820/results_trimmed_reads_fastqc/

#Prepare-reference
#echo "bwa reference build..."
#mkdir -p ~/work/output/BWA/human/index/
#cd ~/work/output/BWA/human/index/

#bwa index -p human_idx -a bwtsw ~/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa ~/work/PIP3K/ref_files/phix/illumina/phix.fa

#BWA R1 Alignment
#mkdir -p ~/scratch/tmp/BWA/human/alignment/1820/
#cd ~/scratch/tmp/BWA/human/alignment/1820/

#for((i=1; i<=8; i++));
#do
#R1=$(ls ~/work/output/R_1820/trimmed_reads/1820_S1_L00${i}_R1_001.fastq.gz_1_paired.fastq)

#bwa mem -t 8 /fast/users/elismaim_c/work/output/BWA/human/index ${R1} > 1820h_${i}.sam

#done

#samtools view -S -b ~/scratch/tmp/BWA/human/alignment/1820/1820h_${i}.sam > 1820h_${i}.bam
#samtools view -b -F 4 ~/scratch/tmp/BWA/human/alignment/1820/1820h_${i}.bam > 1820h_${i}.mapped.bam
#samtools sort ~/scratch/tmp/BWA/human/alignment/1820/1820h_${i}.mapped.bam -o 1820h_${i}.mapped.sorted.bam
#samtools index ~/scratch/tmp/BWA/human/alignment/1820/1820h_${i}.mapped.sorted.bam
#samtools merge 1820h_merged.bam ~/scratch/tmp/BWA/human/alignment/1820/*.mapped.sorted.bam
#rm *.sam


#echo "STAR genome index"
# mkdir -p ~/scratch/tmp/1820/STAR/index_trimmed_hm/
# cd ~/scratch/tmp/1820/STAR/index_trimmed_hm/
#
# STAR --runThreadN 8 \
#      --runMode genomeGenerate \
#      --genomeDir ~/scratch/tmp/1820/STAR/index_trimmed_hm/ \
#      --genomeFastaFiles ~/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa ~/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa \
#      --sjdbGTFfile ~/work/PIP3K/ref_files/Human/gencode.v35.primary_assembly.annotation.gtf ~/work/PIP3K/ref_files/Mouse/gencode.vM25.primary_assembly.annotation.gtf \
#      --sjdbOverhang 59 \
#      --genomeSAindexNbases 14 \
#      --genomeChrBinNbits 18 \
#      --genomeSAsparseD 1
#
# #Alignment
# echo "starting the next step..."
# echo "Alignment..."
# mkdir -p ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/
# cd ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/
#
# for ((i=1; i<=8; i++));
# do
# R2=$(ls ~/scratch/tmp/1820/trimmed_reads/1820_S1_L00${i}_R2_001.fastq.gz_trimmed.fastq)
#
#  STAR  --runThreadN 8 \
#        --genomeDir ~/scratch/tmp/1820/STAR/index_trimmed_hm/ \
#        --sjdbGTFfile ~/work/PIP3K/ref_files/Human/gencode.v35.primary_assembly.annotation.gtf ~/work/PIP3K/ref_files/Mouse/gencode.vM25.primary_assembly.annotation.gtf \
#        --sjdbOverhang 59 \
#        --outSAMunmapped Within \
#        --outSAMtype BAM SortedByCoordinate \
#        --readFilesIn ${R2} \
#        --outFileNamePrefix ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/1820hm_${i}
#
# done

#samtools index ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/1820hm_${i}Aligned.sortedByCoord.out.bam
#samtools view -b -F 4 ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/1820hm_${i}Aligned.sortedByCoord.out.bam > 1820hm_${i}.mapped.sorted.bam
#samtools merge 1820hm_merged.bam ~/scratch/tmp/1820/STAR/alignment_trimmed_hm/*.mapped.sorted.bam
