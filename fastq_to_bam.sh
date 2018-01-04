#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd path_to

python3 fastq_to_sam.py Rp.Q15.fastq Rp.Q15.fastq | samtools view -S -b - > Rp.v4.q15.bam

gzip *.fastq