#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /home/PATH_TO/scratch/unique_comparisons

python interogate_clusters_for_gene_of_interest.py -i uniuq_MC_v1.0.txt -o Mc_uniq_as_base_others_uniq_orthofinder.txt

python interogate_clusters_for_gene_of_interest.py -i  Pea_unique_to_1.0.names -o Pea_unique_to_1.0.as_base_others_uniq_orthofinder.txt

python interogate_clusters_for_gene_of_interest.py -i  Rp_unique_1.0.names -o Rp_unique_1.0.as_base_others_uniq_orthofinder.txt

python interogate_clusters_for_gene_of_interest.py -i  wheat_unique_to_1.0.names -o wheat_unique_to_1.0.as_base_others_uniq_orthofinder.txt

python interogate_clusters_for_gene_of_interest.py -i  Mp_unique_to_1.0.names -o Mp_unique_to_1.0.as_base_others_uniq_orthofinder.txt
#
##########################################################
# MCL

python interogate_clusters_for_gene_of_interest.py -a ./unique_to_1.0/all_uniuq_to_1.0.txt -c all_results_eval_1e-31.abc_seq.mci -i  ./unique_to_1.0/uniuq_MC_v1.0.txt -o Mc_uniuq_as_base_others_uniuq_MCL.txt >  Mc_1.0_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./unique_to_1.0/all_uniuq_to_1.0.txt -c all_results_eval_1e-31.abc_seq.mci -i  ./unique_to_1.0/Pea_unique_to_1.0.names -o Pea_unique_to_1.0.as_base_others_uniuq_MCL.txt >  pea_1.0_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./unique_to_1.0/all_uniuq_to_1.0.txt -c all_results_eval_1e-31.abc_seq.mci -i  ./unique_to_1.0/Rp_unique_1.0.names -o Rp_unique_1.0.as_base_others_uniuq_MCL.txt >  Rp_1.0_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./unique_to_1.0/all_uniuq_to_1.0.txt -c all_results_eval_1e-31.abc_seq.mci -i  ./unique_to_1.0/wheat_unique_to_1.0.names -o wheat_unique_to_1.0.as_base_others_uniuq_MCL.txt >  wheat_1.0_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./unique_to_1.0/all_uniuq_to_1.0.txt -c all_results_eval_1e-31.abc_seq.mci -i  ./unique_to_1.0/Mp_unique_to_1.0.names -o Mp_unique_to_1.0.as_base_others_uniq_MCL.txt >  mp_1.0_genesunique_clusters.txt

##############################################
### all gene using MCL
python interogate_clusters_for_gene_of_interest.py -a ./all_gene/all.names -c all_results_eval_1e-31.abc_seq.mci -i  ./all_gene/Mc_all.names -o Mc_all.names.as_base_others_uniq_MCL.txt > Mc_all_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./all_gene/all.names -c all_results_eval_1e-31.abc_seq.mci -i  ./all_gene/pea_all.names -o pea_all.names.as_base_others_uniuq_MCL.txt > Pea_all_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./all_gene/all.names -c all_results_eval_1e-31.abc_seq.mci -i  ./all_gene/Rp_all.names -o Rp_all.names.as_base_others_uniuq_MCL.txt > Rp_all_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./all_gene/all.names -c all_results_eval_1e-31.abc_seq.mci -i  ./all_gene/wheat_all.names -o wheat_all.names.as_base_others_uniuq_MCL.txt > wheat_all_genesunique_clusters.txt

python interogate_clusters_for_gene_of_interest.py -a ./all_gene/all.names -c all_results_eval_1e-31.abc_seq.mci -i  ./all_gene/Mp_all.names -o Mp_all.names.as_base_others_uniq_MCL.txt > Mp_all_genesunique_clusters.txt

