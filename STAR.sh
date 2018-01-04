#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/M.cerasi
mkdir star_indicies

# index the genome
STAR --runMode genomeGenerate --runThreadN 10 --limitGenomeGenerateRAM 74554136874 --genomeDir /PATH_TO/M.cerasi/star_indicies --genomeFastaFiles /PATH_TO/M.cerasi/Mc_v1.fasta

STAR --genomeDir star_indicies/  --runThreadN 12 --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outFilterMismatchNmax 7 --readFilesCommand zcat --outFileNamePrefix Mc --readFilesIn /PATH_TO/M.cerasi/RNAseq/Mc_R1.fq.gz /PATH_TO/M.cerasi/RNAseq/Mc_R2.fq.gz