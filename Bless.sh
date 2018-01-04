#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd /PATH_TO/R.padi_genome/R.padi_Q15_reads

/BLESS/v1p02/bless -read1 /PATH_TO/R.padi_genome/R.padi_Q15_reads/Rpadi_Q15_R1_paired.fq.gz -read2 /PATH_TO/R.padi_genome/R.padi_Q15_reads/Rpadi_Q15_R2_paired.fq.gz -prefix /PATH_TO/R.padi_genome/R.padi_Q15_reads/Rp.Q15.k21.bless -kmerlength 21 -max_mem 200 -smpthread 16
