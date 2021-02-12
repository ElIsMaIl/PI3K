#!/bin/bash


#Quality Controll raw_data
echo "Running fastqc..."
cd  ~/work/PIP3K/samples/raw_data/R1822/

fastqc *.fastq

echo "mdkir for results_fastqc..."
mkdir -p ~/scratch/tmp/R1822/results_fastqc/

echo "saving..."
mv *.zip   ~/scratch/tmp/R1822/results_fastqc/
mv *.html  ~/scratch/tmp/R1822/results_fastqc/
cd ~/work/PIP3K/samples/raw_data/R1822/


#Trimming 1822_R2
echo "starting the next step..."
echo "Trimming..."

mkdir -p ~/scratch/tmp/R1822/trimmed_reads/
cd ~/scratch/tmp/R1822/trimmed_reads/

for ((i=1; i<=8; i++));
do
R2=$(ls ~/work/PIP3K/samples/raw_data/R1822/1822_S2_L00${i}_R2_001.fastq)

trimmomatic SE -phred33 -threads 8 ${R2} ${R2}_trimmed.fastq ILLUMINACLIP:/fast/users/elismaim_c/work/PIP3K/adapters_trim/TruSeq3-SE.fa:2:30:10 LEADING:20 TRAILING:20 MINLEN:60
done

echo "saving..."
mv *.fastq_trimmed.fastq ~/scratch/tmp/R1822/trimmed_reads/
cd ~/scratch/tmp/R1822/trimmed_reads/



#Quality Controll trimmed_reads
echo "fastqc for trimmed_reads & saving..."
fastqc *.fastq
mkdir -p ~/scratch/tmp/R1822/results_R2_trimmed_reads_fastqc/
mv *.zip ~/scratch/tmp/R1822/results_R2_trimmed_reads_fastqc/
mv *.html ~/scratch/tmp/R1822/results_R2_trimmed_reads_fastqc/

#echo "bbsplit..."
#mkdir -p ~/scratch/tmp/R1822/bbsplit/mouse/alignment_trimmed/
#cd ~/scratch/tmp/R1822/bbsplit/mouse/alignment_trimmed/

#for ((i=1; i<=8; i++));
#do
#R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq_trimmed.fastq)

#bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

#done


#echo "bbsplit..."
#mkdir -p ~/scratch/tmp/R1822/bbsplit/human/alignment_trimmed/
#cd ~/scratch/tmp/R1822/bbsplit/human/alignment_trimmed/

#for ((i=1; i<=8; i++));
#do
#R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq_trimmed.fastq)

#bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

#done


# echo "STAR genome index"
# mkdir -p ~/scratch/tmp/1822/STAR/mouse/index_trimmed/
# cd ~/scratch/tmp/1822/STAR/mouse/index_trimmed/
#
# STAR --runThreadN 8 \
#      --runMode genomeGenerate \
#      --genomeDir /fast/users/elismaim_c/scratch/tmp/1822/STAR/mouse/index_trimmed/ \
#      --genomeFastaFiles ~/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa \
#      --sjdbGTFfile ~/work/PIP3K/ref_files/Mouse/gencode.vM25.primary_assembly.annotation.gtf \
#      --sjdbOverhang 59 \
#      --genomeSAindexNbases 14 \
#      --genomeChrBinNbits 18 \
#      --genomeSAsparseD 1
#
#
# #Alignment
# echo "starting the next step..."
# echo "Alignment..."
# mkdir -p ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/
# cd ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/
#
# for ((i=1; i<=8; i++));
# do
# R2=$(ls ~/scratch/tmp/1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq.gz_trimmed.fastq)
#
# STAR  --runThreadN 8 \
#       --genomeDir /fast/users/elismaim_c/scratch/tmp/1822/STAR/mouse/index_trimmed/ \
#       --sjdbGTFfile ~/work/PIP3K/ref_files/Mouse/gencode.vM25.primary_assembly.annotation.gtf \
#       --sjdbOverhang 59 \
#       --outSAMunmapped Within \
#       --outSAMtype BAM SortedByCoordinate \
#       --readFilesIn ${R2} \
#       --outFileNamePrefix ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/1822ms_${i}
#
# done
#
# #samtools index ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/1822ms_${i}Aligned.sortedByCoord.out.bam
# #samtools view -b -F 4 ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/1822ms_${i}Aligned.sortedByCoord.out.bam > 1822ms_${i}.mapped.sorted.bam
# #samtools merge 1820h_merged.bam ~/scratch/tmp/1822/STAR/mouse/alignment_trimmed/*.mapped.sorted.bam
#
#
# #echo "STAR genome index"
# mkdir -p ~/scratch/tmp/1822/STAR/human/index_trimmed/
# cd ~/scratch/tmp/1822/STAR/human/index_trimmed/
#
# STAR --runThreadN 8 \
#      --runMode genomeGenerate \
#      --genomeDir /fast/users/elismaim_c/scratch/tmp/1822/STAR/human/index_trimmed/ \
#      --genomeFastaFiles /fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa \
#      --sjdbGTFfile /fast/users/elismaim_c/work/PIP3K/ref_files/Human/gencode.v35.primary_assembly.annotation.gtf \
#      --sjdbOverhang 59 \
#      --genomeSAindexNbases 14 \
#      --genomeChrBinNbits 18 \
#      --genomeSAsparseD 1
#
#
# #Alignment
# echo "starting the next step..."
# echo "Alignment..."
# mkdir -p ~/scratch/tmp/1822/STAR/human/alignment_trimmed/
# cd ~/scratch/tmp/1822/STAR/human/alignment_trimmed/
#
# for ((i=1; i<=8; i++));
# do
# R2=$(ls ~/scratch/tmp/1822/trimmed_reads/1822_S2_L00${i}_R2_001.fastq.gz_trimmed.fastq)
#
# STAR  --runThreadN 8 \
#       --genomeDir /fast/users/elismaim_c/scratch/tmp/1822/STAR/human/index_trimmed/ \
#       --sjdbGTFfile /fast/users/elismaim_c/work/PIP3K/ref_files/Human/gencode.v35.primary_assembly.annotation.gtf \
#       --sjdbOverhang 59 \
#       --outSAMunmapped Within \
#       --outSAMtype BAM SortedByCoordinate \
#       --readFilesIn ${R2} \
#       --outFileNamePrefix ~/scratch/tmp/1822/STAR/human/alignment_trimmed/1822hs_${i}
#
# done

#samtools index ~/scratch/tmp/1822/STAR/human/alignment_trimmed/1822hs_${i}Aligned.sortedByCoord.out.bam
#samtools view -b -F 4 ~/scratch/tmp/1822/STAR/human/alignment_trimmed/1822hs_${i}Aligned.sortedByCoord.out.bam > 1822hs_${i}.mapped.sorted.bam
#samtools merge 1822h_merged.bam ~/scratch/tmp/1822/STAR/human/alignment_trimmed/*.mapped.sorted.bam
