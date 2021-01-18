#!/bin/bash

#Quality Controll raw_data
#echo "Running fastqc..."
#cd  ~/work/PIP3K/raw_data/R_1822/

#fastqc *.fastq
#multiqc.

#echo "mdkir for results_fastqc..."
#mkdir -p ~/work/PIP3K/R_1822/results_fastqc/

#echo "saving..."
#mv *.zip   ~/work/PIP3K/R_1822/results_fastqc/
#mv *.html  ~/work/PIP3K/R_1822/results_fastqc/
#cd ~/work/PIP3K/R_1822/

#Trimming
#echo "starting the next step..."
#echo "Trimming..."
#for ((i=1; i<=8; i++));
#do
#R1=$(ls ~/work/PIP3K/raw_data/R_1822/1822_S2_L00${i}_R1_001.fastq)
#R2=$(ls ~/work/PIP3K/raw_data/R_1822/1822_S2_L00${i}_R2_001.fastq)

#trimmomatic PE -phred33 -threads 30 ${R1} ${R2} ${R1}_1_paired.fastq.gz ${R1}_1_unpaired.fastq.gz ${R2}_2_paired.fastq.gz ${R2}_2_unpaired.fastq.gz ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-PE.fa:2:30:10 LEADING:20 TRAILING:20 MINLEN:42
#done

#echo "mkdir for results_trimmed_reads..."
#mkdir -p ~/work/PIP3K/R_1822/trimmed_reads/

#cd ~/work/PIP3K/raw_data/R_1822/

#echo "saving..."
#mv *.fastq_1_paired.fastq.gz    ~/work/PIP3K/R_1822/trimmed_reads/
#mv *.fastq_1_unpaired.fastq.gz  ~/work/PIP3K/R_1822/trimmed_reads/
#mv *.fastq_2_paired.fastq.gz    ~/work/PIP3K/R_1822/trimmed_reads/
#mv *.fastq_2_unpaired.fastq.gz  ~/work/PIP3K/R_1822/trimmed_reads/
#cd ~/work/PIP3K/R_1822/trimmed_reads/

#for f in *.gz;
#do
#gunzip $f
#done

#Quality Controll trimmed_reads
#echo "fastqc for trimmed_reads & saving..."
#fastqc *.fastq
#multiqc.

#mkdir -p ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/
#mv *.zip ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/
#mv *.html ~/work/PIP3K/R_1822/results_trimmed_reads_fastqc/

#prepare-reference
#echo "bwa reference build..."
#mkdir -p ~/work/output/BWA/mouse/index/
#cd ~/work/output/BWA/mouse/index/


#bwa index - p mouse -a bwtsw ~/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa ~/work/PIP3K/ref_files/phix/illumina/phix.fa



#echo "STAR genome index"
#mkdir -p ~/work/output/STAR/mouse/index/
#cd ~/work/output/STAR/mouse/index/

#STAR --runThreadN 4 \
#     --runMode genomeGenerate \
#     --genomeDir ~/work/output/STAR/mouse/index/ \
#     --genomeFastaFiles ~/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa ~/work/PIP3K/ref_files/phix/illumina/phix.fa \
#     --sjdbGTFfile ~/work/PIP3K/ref_files/Mouse/gencodevM19-20181206.gtf \
#     --sjdbOverhang 100 \
#     --genomeSAindexNbases 14 \
#     --genomeChrBinNbits 18 \
#     --genomeSAsparseD 1


#Alignment
#echo "starting the next step..."
#echo "Alignment..."
#mkdir -p ~/scratch/tmp/STAR/mouse/alignment/1822/
#cd ~/scratch/tmp/STAR/mouse/alignment/1822/

#for ((i=1; i<=8; i++));
#do
#R2=$(ls ~/work/output/R_1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq.gz_2_paired.fastq)

#STAR  --runThreadN 8 \
#      --genomeDir ~/work/output/STAR/mouse/index \
#      --sjdbGTFfile ~/work/PIP3K/ref_files/Mouse/gencodevM19-20181206.gtf \
#      --sjdbOverhang 75 \
#      --outSAMunmapped Within \
#      --outSAMtype BAM SortedByCoordinate \
#      --readFilesIn ${R2} \
#      --outFileNamePrefix ~/scratch/tmp/STAR/mouse/alignment/1822/1822ms_${i} \

#done
#samtools index ~/scratch/tmp/STAR/mouse/alignment/1822/1822ms_${i}Aligned.sortedByCoord.out.bam
#samtools view -b -F 4 ~/scratch/tmp/TAR/mouse/alignment/1822/1822ms_${i}Aligned.sortedByCoord.out.bam > 1820ms_${i}.mapped.sorted.bam
#samtools merge 1822_merged.bam ~/scratch/tmp/STAR/mouse/alignment/1822/*.mapped.sorted.bam


#BWA R1 Alignment
#mkdir -p ~/scratch/tmp/BWA/mouse/alignment/1822/
#cd ~/scratch/tmp/BWA/mouse/alignment/1822/

#for((i=1;i<=8; i++));
#do
#R1=$(ls ~/work/output/R_1822/trimmed_reads/1822_S2_L00${i}_R1_001.fastq.gz_1_paired.fastq)

#bwa mem -t 8 ~/work/output/BWA/mouse/index/ ${R1} > 1822m_${i}.sam

#done

#samtools view -S -b ~/scratch/tmp/BWA/mouse/alignment/1822/1822m_${i}.sam > 1822m_${i}.bam
#samtools view -b -F 4 ~/scratch/tmp/BWA/mouse/alignment/1822/1822m_${i}.bam > 1822m_${i}.mapped.bam
#samtools sort ~/scratch/tmp/BWA/mouse/alignment/1822/1822m_${i}.mapped.bam -o 1822m_${i}.mapped.sorted.bam
#samtools index ~/scratch/tmp/BWA/mouse/alignment/1822/1822m_${i}.mapped.sorted.bam
#samtools merge 1822_merged.bam ~/scratch/tmp/BWA/mouse/alignment/1822/*.mapped.sorted.bam
#rm *.sam
