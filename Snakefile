"""
Author: Mohammad El-Ismail
Affiliation: Student at Freie Universität Berlin
Aim: Workflow for single cell RNA-Seq
Date: Mon 08.April.2019
Run: snakemake -s Snakefile
Latest modification: 26.july.2019
"""

##---------------------------------------##
## A set of functions
##---------------------------------------##

import sys

def message(mes):
  sys.stderr.write("|--- " + mes + "\n")


##--------------------------------------##
## Working directory                                   
##--------------------------------------##
# Adapt to your needs

BASE_DIR = "/fast/users/elismaim_c/work/"
WDIR = BASE_DIR + "/Snakemake"
workdir: WDIR
message("The current working directory is " + WDIR)

##------------------------------------------------------##
## Variables declaration
## Declaring some variables used by Hisat2 and StringTie
##------------------------------------------------------##
# Adapt the path to your needs

GTF   = WDIR + "/ref_files/Homo_sapiens.GRCh37.75.gtf"
FASTA = WDIR + "/ref_files/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa"

##---------------------------------------##
## The list of samples to be processed
##---------------------------------------##

SAMPLES, = glob_wildcards("raw_data/{smp}_1.fastq")
NB_SAMPLES = len(SAMPLES)

for smp in SAMPLES:
  message("Sample " + smp + " will be processed")


