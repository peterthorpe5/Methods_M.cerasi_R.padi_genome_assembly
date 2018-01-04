#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

cd /PATH_TO/Mp_O/host_nonhost/

# non host
	
python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_24h_1.bam Mp_nonhost_24h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_24h_2.bam Mp_nonhost_24h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_24h_3.bam Mp_nonhost_24h_3.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_24h_4.bam Mp_nonhost_24h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_24h_5.bam Mp_nonhost_24h_5.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_3h_1.bam Mp_nonhost_3h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_3h_2.bam Mp_nonhost_3h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_3h_3.bam Mp_nonhost_3h_3.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_3h_4.bam Mp_nonhost_3h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_nonhost_3h_5.bam Mp_nonhost_3h_5.exon_counts




#host

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_24h_1.bam Mp_host_24h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_24h_2.bam Mp_host_24h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_24h_3.bam Mp_host_24h_3.exon_counts


#art

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_24h_1.bam Mp_art_24h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_24h_2.bam Mp_art_24h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_24h_3.bam Mp_art_24h_3.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_24h_4.bam Mp_art_24h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_24h_4.bam Mp_host_24h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_24h_5.bam Mp_art_24h_5.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_24h_5.bam Mp_host_24h_5.exon_counts


python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_3h_1.bam Mp_art_3h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_3h_1.bam Mp_host_3h_1.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_3h_2.bam Mp_art_3h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_3h_2.bam Mp_host_3h_2.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_3h_3.bam Mp_art_3h_3.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_3h_3.bam Mp_host_3h_3.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_3h_4.bam Mp_art_3h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_3h_4.bam Mp_host_3h_4.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_art_3h_5.bam Mp_art_3h_5.exon_counts

python /PATH_TO/scratch/dexseq_count.py --stranded no -p no -f bam -r pos /PATH_TO/Mp_O/host_nonhost/Mp_exons.gff Mp_host_3h_5.bam Mp_host_3h_5.exon_counts
