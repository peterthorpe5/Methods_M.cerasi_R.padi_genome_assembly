#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /home/PATH_TO/scratch/R.padi/aphid


java -jar /home/PATH_TO/Trimmomatic-0.32/trimmomatic-0.32.jar PE -threads 16 -phred33 r1.fq.gz r2.fq.gz R1.fq unwanted_R1_unpaired.fq.gz R2.fq unwanted_R2_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:61  

#rm r1.fq.gz r2.fq.gz unwanted_*
#python3 ~/misc_python/NGS/fastq_to_sam.py R1.fq R2.fq | samtools view -S -b - > reads.bam

# assembly with 
# Mira can only with with fastq no fq named files. - so rename

# assemlby with clc. It is FAST!
/mnt/apps/clcBio/clc-assembly-cell-4.1.0-linux_64/clc_assembler --cpus 16 -m 240 -w 64 -b 77 -v -o /home/PATH_TO/scratch/R.padi/aphid/clc.1.fa -p fb ss 200 800 -q -i R1.fastq R2.fastq

wait
# Map with clc it is fast!
/mnt/apps/clcBio/clc-assembly-cell-4.1.0-linux_64/clc_mapper -d /home/PATH_TO/scratch/R.padi/aphid/clc.1.fa -o contig.mapping1.cas -p fb ss 200 800 -q -i R1.fastq R2.fastq --cpus 16 -r unpairedclosest
wait 

# get the assembly stats:
perl ~/misc_python/perl_misc/scaffold_stats.pl -f clc.1.fa > clc.1.fa.STATS

##################################
wait
# get the coverage
python ~/blobtools-light-master/mapping2cov.py -a /home/PATH_TO/scratch/R.padi/aphid/clc.1.fa -cas contig.mappingl.cas -o contig.mapping1.cas.cov
wait
#######################################
# Blast against nt to identify contaiminatns.
export BLASTDB=/mnt/scratch/local/blast/ncbi/

blastn -task megablast -query clc.1.fa -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.all1.out -num_threads 16
wait

#########################################
# Blobtools to identify containant.
 ~/scratch/blobtools-master/blobtools create -i clc.1.fa  -c contig.mapping1.cas.cov -t n.clc.all1.out -o clc.1.fa.blobplots
  
 mkdir all1.fa.blobplots
 cp clc.1.fa.blobplots.blobDB.json all1.fa.blobplots/
 
 cp clc.1.fa.blobplots.blobDB.json ./all1.fa.blobplots/
 
 ~/scratch/blobtools-master/blobtools view -i  clc.1.fa.blobplots.blobDB.json -o all1.fa.blobplots/
 
~/scratch/blobtools-master/blobtools blobplot -i clc.1.fa.blobplots.blobDB.json -o all1.fa.blobplots/ 

cd all1.fa.blobplots
# These are beasties we dont want in our assembly
cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
cat *.blobDB.table.txt | grep "Ascomycota" | cut -f1 > Ascomycota.names
cat *.blobDB.table.txt | grep "Chordata" | cut -f1 > Chordata.names
cat *.blobDB.table.txt | grep "Nematoda" | cut -f1 > Nematoda.names
cat *.blobDB.table.txt | grep "Basidiomycota" | cut -f1 > Basidiomycota.names
cat *.blobDB.table.txt | grep "Proteobacteria" | cut -f1 > Proteobacteria.names
cat *.blobDB.table.txt | grep "Bacteria-undef" | cut -f1 > Bacteria-undef.names
cat *.blobDB.table.txt | grep "Viruses-undef" | cut -f1 > Viruses-undef.names 
cat *.blobDB.table.txt | awk '$5 < 10' | grep 'no-hit' | sort -k4 -rn | cut -f1 > low_cov_10.names
cat *.names >  bad_contigs.out

cd ../

# remove bad contigs
python ~/misc_python/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py clc.1.fa ./all1.fa.blobplots/bad_contigs.out clc.all.fa.contim_filtered1.fasta
# mirabait can only work with decompressed reads
pigz -p 16 -d R1.fastq.gz
pigz -p 16 -d R2.fastq.gz

