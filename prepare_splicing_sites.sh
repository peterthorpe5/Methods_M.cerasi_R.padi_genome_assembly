#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd /home/PATH_TO/R.padi_genome/final_genome/final_genes
python extract_introns.py Rpa.v1.gff ../Rp.v1_alt.fasta 9 9 9 9 > Rp_splicesite_donaor9_9_acceptor_9_9.txt
 
python extract_introns.py Rpa.v1.gff ../Rp.v1_alt.fasta 5 4 9 0 > Rp_splicesite_donaor5_4_acceptor_9_0.txt
python extract_introns.py Rpa.v1.gff ../Rp.v1_alt.fasta 9 9 9 9 > Rp_splicesite_donaor9_9_acceptor_9_9.txt

python extract_introns.py Rpa.v1.gff ../Rp.v1_alt.fasta 4 6 9 3 > Rp_splicesite_donaor4_6_acceptor_9_3.txt

	
cd /home/PATH_TO/M.persicae_O_genome_data/final_gene_models

python extract_introns.py Mp_O_v1.gff ../Mp1087439_TGAC_V1.1-scaffolds.fa 5 4 9 0 > Mp_splicesite_donaor5_4_acceptor_9_0.txt

python extract_introns.py Mp_O_v1.gff ../Mp1087439_TGAC_V1.1-scaffolds.fa 9 9 9 9 > Mp_splicesite_donaor9_9_acceptor_9_9.txt
python extract_introns.py Mp_O_v1.gff ../Mp1087439_TGAC_V1.1-scaffolds.fa 4 6 9 3 > Mp_splicesite_donaor4_6_acceptor_9_3.txt


cd /home/PATH_TO/Pea_aphid/final_genes
python extract_introns.py reformatted.gff3 ../Pea_aphid_genome_no_discriptions.fasta 5 4 9 0 > Pea_splicesite_donaor5_4_acceptor_9_0.txt

python extract_introns.py reformatted.gff3 ../Pea_aphid_genome_no_discriptions.fasta 9 9 9 9 > Pea_splicesite_donaor9_9_acceptor_9_9.txt

python extract_introns.py reformatted.gff3 ../Pea_aphid_genome_no_discriptions.fasta 4 6 9 3 > Pea_splicesite_donaor4_6_acceptor_9_3.txt


cd /home/PATH_TO/scratch/wheat_aphid/final_genes

python extract_introns.py Dnox.v1_alt.gff ../wheat_aphid_alt.fasta 5 4 9 0 > wheat_splicesite_donaor5_4_acceptor_9_0.txt 

python extract_introns.py Dnox.v1_alt.gff ../wheat_aphid_alt.fasta 9 9 9 9 > wheat_splicesite_donaor9_9_acceptor_9_9.txt 

python extract_introns.py Dnox.v1_alt.gff ../wheat_aphid_alt.fasta 4 6 9 3 > wheat_splicesite_donaor4_6_acceptor_9_3.txt 




python filter_GFF.py -g Mc_splicesite_donaor5_4_acceptor_9_0.txt

python filter_GFF.py -g Mp_splicesite_donaor9_9_acceptor_9_9.txt

python filter_GFF.py -g Rp_splicesite_donaor9_9_acceptor_9_9.txt

python filter_GFF.py -g Mc_splicesite_donaor5_5_acceptor_5_5.txt

python filter_GFF.py -g Pea_splicesite_donaor5_4_acceptor_9_0.txt

python filter_GFF.py -g wheat_splicesite_donaor5_4_acceptor_9_0.txt

python filter_GFF.py -g Mc_splicesite_donaor9_9_acceptor_9_9.txt

python filter_GFF.py -g Pea_splicesite_donaor9_9_acceptor_9_9.txt

python filter_GFF.py -g wheat_splicesite_donaor9_9_acceptor_9_9.txt

python filter_GFF.py -g Mp_splicesite_donaor5_4_acceptor_9_0.txt

