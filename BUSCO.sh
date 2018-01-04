#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/BUSCO_cegma

# need to make a symbolic link to LINAGE
mkdir LINEAGE
ln -s ~/BUSCO_v1.1b1/arthropoda ./LINEAGE/

python3 /PATH_TO/Downloads/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in Dnoxia_1.0_genomic.fna -l ./LINEAGE/arthropoda -o Dnoxia_1.0_genomic.fna_BUSCO -m OGS -f -Z 827000000  --cpu 8 --species Wheat_aphid

python3 /PATH_TO/Downloads/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in DMEL_ASM101434v1.fasta -l ./LINEAGE/arthropoda -o DMEL_ASM101434v1.fasta_BUSCO  -m genome -f -Z 827000000 --long --cpu 8 --species pea_aphid

python3 /PATH_TO/Downloads/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in Mp1087439_TGAC_V1.1-scaffolds.fa -l ./LINEAGE/arthropoda -o Mp1087439_TGAC_V1.1-scaffolds.fa_BUSCO  -m genome -f -Z 827000000 --long --cpu 8 --species pea_aphid

python3 /PATH_TO/Downloads/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in Pea_aphid_genome_no_discriptions.fasta -l ./LINEAGE/arthropoda -o Pea_aphid_genome_no_discriptions.fasta_BUSCO  -m genome -f -Z 827000000 --long --cpu 8 --species pea_aphid
