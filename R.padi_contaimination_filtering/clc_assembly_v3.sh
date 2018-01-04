#!/bin/bash
#$ -cwd
#Abort on any error,

set -e

cd /home/PATH_TO/R.padi_genome/reads/v_2


/home/PATH_TO/Downloads/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -I -k 99 -b /home/PATH_TO/R.padi_genome/reads/bad_contigsv2.fasta -p /home/PATH_TO/R.padi_genome/reads/bait_miss_Rp_Q15_R1_paired.fastq /home/PATH_TO/R.padi_genome/reads/bait_miss_Rp_Q15_R2_paired.fastq

#cd /home/PATH_TO/R.padi_genome

cd /home/PATH_TO/R.padi_genome/Rp_clc.v3

/mnt/shared/bio_software/clcBio/clc-assembly-cell-4.1.0-linux_64/clc_assembler --cpus 8 -m 240 -w 64 -b 77 -v -o /home/PATH_TO/R.padi_genome/Rp_clc.v3/Rp.clc.v3_q15_20150910.fa -p fb ss 200 800 -q -i /home/PATH_TO/R.padi_genome/reads/v_2/bait_miss_bait_miss_Rp_Q15_R1_paired.fastq /home/PATH_TO/R.padi_genome/reads/v_2/bait_miss_bait_miss_Rp_Q15_R2_paired.fastq

wait

clc_mapper -d Rp.clc.v3_q15_20150910.fa -o contig.mapping250.cas -p fb ss 200 800 -q -i /home/PATH_TO/R.padi_genome/reads/v_2/bait_miss_bait_miss_Rp_Q15_R1_paired.fastq /home/PATH_TO/R.padi_genome/reads/v_2/bait_miss_bait_miss_Rp_Q15_R2_paired.fastq --cpus 8 -r unpairedclosest


##################################
wait
python ~/Downloads/blobtools-light-master/mapping2cov.py -a Rp.clc.v3_q15_20150910.fa -cas contig.mapping250.cas -o contig.mapping250.cas.cov

wait
#######################################
export BLASTDB=/mnt/scratch/local/blast/ncbi/

blastn -task megablast -query Rp.clc.v3_q15_20150910.fa -db nt -max_target_seqs 20 -culling_limit 1 -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-25 -out n.Rp.clc.v3_q15_20150910.fa.contigs.vs.nt.1e25.20seqs.cul1.out -num_threads 8

#mp blast
blastn -query Rp.clc.v3_q15_20150910.fa -db /home/PATH_TO/M.persicae_O_genome_data/Mp1087439_TGAC_V1.1-scaffolds.fa -max_target_seqs 15 -culling_limit 1 -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-25 -out n.Rp.clc.v2_q15_20150908.favs_Mp.scaffolds.out -num_threads 8

#mc blast
blastn -query Rp.clc.v3_q15_20150910.fa -db /home/PATH_TO/R.padi_genome/Mcerasi/Mc.blessed.v8.20150722.fa -max_target_seqs 15 -culling_limit 1 -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-25 -out n.Rp.clc.v2_q15_20150908.favs_Mc.blessed.v8.20150722.fa.out -num_threads 8


diamond blastx -k 25 -p 8 --sensitive -v -c1 -q Rp.clc.v3_q15_20150910.fa -d /home/PATH_TO/Downloads/uni_ref/uniref90.0.79.dmnd -a DIAMOND.diamond
wait

cat /home/PATH_TO/Downloads/uni_ref/uniref100.taxlist <(diamond view -a *.daa) | perl -ne 'chomp; if (/^UniRef100_(.*?)\t(\d+)$/) {$uniref2taxid {$1} = $2; next;} if (/^\S+\tUniRef90_(\S+)/) {@F = split /\t/; if (exists $uniref2taxid {$1}) { print join("\t", $F[0],$uniref2taxid {$1}, $F[11]) ."\n";}} ' >prelim.diamond.uniref90.domblast



 