#!/bin/bash
#$ -cwd


# run_codon_phyml_dn_ds.sh
#
# shell to run codonphyml on all the files in a folder.
#

set -e
# Define input files and input/output directories
#
cd /home/PATH_TO/RBH/rbbh_output/dn_ds_working/Clustering/back_translated/Phylip_files

filenames=*.phy

## nucleotide version

mkdir files_done

for f in ${filenames}
do
	echo "Running codonphyml ${f}"
	cmd="codonphyml -i ${f} -m GY --fmodel F3X4 -t e -f empirical -w g -a e" #--optBrent 3
	echo ${cmd}
	eval ${cmd}
	wait
	cmd2="mv ${f} ./files_done"
	echo ${cmd2}
	eval ${cmd2}
	
done
