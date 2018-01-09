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
cd /PATH_TO/R.padi_genome/final_genome/RNAseq_host_non_host
echo About to run Trinity!
ulimit -s unlimited
wait



#######################################################################################################################################################################################################################################
#prepare files:
#### r.padi
echo meow
#cat PATH_TO/Rp_art_*_R1.fq.gz > Rp_art_R1.fq.gz
#cat PATH_TO/Rp_art_*_R2.fq.gz > Rp_art_R2.fq.gz

#cat PATH_TO/Rp_host_*_R1.fq.gz > Rp_host_R1.fq.gz
#cat PATH_TO/Rp_host_*_R2.fq.gz > Rp_host_R2.fq.gz

#cat PATH_TO/Rp_nonhost_*_R1.fq.gz > Rp_nonhost_R1.fq.gz
#cat PATH_TO/Rp_nonhost_*_R2.fq.gz > Rp_nonhost_R2.fq.gz

cat PATH_TO/Rp_*_R1.fq.gz > all_r1.fq.gz
cat PATH_TO/Rp_*_R2.fq.gz > all_r2.fq.gz
 

#######################################################################################################################################################################################################################################
# normalise the read

#gunzip *.gz
#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 16 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Rp_art_R1.fq --right Rp_art_R2.fq --tmp_dir_name art --pairs_together --PARALLEL_STATS
#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 16 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Rp_host_R1.fq --right Rp_host_R2.fq --tmp_dir_name host --pairs_together --PARALLEL_STATS
#/PATH_TO/Downloads/trinityrnaseq_r20140717/util/insilico_read_normalization.pl --CPU 16 --JM 220G --KMER_SIZE 31 --max_cov 50 --seqType fq --SS_lib_type FR --left Rp_nonhost_R1.fq --right Rp_nonhost_R2.fq --tmp_dir_name nonhost --pairs_together --PARALLEL_STATS


# zip these bad boys up!

#pigz -p 16 *.fq
# catatenate all the nomralise files
#cat *R1.fq.no*gz  > all_norm_R1.fq.gz
#cat *R2.fq.no*gz  > all_norm_R2.fq.gz

# zip these bad boys up!
#pigz -p 12 *.fq

#######################################################################################################################################################################################################################################
# map normalised reads to genome
#note to Carmen, we are using different versions of STAR, you will have to update the command

#index the genome
#STAR --runMode genomeGenerate --runThreadN 4 --limitGenomeGenerateRAM 74554136874 --genomeDir /PATH_TO/R.padi_genome/final_genome/star_indicies --genomeFastaFiles /PATH_TO/R.padi_genome/final_genome/Rp.v1_alt.fasta

STAR --genomeDir /PATH_TO/R.padi_genome/final_genome/star_indicies/ --runThreadN 8 --sjdbGTFfile /PATH_TO/R.padi_genome/final_genome/final_genes/gtf.Rpadi.gtf --quantMode TranscriptomeSAM --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outFilterMismatchNmax 7 --readFilesCommand zcat --readFilesIn /PATH_TO/R.padi_genome/final_genome/RNAseq_host_non_host/all_r1.fq.gz /PATH_TO/R.padi_genome/final_genome/RNAseq_host_non_host/all_r2.fq.gz --outFileNamePrefix /PATH_TO/R.padi_genome/final_genome/RNAseq_host_non_host/Rp

rm all_r1.fq.gz
rm all_r2.fq.gz
#sort the "sorted bam file"

samtools sort -@ 8 Rp_host_nonhostAligned.sortedByCoord.out.bam Rp_host_nonhost.sorted


break
kslfjdgkljfd
#######################################################################################################################################################################################################################################
echo Trinity-norm is done

# run the assembly - genome guided
#/PATH_TO/Downloads/trinityrnaseq-2.1.1/Trinity

/PATH_TO/Downloads/trinityrnaseq-2.1.1/Trinity --normalize_by_read_set --seqType fq --normalize_reads --max_memory 230G --left Rp_art_R1.fq.gz,Rp_host_R1.fq.gz,Rp_nonhost_R1.fq.gz --right Rp_art_R2.fq.gz,Rp_host_R2.fq.gz,Rp_nonhost_R2.fq.gz --SS_lib_type FR --CPU 10 --genome_guided_min_coverage 3 --min_kmer_cov 4 --genome_guided_bam Rp_host_nonhost.sorted.bam --output Rp_host_nonhost_trinity
# --full_cleanup

#######################################################################################################################################################################################################################################

