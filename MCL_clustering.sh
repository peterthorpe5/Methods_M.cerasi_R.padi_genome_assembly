#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd path/to
# NOTE: name the .abc file all_vs_all.abc, or chnage it in this shell script

# All versus all clustering: evalues from 10 to -60 should be run. The results graphed (get data using: Count_number_size_clusters.py)
# and the point at which the clustering network brakes,
# should be the point at which the results are taken from. In our case 1e-31. remeber evalue results change depeding on
# database size

diamond makedb --in all.fa -d d
diamond blastp -p 16 --sensitive -e 1e-1 -v -q all.fa -d d.dmnd -a out
 
 wait 
 
 diamond view -a out*.daa -f tab -o all_vs_all.tab
 
 cut -f1,2,11 all_vs_all.tab > all_vs_all.abc

python Remove_low_quality_blast_matches.py all_vs_all.abc all_results_eval_1e-31.abc 1e-31

mcxload -abc all_results_eval_1e-31.abc --stream-mirror --stream-neg-log10 -stream-tf 'ceil(200)' -o all_results_eval_1e-31.mci -write-tab all_results_eval_1e-31.abc.tab
wait

mcl all_results_eval_1e-31.mci -I 6 -use-tab all_results_eval_1e-31.abc.tab -o all_results_eval_1e-31.abc_seq.mci

wait

mcl all_results_eval_1e-31.mci --d -write-graphx all_results_eval_1e-31.mci_Outputgraph.txt -I 6

wait 

mcxdump -icl out.all_results_eval_1e-31.mci.I60 -tabr all_results_eval_1e-31.abc.tab -o all_results_eval_1e-31.mci.I60

######################################################################################################################
# This was run to collect the sequences for each cluster and align them.

cd $HOME/scratch/clustering/all_vs_all

# python script to parse the MCL cluster line and put in into thousands of files
python Count_size_MCL_clusters001_get_MYZUS_cluster_seq_Muscle_cluster_descriptions_seqIO_index006_gene_models.py
	
echo done step 1
# get the cluster summary
cd ./All_clusters
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../
##rm *.txt
##rm *.fasta
filenames=*.fasta


for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	
filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
done
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	

cd ..

echo removed files in all clusters

###############################################################################################################################################
cd ./Bos2010
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

 
 
mv *Cluster_catorgory_summary.out ../
##rm *.txt
##rm *.fasta

filenames=*.fasta


for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	

filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments

mkdir back_translated
python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done

cd ..
###############################################################################################################################################

cd ./Conserved
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../
#rm *.txt
#rm *.fasta

#filenames=*.fasta
#
#
#for f in ${filenames}
#do
#	echo "Running muscle ${f}"
#	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
#	echo ${cmd}
#	eval ${cmd}
#	wait
#	done
#	
#
#filenames2=*_aligned.fasta
#for file in ${filenames2}
#do
#	echo "Running muscle ${f}"
#	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
#	echo ${cmd}
#	eval ${cmd}
#	wait
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done

cd ..

###############################################################################################################################################
cd ./expression
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

filenames=*.fasta


##rm *.txt
##rm *.fasta
cd ..

######################################
cd ./Mass_spec
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

filenames=*.fasta


for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	



filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
	
#rm -rf *_aligned.fasta

mkdir alignments

mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done

##rm *.txt
##rm *.fasta
cd ..

######################################
cd ./Mcerasi_only
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

filenames=*.fasta


	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done


##rm *.txt
##rm *.fasta
cd ..

######################################
cd ./Mp_only
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../
##rm *.txt
##rm *.fasta
cd ..
######################################
cd ./Myzus_only
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	



filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done


##rm *.txt
##rm *.fasta
cd ..
######################################
cd ./Pea_only
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../
##rm *.txt
##rm *.fasta
cd ..
######################################
cd ./pea_saliva
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

filenames=*.fasta


for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	


filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta	
done

##rm *.txt
##rm *.fasta
cd ..

###############################################################################################################################################
cd ./RNAseq_clusters
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py

mv *Cluster_catorgory_summary.out ../

filenames=*.fasta


for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${f} -out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
	done
	

filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/Downloads/muscle3.8.31_i86linux64 -in ${file} -out ${file}_refine.fasta -refine" 
	echo ${cmd}
	eval ${cmd}
	wait
	
#rm -rf *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

cd ./alignments
mkdir back_translated

python $HOME/scratch/clustering/Align_back_translate_Aug2014.py
wait
cd ..
#rm *.txt
#rm *.fasta
done

##rm *.txt
##rm *.txt
##rm *.fasta
cd ..

cd ./Rpadi_only
cp ~/misc_python/MCL_clusters_get_seq/get_CLUSTER_ANNOT_INFO_IN_Folder.py ./
 python get_CLUSTER_ANNOT_INFO_IN_Folder.py



###################################################################################################################################

RBBH clustering:

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp A.pisum.AA.fasta M.cerasi.V1.AA.fasta -o A.pisum.AA_M.cerasi.V1.AA.tab

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp A.pisum.AA.fasta Rp.v1.AA.fasta -o A.pisum.AA_Rp.v1.AA.tab

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp A.pisum.AA.fasta Dnox.v1.AA.fasta -o A.pisum.AA_Dnox.v1.AA.tab

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp A.pisum.AA.fasta Mp_O_v1.AA.fasta -o A.pisum.AA_Mp_O_v1.AA.tab

#mc

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp M.cerasi.V1.AA.fasta Rp.v1.AA.fasta -o M.cerasi.V1.AA_Rp.v1.AA.tab

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp M.cerasi.V1.AA.fasta Dnox.v1.AA.fasta -o M.cerasi.V1.AA_Dnox.v1.AA.tab

python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp M.cerasi.V1.AA.fasta Mp_O_v1.AA.fasta -o M.cerasi.V1.AA_Mp_O_v1.AA.tab

#RP



python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp Rp.v1.AA.fasta Dnox.v1.AA.fasta -o Rp.v1.AA_Dnox.v1.AA.tab


python ~/misc_python/BLAST_output_parsing/Blast_RBH_two_fasta_file_evalue.py -a prot --threads 8 -t blastp Rp.v1.AA.fasta Mp_O_v1.AA.fasta -o Rp.v1.AA_Mp_O_v1.AA.tab