# keep the reads that contribute to good contigs
/home/PATH_TO/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -I -k 99 -b clc.all.fa.contim_filtered1.fasta -p R1.fastq R2.fastq

##########################################################################################################################################################################################################
##########################################################################################################################################################################################################
# ROUND 2

# assemlby with clc. It is FAST!
/mnt/shared/bio_software/clcBio/clc-assembly-cell-4.1.0-linux_64/clc_assembler --cpus 16 -m 240 -w 64 -b 77 -v -o /home/PATH_TO/scratch/R.padi/aphid/clc.2.fa -p fb ss 200 800 -q -i bait_match_R1.fastq bait_match_R2.fastq

wait
# Map with clc it is fast!
clc_mapper -d /home/PATH_TO/scratch/R.padi/aphid/clc.2.fa -o contig.mapping2.cas -p fb ss 200 800 -q -i  bait_match_R1.fastq bait_match_R2.fastq --cpus 16 -r unpairedclosest
wait 

# get the assembly stats:
perl ~/misc_python/perl_misc/scaffold_stats.pl -f clc.2.fa > clc.2.fa.STATS

##################################
wait
# get the coverage
python ~/blobtools-light-master/mapping2cov.py -a /home/PATH_TO/scratch/R.padi/aphid/clc.2.fa -cas contig.mapping2.cas -o contig.mapping2.cas.cov
wait
#######################################
# Blast against nt to identify contaiminatns.
export BLASTDB=/mnt/scratch/local/blast/ncbi/

blastn -task megablast -query clc.2.fa -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.all2.out -num_threads 16
wait

#########################################
# Blobtools to identify containant.
 ~/scratch/blobtools-master/blobtools create -i clc.2.fa  -c contig.mapping2.cas.cov -t n.clc.all2.out -o clc.2.fa.blobplots
  
 mkdir all2.fa.blobplots
 cp clc.2.fa.blobplots.blobDB.json all2.fa.blobplots/
 
 cp clc.2.fa.blobplots.blobDB.json ./all2.fa.blobplots/
 
 ~/scratch/blobtools-master/blobtools view -i  clc.2.fa.blobplots.blobDB.json -o all2.fa.blobplots/
 
~/scratch/blobtools-master/blobtools blobplot -i clc.2.fa.blobplots.blobDB.json -o all2.fa.blobplots/ 

cd all2.fa.blobplots
# These are beasties we dont want in our assembly
cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
cat *.blobDB.table.txt | grep "Ascomycota" | cut -f1 > Ascomycota.names
cat *.blobDB.table.txt | grep "Chordata" | cut -f1 > Chordata.names
cat *.blobDB.table.txt | grep "Nematoda" | cut -f1 > Nematoda.names
cat *.blobDB.table.txt | grep "Basidiomycota" | cut -f1 > Basidiomycota.names
cat *.blobDB.table.txt | grep "Proteobacteria" | cut -f1 > Proteobacteria.names
cat *.blobDB.table.txt | grep "Bacteria-undef" | cut -f1 > Bacteria-undef.names
cat *.blobDB.table.txt | grep "Viruses-undef" | cut -f1 > Viruses-undef.names 
cat *.blobDB.table.txt | awk '$5 < 10' | grep 'no-hit' | sort -k4 -rn | cut -f1 > low_cov_10.names
cat *.names >  bad_contigs.out

cd ../

# remove bad contigs
python ~/misc_python/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py clc.2.fa ./all2.fa.blobplots/bad_contigs.out clc.all.fa.contim_filtered2.fasta
# mirabait can only work with decompressed reads
pigz -p 16 -d R1.fastq.gz
pigz -p 16 -d R2.fastq.gz

# keep the reads that contribute to good contigs
/home/PATH_TO/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -I -k 99 -b clc.all.fa.contim_filtered2.fasta -p bait_match_R1.fastq bait_match_R2.fastq


##########################################################################################################################################################################################################
##########################################################################################################################################################################################################
# ROUND 3

