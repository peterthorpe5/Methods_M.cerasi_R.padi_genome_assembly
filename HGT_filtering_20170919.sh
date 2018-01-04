#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
###################################################################################################################
#HGT filtering. R.padi
cd /home/PATH_TO/R.padi_genome/final_genome/final_genes
gunzip *

python /home/PATH_TO/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -a 30 -i *_vs_nr_tax.tab --tax_filter_out 6656 --tax_filter_up_to 33208 -p ~/scratch/blast_databases -o LTG_results_AI_30.out

cd /home/PATH_TO/R.padi_genome/final_genome/final_genes/HGT_analysis
cp /home/PATH_TO/M.persicae_O_genome_data/final_gene_models/HGT_analysis/filter.py ./

python ~/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py --gff ../Rpa.v1.gff --LTG LTG_LGT_candifates.out -s 0 -r Rp.v1.nt.fasta_quant.sf  -g ../../R.padi_final_genome.v1.fasta  --dna ../Rp.v1.nt.fasta  -o Rp_HGT_20170913.txt


cd /home/PATH_TO/R.padi_genome/final_genome/final_genes


###################################################################################################################
# #HGT+pea+aphid

cd /home/PATH_TO/Pea_aphid/final_genes
gunzip *

python /home/PATH_TO/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -a 30 -i *_vs_nr_tax.tab --tax_filter_out 6656 --tax_filter_up_to 33208 -p ~/scratch/blast_databases -o LTG_results.out

cd /home/PATH_TO/Pea_aphid/final_genes/HGT
cp /home/PATH_TO/M.persicae_O_genome_data/final_gene_models/HGT_analysis/filter.py ./

python ~/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py --gff ../Pea_aphid.gff --LTG LTG_LGT_candifates.out -s 0 -r A.pisum_nt.fasta_quant.sf -g ../../Pea_aphid_genome_no_discriptions.fasta  --dna ../A.pisum_nt.fasta -o A.pisum_HGT_20170913.txt


#cat HGT.info.A.pisum_HGT_filteing.out | grep -v "Tribolium castaneum" | grep -v "Unclassified" | grep -v "Hordeum vulgare" > HGT.info.A.pisum_HGT_filteing.out002
#mv HGT.info.A.pisum_HGT_filteing.out002 HGT.info.A.pisum_HGT_filteing.out

cd /home/PATH_TO/Pea_aphid/final_genes
#gzip *

###################################################################################################################
#HGT filtering. Myzus persicae

cd /home/PATH_TO/M.persicae_O_genome_data/final_gene_models
gunzip *
python /home/PATH_TO/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -a 30 -i *_vs_nr_tax.tab --tax_filter_out 6656 --tax_filter_up_to 33208 -p ~/scratch/blast_databases -o LTG_results.out


cd ./HGT_analysis
python ~/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py --gff ../Mp_O_v1.gff --LTG LTG_LGT_candifates.out -s 0 -r Mp_O_v1.nt.fasta_quant.sf -g /home/PATH_TO/M.persicae_O_genome_data/altered_names/Mp1087439_TGAC_V1.1-scaffolds.fa --dna ../Mp_O_v1.nt.fasta -o Mp_O_HGT_20170913.txt

cd /home/PATH_TO/M.persicae_O_genome_data/final_gene_models
#gzip *


###################################################################################################################
#HGT filtering. Myzus cerasi
cd /home/PATH_TO/M.cerasi_genome_data/final_assembly_v1/final_genes
gunzip *
python /home/PATH_TO/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -a 30 -i *_vs_nr_tax.tab --tax_filter_out 6656 --tax_filter_up_to 33208 -p /mnt/shared/scratch/PATH_TO/blast_databases -o LTG_results.out

cd ./HGT_analysis
cp /home/PATH_TO/M.persicae_O_genome_data/final_gene_models/HGT_analysis/filter.py ./

python ~/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs_intron.py --gff ../Mc.alt.final.gff --LTG LTG_LGT_candifates.out -r ../transrate_results/M.cerasi.V1.nt.fasta_quant.sf -g ../../Mc_alt.fasta --dna ../M.cerasi.V1.nt.fasta -o Mc_HGT_20170913.txt


cd /home/PATH_TO/M.cerasi_genome_data/final_assembly_v1/final_genes
#gzip *

 ###################################################################################################################
 #HGT filtering. wheat
cd /home/PATH_TO/scratch/wheat_aphid/final_genes
gunzip *

python /home/PATH_TO/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -a 30 -i *_vs_nr_tax.tab --tax_filter_out 6656 --tax_filter_up_to 33208 -p ~/scratch/blast_databases -o LTG_results_AI_30.out

cd /home/PATH_TO/scratch/wheat_aphid/final_genes/HGT_analysis

cp /home/PATH_TO/M.persicae_O_genome_data/final_gene_models/HGT_analysis/filter.py ./

python ~/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs_intron.py --gff ../Dnox.v1_alt.gff --LTG LTG_LGT_candifates.out -s 0 -r Dnox.v1.nt.fasta_quant.sf -g ../../wheat_aphid_alt.fasta --dna ../Dnox.v1.nt.fasta -o wheay_HGT_20170913.txt


