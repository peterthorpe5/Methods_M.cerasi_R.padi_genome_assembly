#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/R.padi_genome/reads

gunzip *

/PATH_TO/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -i -k 99 -b /PATH_TO/R.padi_genome/Rp_clc.v1/blobplots/bad_contigs.fasta -p /PATH_TO/R.padi_genome/reads/Rp_R1_paired.fq /PATH_TO/R.padi_genome/reads/Rp_R2_paired.fq

gzip *.fastq