# assemlby with clc. It is FAST!
/mnt/shared/bio_software/clcBio/clc-assembly-cell-4.1.0-linux_64/clc_assembler --cpus 16 -m 240 -w 64 -b 77 -v -o /home/PATH_TO/scratch/R.padi/aphid/clc.3.fa -p fb ss 200 800 -q -i bait_match_bait_match_R1.fastq bait_match_bait_match_R2.fastq

wait
# Map with clc it is fast!
clc_mapper -d /home/PATH_TO/scratch/R.padi/aphid/clc.3.fa -o contig.mapping3.cas -p fb ss 200 800 -q -i bait_match_bait_match_R1.fastq bait_match_bait_match_R2.fastq --cpus 16 -r unpairedclosest
wait 

# get the assembly stats:
perl ~/misc_python/perl_misc/scaffold_stats.pl -f clc.3.fa > clc.3.fa.STATS

##################################
wait
# get the coverage
python ~/blobtools-light-master/mapping2cov.py -a /home/PATH_TO/scratch/R.padi/aphid/clc.3.fa -cas contig.mapping3.cas -o contig.mapping3.cas.cov
wait
#######################################
# Blast against nt to identify contaiminatns.
export BLASTDB=/mnt/scratch/local/blast/ncbi/

blastn -task megablast -query clc.3.fa -db nt -outfmt '6 qseqid staxids bitscore std scomnames sscinames sblastnames sskingdoms stitle' -evalue 1e-20 -out n.clc.all3.out -num_threads 16
wait

#########################################
# Blobtools to identify containant.
 ~/scratch/blobtools-master/blobtools create -i clc.3.fa  -c contig.mapping3.cas.cov -t n.clc.all3.out -o clc.3.fa.blobplots
  
 mkdir all3.fa.blobplots
 cp clc.3.fa.blobplots.blobDB.json all3.fa.blobplots/
 
 cp clc.3.fa.blobplots.blobDB.json ./all3.fa.blobplots/
 
 ~/scratch/blobtools-master/blobtools view -i  clc.3.fa.blobplots.blobDB.json -o all3.fa.blobplots/
 
~/scratch/blobtools-master/blobtools blobplot -i clc.3.fa.blobplots.blobDB.json -o all3.fa.blobplots/ 

cd all3.fa.blobplots
# These are beasties we dont want in our assembly
cat *.blobDB.table.txt | grep "Streptophyta" | cut -f1 > Streptophyta.names
cat *.blobDB.table.txt | grep "Arthropoda" | cut -f1 > Arthropoda.names
cat *.blobDB.table.txt | grep "Ascomycota" | cut -f1 > Ascomycota.names
cat *.blobDB.table.txt | grep "Chordata" | cut -f1 > Chordata.names
cat *.blobDB.table.txt | grep "Nematoda" | cut -f1 > Nematoda.names
cat *.blobDB.table.txt | grep "Basidiomycota" | cut -f1 > Basidiomycota.names
cat *.blobDB.table.txt | grep "Proteobacteria" | cut -f1 > Proteobacteria.names
cat *.blobDB.table.txt | grep "Bacteria-undef" | cut -f1 > Bacteria-undef.names
cat *.blobDB.table.txt | grep "Viruses-undef" | cut -f1 > Viruses-undef.names 
cat *.blobDB.table.txt | awk '$5 < 10' | grep 'no-hit' | sort -k4 -rn | cut -f1 > low_cov_10.names
cat *.names >  bad_contigs.out

cd ../

# remove bad contigs
python ~/misc_python/get_sequences_i_want_from_fasta_command_line_not_wanted_file.py clc.3.fa ./all3.fa.blobplots/bad_contigs.out clc.all.fa.contim_filtered3.fasta
# mirabait can only work with decompressed reads
pigz -p 16 -d R1.fastq.gz
pigz -p 16 -d R2.fastq.gz

# keep the reads that contribute to good contigs
/home/PATH_TO/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -I -k 99 -b clc.all.fa.contim_filtered3.fasta -p bait_match_bait_match_R1.fastq bait_match_bait_match_R2.fastq

ll -l > READ_file_sizes.txt

 