#$ -l hostname="n13*"
#$ -pe smp 8

cd /home/PATH_TO/R.padi_genome/final_genome/final_genes

# diamond blast vs NR
diamond blastp -p 12 --sensitive -e 0.00001 -v -q Rp.v1.AA.fasta -d /home/PATH_TO/blast_databases/nr.dmnd -a Rp.v1.AA.fasta_vs_nr.da

diamond view -a Rp.v1.AA.fasta*.daa -f tab -o Rp.v1.AA.fasta_vs_nr.tab

# annotate tax with tool
python ~/misc_python/diamond_blast_to_kingdom/Diamond_blast_to_taxid_add_kingdom_add_species_description.py -i Rp.v1.AA.fasta_vs_nr.tab -p /home/PATH_TO/blast_databases -o Rp.v1.AA.fasta_vs_nr_tax.tab

# HGT prediction tool 

python /home/PATH_TO/misc_python/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -i *_vs_nr_tax.tab -a 20 --tax_filter_out 6656 --tax_filter_up_to 33208 -p /home/PATH_TO/blast_databases -o LTG_results.out

# transrate to get the bam file and RNAseq coverage:


transrate --assembly Rp.v1.nt.fasta --left /home/PATH_TO/R.padi_genome/RNAseq_data/Rp_R1.fq.gz --right /home/PATH_TO/R.padi_genome/RNAseq_data/Rp_R2.fq.gz --threads 12

# filter HGT results. 
# python ~/misc_python/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py --gff Mcerasi_Mp.models_RNAseq.v4.20160222.gff --LTG LTG_LGT_candifates_AI.out -s 0 -r ?? -g ../Myzus_cerasi_genome_assembly.v1.fasta --dna ../Rp.v1.AA.fasta -o test | grep -v "expression: 0"


################################################################################################################################################################################################
# To get the corresposnding "putative effectors.
# make blastdb
makeblastdb -in Rp.v1.AA.fasta -dbtype prot

#blast to xml
blastp -db Rp.v1.AA.fasta -query /home/PATH_TO/gene_model_testing/Mp_candidates_Bos_lab_march2014.fasta -evalue 0.00001 -seg no -num_threads 12 -outfmt 5 -out Mp.AA.fa_vs_bos2010.xml

#blast 2 tab
mv Bos2010 ./Bos2010_all_hits_2
blastp -db Rp.v1.AA.fasta -query /home/PATH_TO/gene_model_testing/Mp_candidates_Bos_lab_march2014.fasta -evalue 1e-10 -seg no -num_threads 12 -max_target_seqs 1 -outfmt 7 -out Mp.AA.fa_vs_bos2010.tab

# convert the xml
python ./home/PATH_TO/gene_model_testing/BLAST_parser_return_hits_NAME_only.py -i Mp.AA.fa_vs_bos2010.xml -o Mp.AA.fa_vs_bos2010.xml.condensed.out

# get the matches seq for the tab blast to the effectors
python /home/PATH_TO/gene_model_testing/Get_effector_seq_using_SeqIO_dic.py -b Mp.AA.fa_vs_bos2010.tab -p Rp.v1.AA.fasta -n Rp.v1.AA.fasta

cd ./Bos2010


filenames=*.fasta

for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="/home/PATH_TO/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
done

filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="/home/PATH_TO/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
done
	
rm *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments
	

	
echo ................................................................ im done
#
############################################################################################################################################################################

# Annotation for trinotate:
########################################################################################################################################################
#				for trinnotate
#	pfam domains
hmmscan --cpu 12 --domtblout TrinotatePFAM.out /home/PATH_TO/TransDecoder_r20131117/pfam/Pfam-AB.hmm.bin Rp.v1.AA.fasta > pfam_pep.log

mkdir for_trinnotate
#		swissprot
#blastx -query Rp.v1.nt.fasta-db /home/PATH_TO/Trinotate-2.0.2/uniprot_sprot.fasta -num_threads 4 -max_target_seqs 1 -outfmt 6 > blastx_trin.outfmt6

diamond blastx -k 1 -p 12 --sensitive -v -q Rp.v1.nt.fasta -d /home/PATH_TO/Trinotate-2.0.2/swiss_prot.dmnd -a Mc.genes.blastx.unipot.DIAMOND002.diamond
diamond view -a Mc.genes.blastx.unipot.DIAMOND002.*.daa -f tab -o ./for_trinnotate/blastx_trin_uniprot.outfmt6


