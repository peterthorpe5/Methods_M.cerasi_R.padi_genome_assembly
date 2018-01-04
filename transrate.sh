#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /home/PATH_TO/R.padi_genome/


# transrate command
transrate --assembly R.padi.v1nt.cds.fasta --left /home/PATH_TO/R.padi_genome/RNAseq_data/Rpadi_RNAseq_Q15_R1_paired.fq --right /home/PATH_TO/R.padi_genome/RNAseq_data/Rpadi_RNAseq_Q15_R2_paired.fq --threads 12


#bam read to identify chimeras. The probabilty that it is one gene - not more than one fused. 
~/transrate-tools/src/bam-read Rp_sorted.bam chimera_indetification_outfile_95.csv 0.95

~/transrate-tools/src/bam-read Rp_sorted.bam chimera_indetification_outfile_99.csv 0.99