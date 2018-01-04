#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
perl /home/PATH_TO/scratch/Downloads/phobius/phobius.pl -short APHID.v1.gene.AA.fasta > APHID.v1.gene.AA.PHOBIUS


