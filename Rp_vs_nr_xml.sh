#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd PATH_TO/R.padi_genome/final_genome/final_genes

export BLASTDB=PATH/local/blast/ncbi

blastp -db nr -query Rp.v1.AA.fasta -evalue 0.00001 -seg no -num_threads 8 -outfmt 5 -out Rp.v1.AA.fasta_vs_NR.xml

echo .... im done
