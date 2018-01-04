#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /home/PATH_TO/R.padi_genome


python /home/PATH_TO/Downloads/SPAdes-3.6.0-Linux/bin/spades.py -k 21,55,77,99,105,127 -1 /home/PATH_TO/R.padi_genome/temp_reads/R1.fastq.gz -2 /home/PATH_TO/R.padi_genome/temp_reads/R2.fastq.gz --careful --memory 250 -t 9 -o spades_v1_q15_error_correct_20150907
