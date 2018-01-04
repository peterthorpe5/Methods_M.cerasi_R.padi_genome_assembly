#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/M.cerasi_genome_data/v7_cleaning


python3 ./fastq_to_sam.py Ma.Q15.blessed.interlvd.cont.cleaned.v7_1.fastq Ma.Q15.blessed.interlvd.cont.cleaned.v7_2.fastq | samtools view -S -b - > Mcerasi_v3_reads.bam

#cd/PATH_TO/M.cerasi_genome_data

#mkdir discovar_v8
cd/PATH_TO/M.cerasi_genome_data/discovar_v8_not_blessed
echo about to start 2X150 data only 

DiscovarDeNovo NUM_THREADS=16 READS=/home/PATH_TO/M.cerasi_genome_data/150/Mc.v8.150.Q15.bam OUT_DIR=/home/PATH_TO/M.cerasi_genome_data/DISCO_v8_not_blessed_all_data/just150_only/

echo about to start all data assembly


DiscovarDeNovo NUM_THREADS=16 READS=/home/PATH_TO/M.cerasi_genome_data/Mc.v8.250.Q15.bam/PATH_TO/M.cerasi_genome_data/150/Mc.v8.150.Q15.bam OUT_DIR=/home/PATH_TO/M.cerasi_genome_data/DISCO_v8_not_blessed_all_data/Mc_v8_not_blessed20151009/

echo about to start 2X250 assembly 


DiscovarDeNovo NUM_THREADS=16 READS=/home/PATH_TO/M.cerasi_genome_data/Mc.v8.250.Q15.bam OUT_DIR=/home/PATH_TO/M.cerasi_genome_data/DISCO_v8_not_blessed_all_data/just250_only/