#run transrate first
echo running transrate
cd ./Rp_host_nonhost_trinity
transrate --assembly Trinity-GG.fasta --left /PATH_TO/R.padi_genome/RNAseq_data/Rp_R1.fq.gz --right /PATH_TO/R.padi_genome/RNAseq_data/Rp_R2.fq.gz --threads 8

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/TrinityStats.pl Trinity-GG.fasta > trinity_assembly.txt




# map the file back to the assembly - get abundance	
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --prep_reference --transcripts good.trinty.fa --left PATH_TO/Rp_art_24h_1_R1.fq.gz --right PATH_TO/Rp_art_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_24h_1

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_24h_2_R1.fq.gz --right PATH_TO/Rp_art_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_24h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_24h_3_R1.fq.gz --right PATH_TO/Rp_art_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_24h_4_R1.fq.gz --right PATH_TO/Rp_art_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_24h_5_R1.fq.gz --right PATH_TO/Rp_art_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_3h_1_R1.fq.gz --right PATH_TO/Rp_art_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_3h_2_R1.fq.gz --right PATH_TO/Rp_art_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_3h_3_R1.fq.gz --right PATH_TO/Rp_art_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_3h_4_R1.fq.gz --right PATH_TO/Rp_art_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_art_3h_5_R1.fq.gz --right PATH_TO/Rp_art_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_art_3h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_24h_1_R1.fq.gz --right PATH_TO/Rp_host_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_24h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_24h_2_R1.fq.gz --right PATH_TO/Rp_host_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_24h_2

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_24h_3_R1.fq.gz --right PATH_TO/Rp_host_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_24h_4_R1.fq.gz --right PATH_TO/Rp_host_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_24h_5_R1.fq.gz --right PATH_TO/Rp_host_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_3h_1_R1.fq.gz --right PATH_TO/Rp_host_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_3h_2_R1.fq.gz --right PATH_TO/Rp_host_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_3h_3_R1.fq.gz --right PATH_TO/Rp_host_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_3h_4_R1.fq.gz --right PATH_TO/Rp_host_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_host_3h_5_R1.fq.gz --right PATH_TO/Rp_host_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_host_3h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_24h_1_R1.fq.gz --right PATH_TO/Rp_nonhost_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_24h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_24h_2_R1.fq.gz --right PATH_TO/Rp_nonhost_24h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_24h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_24h_3_R1.fq.gz --right PATH_TO/Rp_nonhost_24h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_24h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_24h_4_R1.fq.gz --right PATH_TO/Rp_nonhost_24h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_24h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_24h_5_R1.fq.gz --right PATH_TO/Rp_nonhost_24h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_24h_5
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_3h_1_R1.fq.gz --right PATH_TO/Rp_nonhost_3h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_3h_1
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_3h_2_R1.fq.gz --right PATH_TO/Rp_nonhost_3h_2_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_3h_2
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_3h_3_R1.fq.gz --right PATH_TO/Rp_nonhost_3h_3_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_3h_3
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_3h_4_R1.fq.gz --right PATH_TO/Rp_nonhost_3h_4_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_3h_4
                                                                                 
/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts good.trinty.fa --left PATH_TO/Rp_nonhost_3h_5_R1.fq.gz --right PATH_TO/Rp_nonhost_3h_5_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_prefix Rp_nonhost_3h_5



# generate abundance matrix

/PATH_TO/Downloads/trinityrnaseq-2.1.1/util/abundance_estimates_to_matrix.pl  --cross_sample_norm TMM --est_method kallisto Rp_art_24h_1.results Rp_art_24h_2.results Rp_art_24h_3.results Rp_art_24h_4.results Rp_art_24h_5.results Rp_art_3h_1.results Rp_art_3h_2.results Rp_art_3h_3.results Rp_art_3h_4.results Rp_art_3h_5.results Rp_host_24h_1.results Rp_host_24h_2.results Rp_host_24h_3.results Rp_host_24h_4.results Rp_host_24h_5.results Rp_host_3h_1.results Rp_host_3h_2.results Rp_host_3h_3.results Rp_host_3h_4.results Rp_host_3h_5.results Rp_nonhost_24h_1.results Rp_nonhost_24h_2.results Rp_nonhost_24h_3.results Rp_nonhost_24h_4.results Rp_nonhost_24h_5.results Rp_nonhost_3h_1.results Rp_nonhost_3h_2.results Rp_nonhost_3h_3.results Rp_nonhost_3h_4.results Rp_nonhost_3h_5.results