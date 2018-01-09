#!/bin/bash
#$ -cwd

#Abort on any error,
set -e

echo Running on $HOSTNAME
#echo Current PATH is $PATH
#source ~/.bash_profile

#export PATH=$HOME/bin:$PATH
#echo Revised PATH is $PATH

#This will give an error if bowtie is not on the $PATH
#(and thus quit the script right away)
#which bowtie
cd /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly
echo About to run Trinity!
ulimit -s unlimited
wait

#######################################################################################################################################################################################################################################
#prepare files:
### Mp
cat PATH_TO/Mp_art_*_R1.fq.gz > Mp_art_R1.fq.gz
cat PATH_TO/Mp_art_*_R2.fq.gz > Mp_art_R2.fq.gz
cat PATH_TO/Mp_host_*_R1.fq.gz > Mp_host_R1.fq.gz
cat PATH_TO/Mp_host_*_R2.fq.gz > Mp_host_R2.fq.gz
cat PATH_TO/Mp_nonhost_*_R1.fq.gz > Mp_nonhost_R1.fq.gz
cat PATH_TO/Mp_nonhost_*_R2.fq.gz > Mp_nonhost_R2.fq.gz
cat PATH_TO/Mp_*_R1.fq.gz > all_r1.fq.gz
cat PATH_TO/Mp_*_R2.fq.gz > all_r2.fq.gz

echo Trinity-norm is done


#######################################################################################################################################################################################################################################
# normalise the read


#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 12 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Mp_art_R1.fq --right Mp_art_R2.fq --tmp_dir_name art --pairs_together --PARALLEL_STATS
#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 12 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Mp_host_R1.fq --right Mp_host_R2.fq --tmp_dir_name host --pairs_together --PARALLEL_STATS
#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 12 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Mp_nonhost_R1.fq --right Mp_nonhost_R2.fq --tmp_dir_name nonhost --pairs_together --PARALLEL_STATS

# catatenate all the nomralise files
#cat *R1.fq.no*  > all_norm_R1.fq
#cat *R2.fq.no*  > all_norm_R2.fq

# zip these bad boys up!
#pigz -p 12 *.gz

#######################################################################################################################################################################################################################################
# STAR map to genome - 
#map normalised reads to genome

#STAR --genomeDir /PATH_TO/M.persicae_O_genome_data/star_indicies/  --runThreadN 16 --sjdbGTFfile /PATH_TO/M.persicae_O_genome_data/final_gene_models/Mp_O_v1.gtf --quantMode TranscriptomeSAM --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outFilterMismatchNmax 7 --readFilesCommand zcat --outFileNamePrefix /PATH_TO/M.persicae_O_genome_data/Mp_host_nonhost --readFilesIn /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly/all_norm_R1.fq.gz /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly/all_norm_R2.fq.gz


#sort the "sorted bam file"

#samtools sort -@ 16 Mp_host_nonhostAligned.sortedByCoord.out.bam Mp_host_nonhost.sorted

#######################################################################################################################################################################################################################################
# trinity GenomeGuided assembly
echo about to run trinity

/PATH_TO/Downloads/trinityrnaseq-2.1.1/Trinity --seqType fq --genome_guided_max_intron 58122 --max_memory 230G --left /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly/all_norm_R1.fq.gz --right /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly/all_norm_R2.fq.gz --SS_lib_type FR --CPU 12 --genome_guided_min_coverage 4 --min_kmer_cov 3 --genome_guided_bam Mp_host_nonhost.sorted.bam --output Mp_host_nonhost_trinity 
#--full_cleanup option does not work correctly with an output name


cd /PATH_TO/M.persicae_O_genome_data/host_nonhost/RNAseq_assembly/Mp_host_nonhost_trinity

# transrate
transrate --assembly Trinity-GG.fasta --left /PATH_TO/M.persicae_O_genome_data/RNAseq/Mp_O_R1.fq.gz --right /PATH_TO/M.persicae_O_genome_data/RNAseq/Mp_O_R2.fq.gz --threads 12


