#!/bin/bash

#SBATCH --job-name=bbsplit_R1822
#SBATCH --mem=32G

echo "bbsplit..."
mkdir -p ~/scratch/tmp/R1822/bbsplit/mouse/alignment_trimmed/
cd ~/scratch/tmp/R1822/bbsplit/mouse/alignment_trimmed/

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Mouse/GRCm38.primary_assembly.genome.fa basename=${R2}_m_out_%.sam out_1822=${R2}_m_clean.fq ambiguous2=all refstats=statisticsM_%.txt



echo "bbsplit..."
mkdir -p ~/scratch/tmp/R1822/bbsplit/human/alignment_trimmed/
cd ~/scratch/tmp/R1822/bbsplit/human/alignment_trimmed/


R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L001_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L002_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L003_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L004_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L005_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L006_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L007_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt

R2=$(ls ~/scratch/tmp/R1822/trimmed_reads/1822_S2_L008_R2_001.fastq_trimmed.fastq)
bbsplit.sh minratio=0.56 minhits=1 maxindel=16000 in=${R2} ref=/fast/users/elismaim_c/work/PIP3K/ref_files/Human/GRCh38.primary_assembly.genome.fa basename=${R2}_h_out_%.sam out_1822=${R2}_h_clean.fq ambiguous2=all refstats=statisticsH_%.txt
