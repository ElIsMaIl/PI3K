#!/bin/bash
 
#Quality Controll
echo "Running fastqc..."
cd  ~/work/PIP3K/raw_data/
fastqc *.fastq
 
echo "mdkir for results_fastqc..."
mkdir -p ~/work/PIP3K/results_fastqc/
 
echo "saving..."
mv *.zip   ~/work/PIP3K/results_fastqc/
mv *.html ~/work/PIP3K/results_fastqc/
 
cd ~/work/PIP3K/

echo "starting the next step..."
sh ./cutadapt.sh
