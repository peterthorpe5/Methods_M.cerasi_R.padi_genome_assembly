#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/R.padi_Braker

#braker.pl [OPTIONS] --genome=genome.fa --bam=rnaseq.bam

# the way to generate hints for braker!!!

bam2hints --intronsonly --in=rnaseq.fs.bam --out=hints.gff
/PATH_TO/augustus-3.1/bin/bam2hints


#using hints using pea aphid
cd /PATH_TO/R.padi_Braker
braker.pl --hints=Rp.v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --useexisting --species=pea_aphid --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --UTR on --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/R.padi_Braker --genome=Rp.v1_alt.fasta


#using hints using de novo models
cd /PATH_TO/R.padi_Braker/de_novo/
braker.pl --hints=../Rp.v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --species=R_padi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/R.padi_Braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/R.padi_Braker/de_novo --genome=../Rp.v1_alt.fasta


# now using "complete gene calls only" - using the Rpadigene models already generated.  braker_complete_gene_models.pl
# UTR option wont work here.

cd /PATH_TO/R.padi_Braker/
mkdir de_novo_complete_gene_calls
cd /PATH_TO/R.padi_Braker/de_novo_complete_gene_calls

braker_complete_gene_models.pl --hints=../Rp.v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --useexisting --species=R_padi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/R.padi_Braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/R.padi_Braker/de_novo_complete_gene_calls --genome=../Rp.v1_alt.fasta


cd repeat_16_feb

braker_complete_gene_models.pl --hints=../Rp.v1_alt.hints --skipGeneMark-ET --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.2.1/config --species=R_padi_16_feb --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/R.padi_Braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/R.padi_Braker/repeat_16_feb --genome=../Rp.v1_alt.fasta

# --noInFrameStop=true

# try with augustus 3.2.1  - TEST

cd repeat_16_feb

#braker_complete_gene_models.pl -skipGeneMark-ET --hints=../Rp.v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.2.1/config --skipOptimize --useexisting --species=pea_aphid --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 2 --optCfgFile=/PATH_TO/R.padi_Braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/R.padi_Braker/repeat_16_feb --genome=../Rp.v1_alt.fasta


#################################################################################################################################
#for Mc

cd /PATH_TO/Mc_braker

#try with reformatted names uisng python script:


# create a new species train set for M. cerasi

#make sure you are in the correct directtory

braker.pl --hints=../Mc_v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --species=Myzus_cerasi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --UTR on --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker/de_novo_models --genome=../Mc_v1_alt.fasta


 # using pea_aphid models
braker.pl --hints=Mc_v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --species=pea_aphid --useexisting --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --UTR on --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker --genome=Mc_v1_alt.fasta


# now using "complete gene calls only" - using the M. cerasi gene models already generated.  braker_complete_gene_models.pl
# UTR option wont work here.

cd /PATH_TO/Mc_braker/de_novo_complete_only

braker_complete_gene_models.pl --hints=../Mc_v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --useexisting --species=Myzus_cerasi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker/de_novo_complete_only --genome=../Mc_v1_alt.fasta 


# skip genemark, as this has been run as we will use the already generated genemark.gtf
braker_complete_gene_models.pl --hints=../Mc_v1_alt.hints --skipGeneMark-ET --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --useexisting --species=Myzus_cerasi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker/de_novo_complete_only --genome=../Mc_v1_alt.fasta 


# repeat with stricter parameters

braker_complete_gene_models.pl --hints=../Mc_v1_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --species=Myzus_cerasiintron10 --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 2 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker/denovo_strict_param --genome=../Mc_v1_alt.fasta 

# with newer augustus

braker_complete_gene_models.pl --hints=../Mc_v1_alt.hints --skipGeneMark-ET --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.2.1/config --species=Myzus_cerasi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker/repeat_feb_15 --genome=../Mc_v1_alt.fasta 



################################################################################################################################
#test  braker_complete_gene_models.pl   to see if the changed file crashed or not. -genemodel=complete

braker_complete_gene_models.pl --hints=Mc_v1_alt.hints --skipGeneMark-ET --skipOptimize --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --useexisting --species=Myzus_cerasi --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 2 --optCfgFile=/PATH_TO/R.padi_Braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mc_braker --genome=Mc_v1_alt.fasta



#for Mp_O

cd /PATH_TO/Mp_O_braker

mkdir de_novo_complete_only
cd ./de_novo_complete_only

braker_complete_gene_models.pl --hints=Mp_altered_alt.hints --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.1/config --species=Myzus_persicae_geno_O --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 2 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mp_O_braker --genome=Mp_altered_alt.fasta


# after scaffold names altered.

# newer augustus

braker_complete_gene_models.pl --hints=../Mp_alt_alt.hints --skipGeneMark-ET --AUGUSTUS_CONFIG_PATH=/PATH_TO/augustus-3.2.1/config --species=Myzus_persicae --BAMTOOLS_PATH=/PATH_TO/bamtools-master/bin --cores 1 --optCfgFile=/PATH_TO/Mc_braker/extrinsic.bug.cfg --gff3 --GENEMARK_PATH=/PATH_TO/gm_et_linux_64/gmes_petap --workingdir=/PATH_TO/Mp_O_braker/redone_15_feb --genome=../Mp_alt_alt.fasta