python filter_GFF.py -g Rp_splicesite_donaor5_4_acceptor_9_0.txt

wait 

###################
python filter_GFF.py -g Rp_splicesite_donaor4_6_acceptor_9_3.txt
python filter_GFF.py -g Mp_splicesite_donaor4_6_acceptor_9_3.txt
python filter_GFF.py -g Pea_splicesite_donaor4_6_acceptor_9_3.txt
python filter_GFF.py -g wheat_splicesite_donaor4_6_acceptor_9_3.txt


##############

	
/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor5_4_acceptor_9_0acceptor.fasta -o Mc_splicesite_donaor5_4_acceptor_9_0acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Pea_splicesite_donaor9_9_acceptor_9_9acceptor.fasta -o Pea_splicesite_donaor9_9_acceptor_9_9acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor5_4_acceptor_9_0donor.fasta -o Mc_splicesite_donaor5_4_acceptor_9_0donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Pea_splicesite_donaor9_9_acceptor_9_9donor.fasta -o Pea_splicesite_donaor9_9_acceptor_9_9donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor5_5_acceptor_5_5acceptor.fasta -o Mc_splicesite_donaor5_5_acceptor_5_5acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Rp_splicesite_donaor5_4_acceptor_9_0acceptor.fasta -o Rp_splicesite_donaor5_4_acceptor_9_0acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor5_5_acceptor_5_5donor.fasta -o Mc_splicesite_donaor5_5_acceptor_5_5donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Rp_splicesite_donaor5_4_acceptor_9_0donor.fasta -o Rp_splicesite_donaor5_4_acceptor_9_0donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor9_9_acceptor_9_9acceptor.fasta -o Mc_splicesite_donaor9_9_acceptor_9_9acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Rp_splicesite_donaor9_9_acceptor_9_9acceptor.fasta -o Rp_splicesite_donaor9_9_acceptor_9_9acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mc_splicesite_donaor9_9_acceptor_9_9donor.fasta -o Mc_splicesite_donaor9_9_acceptor_9_9donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Rp_splicesite_donaor9_9_acceptor_9_9donor.fasta -o Rp_splicesite_donaor9_9_acceptor_9_9donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mp_splicesite_donaor5_4_acceptor_9_0acceptor.fasta -o Mp_splicesite_donaor5_4_acceptor_9_0acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme txtacceptor.fasta -o txtacceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mp_splicesite_donaor5_4_acceptor_9_0donor.fasta -o Mp_splicesite_donaor5_4_acceptor_9_0donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme txtdonor.fasta -o txtdonor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mp_splicesite_donaor9_9_acceptor_9_9acceptor.fasta -o Mp_splicesite_donaor9_9_acceptor_9_9acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme wheat_splicesite_donaor5_4_acceptor_9_0acceptor.fasta -o wheat_splicesite_donaor5_4_acceptor_9_0acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Mp_splicesite_donaor9_9_acceptor_9_9donor.fasta -o Mp_splicesite_donaor9_9_acceptor_9_9donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme wheat_splicesite_donaor5_4_acceptor_9_0donor.fasta -o wheat_splicesite_donaor5_4_acceptor_9_0donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Pea_splicesite_donaor5_4_acceptor_9_0acceptor.fasta -o Pea_splicesite_donaor5_4_acceptor_9_0acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme wheat_splicesite_donaor9_9_acceptor_9_9acceptor.fasta -o wheat_splicesite_donaor9_9_acceptor_9_9acceptor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme Pea_splicesite_donaor5_4_acceptor_9_0donor.fasta -o Pea_splicesite_donaor5_4_acceptor_9_0donor -dna -maxsize 1000000000000000000

/mnt/apps/meme/4.10.1_4/bin/meme wheat_splicesite_donaor9_9_acceptor_9_9donor.fasta -o wheat_splicesite_donaor9_9_acceptor_9_9donor -dna -maxsize 1000000000000000000
