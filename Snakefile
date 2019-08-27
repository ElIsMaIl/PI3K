"""
Author: Mohammad El-Ismail
Affiliation: Student at Freie Universität Berlin
Aim: Workflow for single cell RNA-Seq
Date: Mon 08.April.2019
Run: snakemake -s Snakefile
Latest modification: 30.july.2019
"""
 
##---------------------------------------##
## A set of functions
##---------------------------------------##

import sys
import glob
from os.path import join
from snakemake.utils import R
 
def message(mes):
  sys.stderr.write("|--- " + mes + "\n")
  
##--------------------------------------##
## Working directory
##--------------------------------------##
# Adapt to your needs
 
BASE_DIR = "/fast/users/elismaim_c/work/"
WDIR = BASE_DIR + "Snakemake"
workdir: WDIR
message("The current working directory is " + WDIR)
 
##------------------------------------------------------##
## Variables declaration
## Declaring some variables used by Hisat2 and stringTie
##------------------------------------------------------##
# Adapt the path to your needs
 
GTF   = WDIR + "/ref_files/Homo_sapiens.GRCh37.75.gtf"
INDEX = WDIR + "/Hisat2/indexes/*.ht2"
FASTA = WDIR + "/ref_files/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa"
 
##---------------------------------------##
## The list of samples to be processed
##---------------------------------------##
 
SAMPLES, = glob_wildcards("samples/raw_data/{smp}_1.fastq")
NB_SAMPLES = len(SAMPLES)
 
for smp in SAMPLES:
  message("Sample " + smp + " will be processed")

rule all:
  input: expand("samples/fastqc/{smp}/{smp}_1.fastq_fastqc.zip", smp=SAMPLES),
         expand("samples/fastqc/{smp}/{smp}_2.fastq_fastqc.zip",smp=SAMPLES),
         expand("samples/trimmed/{smp}_1_t.fastq", smp=SAMPLES),
         expand("samples/trimmed/{smp}_2_t.fastq", smp=SAMPLES),
         expand("samples/fastqc_after/{smp}/{smp}_1_t.fastq_fastqc.zip", smp=SAMPLES),
         expand("samples/fastqc_after/{smp}/{smp}_2_t.fastq_fastqc.zip", smp=SAMPLES),
         expand("samples/hisat2/{smp}.sam", smp=SAMPLES),
         expand("samples/samtools/{smp}.bam", smp=SAMPLES),
         expand("samples/samtools/{smp}_sorted.bam", smp=SAMPLES),
         expand("samples/stringtie/transcript.gtf"),
         expand("samples/stringtie/gene_abundancesw.tsv"),
         expand("samples/stringtie/cov_ref.gtf"),
         expand("samples/stringtie/merge_transcripts.gtf")
 
rule fastqc:
   input: fwd=join("samples/raw_data/{smp}_1.fastq"),
          rev=join("samples/raw_data/{smp}_2.fastq")
   output:fwd="samples/fastqc/{smp}/{smp}_1.fastq_fastqc.zip",
          rev="samples/fastqc/{smp}/{smp}_2.fastq_fastqc.zip"
   message:"""--- Quality check of raw data with Fastqc."""
   shell: """
          fastqc --outdir samples/fastqc/{wildcards.smp} --extract -f fastq {input.fwd} {input.rev} """

rule trimming:
   input:  fwd=join("samples/raw_data/{smp}_1.fastq"),
           rev=join("samples/raw_data/{smp}_2.fastq")
   output: fwd="samples/trimmed/{smp}_1_t.fastq",
           rev="samples/trimmed/{smp}_2_t.fastq"
   message:"""--- Trimming."""
   shell: """
          cutadapt -a file:/fast/users/elismaim_c/work/Snakemake/samples/adapters_trim/TruSeq3-PE.fa -o {output.fwd} -p {output.rev} {input.fwd} {input.rev}
          """

rule fastqc_after:
  input:  fwd=expand("samples/trimmed/{smp}_1_t.fastq", smp=SAMPLES),
          rev=expand("samples/trimmed/{smp}_2_t.fastq", smp=SAMPLES)
  output: fwd="samples/fastqc_after/{smp}/{smp}_1_t.fastq_fastqc.zip",
          rev="samples/fastqc_after/{smp}/{smp}_2_t.fastq_fastqc.zip"
  message:"""--- Quality check of trimmed data with Fastqc."""
  shell: """
         fastqc --outdir samples/fastqc_after/{wildcards.smp} --extract -f fastq {input.fwd} {input.rev} """

rule Hisat2:
   input:  fwd="samples/trimmed/{smp}_1_t.fastq",
           rev="samples/trimmed/{smp}_2_t.fastq"
   params: index=INDEX
   output: r1="samples/hisat2/{smp}.sam"
   message:"""--- Mapping with Hisat2."""
   shell: """
           hisat2 -p 20 -x {params.index} -q -1 {input.fwd} {input.rev} -S {output.r1} """

rule create_bams:
   input:  r1=expand("samples/hisat2/{smp}.sam", smp=SAMPLES)
   output: r1="samples/samtools/{smp}.bam"
   shell: """
          samtools view -bh {input.r1} | samtools sort - -o {output.r1};samtools index {output.r1} """
 
rule stringTie:
   input:  r1=expand("samples/samtools/{smp}.bam", smp=SAMPLES)
   params: gtf=GTF
   output: r1="samples/stringtie/transcript.gtf",
           r2="samples/stringtie/gene_abundancesw.tsv",
           r3="samples/stringtie/cov_ref.gtf"
   message: """--- Expression matrix with stringTie."""
   shell: """
          stringtie -p 20 -G {params.gtf} -rf -e -B -o {output.r1} -A {output.r2} -C {output.r3} --rf {input.r1} """

rule gtf_merge:
    input: r1=expand("samples/stringtie/transcript.gtf")
    params:gtf=GTF
    output:r1="samples/stringtie/merge_transcripts.gtf"
    shell: """
           stringtie -p 20 --merge -G {params.gtf} -o {output.r1} {input.r1} """