#blastp -query Rp.v1.AA.fasta -db /home/PATH_TO/Trinotate-2.0.2/uniprot_sprot.fasta -num_threads 4 -max_target_seqs 1 -outfmt 6 > blastp_trin.outfmt6
diamond blastp -k 1 -p 12 --sensitive -v -q Rp.v1.AA.fasta -d /home/PATH_TO/Trinotate-2.0.2/swiss_prot.dmnd -a Mc.genes.blastp.unipot.DIAMOND002.diamond
diamond view -a Mc.genes.blastp.unipot.DIAMOND002.*.daa -f tab -o ./for_trinnotate/blastp_trin_uniprot.outfmt6


#		uniref  (uniref90.dmnd)

#blastx -query Rp.v1.nt.fasta -db /home/PATH_TO/Trinotate-2.0.2/uniprot_uniref90.trinotate.pep -num_threads 4 -max_target_seqs 1 -outfmt 6 > uniref90.blastx.outfmt6
diamond blastx -k 1 -p 4 --sensitive -v -q Rp.v1.nt.fasta -d /home/PATH_TO/Trinotate-2.0.2/uniref.dmnd -a Mc.genes.blastx.uniref90.dmnd.DIAMOND003.diamond
diamond view -a Mc.genes.blastx.uniref90.dmnd.DIAMOND003.*.daa -f tab -o ./for_trinnotate/uniref90.blastx.outfmt6


#blastp -query Rp.v1.AA.fasta -db /home/PATH_TO/Trinotate-2.0.2/uniprot_uniref90.trinotate.pep -num_threads 4 -max_target_seqs 1 -outfmt 6 > uniref90.blastp.outfmt6
diamond blastp -k 1 -p 4 --sensitive -v -q Rp.v1.AA.fasta -d /home/PATH_TO/Trinotate-2.0.2/uniref.dmnd -a Mc.genes.blastp.uniref90.dmnd.DIAMOND003.diamond
diamond view -a Mc.genes.blastp.uniref90.dmnd.DIAMOND003.*.daa -f tab -o ./for_trinnotate/uniref90.blastp.outfmt6

# 		generate the trans to genes map
#/home/PATH_TO/trinityrnaseq_r20140717/util/support_scripts/get_Trinity_gene_to_trans_map.pl home/PATH_TO/Mcerasi_wild_samples/RNAseq_final_GG_v1/Mcerasi_GG_assembly/Rp.v1.nt.fasta > ./for_trinnotate/Trinity.fasta.gene_trans_map



#
#		Running signalP to predict signal peptides
signalp -f short -n ./for_trinnotate/signalp.out Rp.v1.AA.fasta 
#wait

#		Running tmHMM to predict transmembrane regions
tmhmm --short < Rp.v1.AA.fasta > ./for_trinnotate/tmhmm.out
#wait
#		Running RNAMMER to identify rRNA transcripts

# BUSCO 
mkdir LINEAGE
ln -s ~/BUSCO_v1.1b1/arthropoda ./LINEAGE/
python3 /home/PATH_TO/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in Rp.v1.nt.fasta -l ./LINEAGE/arthropoda -o Rp.v1.nt.fasta.busco -m transcriptome -f -Z 427000000 --long --cpu 12 --species pea_aphid


###########################################################################################################################################################################


PATH_TO/Trinotate_r20131110/util/rnammer_support/RnammerTranscriptome.pl --transcriptome Rpadi_RNAseq_ass.fa --path_to_rnammer PATH_TO/rnammer


######################################################################################################################################################################################

#		TRINNOTATE

wget "ftp://ftp.broadinstitute.org/pub/Trinity/Trinotate_v2.0_RESOURCES/Trinotate.sprot_uniref90.20150131.boilerplate.sqlite.gz" -O Trinotate.sqlite.gz

gunzip Trinotate.sqlite.gz

# load protein hits
Trinotate Trinotate.sqlite LOAD_swissprot_blastp blastp_trin.outfmt6

# load transcript hits
Trinotate Trinotate.sqlite LOAD_swissprot_blastx blastx_trin.outfmt6

#Optional: load Uniref90 blast hits (requires the more comprehensive boilerplate database, as described above):

# load protein hits
Trinotate Trinotate.sqlite LOAD_trembl_blastp uniref90.blastp.outfmt6

# load transcript hits
Trinotate Trinotate.sqlite LOAD_trembl_blastx uniref90.blastx.outfmt6


Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out

Trinotate Trinotate.sqlite LOAD_tmhmm tmhmm.out

Trinotate Trinotate.sqlite LOAD_signalp signalp.out

Trinotate Trinotate.sqlite report -E 1-10 > Mc.genes_trinotate_annotation_report.xls


#########################################################################################################
##### shell script to annotate  using pfamAB domains swiss prot and uniref90	######################################
######################################################################################################

#wait

