#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd $HOME/wheat_aphid

python run_pipeline.py

$HOME/Downloads/build_dictionary.pl --rm $HOME/wheat_aphid/GCA_001186385.1_Dnoxia_1.0_genomic.fna.preThuMar240923522016.RMoutput/ --fuzzy > wheat_fuzzy.txt

wait

$HOME/Downloads/OneCodeToFindThemAll.pl --dir $HOME/wheat_aphid/GCA_001186385.1_Dnoxia_1.0_genomic.fna.preThuMar240923522016.RMoutput --rm $HOME/wheat_aphid/GCA_001186385.1_Dnoxia_1.0_genomic.fna.preThuMar240923522016.RMoutput/GCA_001186385.1_Dnoxia_1.0_genomic.fna.out --ltr wheat_fuzzy.txt --strict --fasta 


