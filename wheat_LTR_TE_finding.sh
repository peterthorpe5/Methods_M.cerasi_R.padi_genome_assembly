#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd $HOME/wheat_aphid


# LTRharvest in genome tools  http://genometools.org/documents/ltrharvest.pdf

#make the enhanced database
gt suffixerator -db wheat_aphid_alt.fasta -indexname wheat -tis -suf -lcp -des -ssp -sds -dna


#search for the beasties. 

gt ltrharvest -index wheat -mintsd 5 -maxtsd 100 > wheat_aphid_alt.fasta_LTR_harvest.out


# (optional sequence clusterin gof output

#mkvtree .... look at the pdf. 