/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/TrinityStats.pl Trinity-GG.fasta > trinity_assembly.txt

# map the file back to the assembly - get abundance	
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --prep_reference --transcripts good.trinty.fa --left PATH_TO/Mp_art_24h_1_R1.fq.gz --right PATH_TO/Mp_art_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_24h_1

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_24h_2_R1.fq.gz --right PATH_TO/Mp_art_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_24h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_24h_3_R1.fq.gz --right PATH_TO/Mp_art_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_24h_4_R1.fq.gz --right PATH_TO/Mp_art_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_24h_5_R1.fq.gz --right PATH_TO/Mp_art_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_3h_1_R1.fq.gz --right PATH_TO/Mp_art_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_3h_2_R1.fq.gz --right PATH_TO/Mp_art_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_3h_3_R1.fq.gz --right PATH_TO/Mp_art_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_3h_4_R1.fq.gz --right PATH_TO/Mp_art_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_art_3h_5_R1.fq.gz --right PATH_TO/Mp_art_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_art_3h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_24h_1_R1.fq.gz --right PATH_TO/Mp_host_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_24h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_24h_2_R1.fq.gz --right PATH_TO/Mp_host_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_24h_2

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_24h_3_R1.fq.gz --right PATH_TO/Mp_host_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_24h_4_R1.fq.gz --right PATH_TO/Mp_host_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_24h_5_R1.fq.gz --right PATH_TO/Mp_host_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_3h_1_R1.fq.gz --right PATH_TO/Mp_host_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_3h_2_R1.fq.gz --right PATH_TO/Mp_host_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_3h_3_R1.fq.gz --right PATH_TO/Mp_host_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_3h_4_R1.fq.gz --right PATH_TO/Mp_host_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_host_3h_5_R1.fq.gz --right PATH_TO/Mp_host_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_host_3h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_24h_1_R1.fq.gz --right PATH_TO/Mp_nonhost_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_24h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_24h_2_R1.fq.gz --right PATH_TO/Mp_nonhost_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_24h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_24h_3_R1.fq.gz --right PATH_TO/Mp_nonhost_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_24h_4_R1.fq.gz --right PATH_TO/Mp_nonhost_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_24h_5_R1.fq.gz --right PATH_TO/Mp_nonhost_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_3h_1_R1.fq.gz --right PATH_TO/Mp_nonhost_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_3h_2_R1.fq.gz --right PATH_TO/Mp_nonhost_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_3h_3_R1.fq.gz --right PATH_TO/Mp_nonhost_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_3h_4_R1.fq.gz --right PATH_TO/Mp_nonhost_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Mp_nonhost_3h_5_R1.fq.gz --right PATH_TO/Mp_nonhost_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Mp_nonhost_3h_5

# generate abundance matrix

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/abundance_estimates_to_matrix.pl  --cross_sample_norm TMM --est_method kallisto Mp_art_24h_1.results Mp_art_24h_2.results Mp_art_24h_3.results Mp_art_24h_4.results Mp_art_24h_5.results Mp_art_3h_1.results Mp_art_3h_2.results Mp_art_3h_3.results Mp_art_3h_4.results Mp_art_3h_5.results Mp_host_24h_1.results Mp_host_24h_2.results Mp_host_24h_3.results Mp_host_24h_4.results Mp_host_24h_5.results Mp_host_3h_1.results Mp_host_3h_2.results Mp_host_3h_3.results Mp_host_3h_4.results Mp_host_3h_5.results Mp_nonhost_24h_1.results Mp_nonhost_24h_2.results Mp_nonhost_24h_3.results Mp_nonhost_24h_4.results Mp_nonhost_24h_5.results Mp_nonhost_3h_1.results Mp_nonhost_3h_2.results Mp_nonhost_3h_3.results Mp_nonhost_3h_4.results Mp_nonhost_3h_5.results