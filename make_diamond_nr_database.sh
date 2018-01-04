#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

# script to convert NR database to fasta files and make a diamond blastdatabse.


# to install diamond from source
#cd /home/PATH_TO/Downloads/

#wget http://github.com/bbuchfink/diamond/archive/v0.7.9.tar.gz

#tar xzf v0.7.9.tar.gz

#cd diamond-0.7.9/src
# # optional, for installing Boost

##./install-boost 

#make
# 
 
#put the /bin in your PATH

# cd /home/PATH_TO/scratch/blast_databases

#FOR TEST:
cd /home/PATH_TO/scratch/diamond_tax_id_test

export BLASTDB=/mnt/scratch/local/blast/ncbi/

# can only use protein databases with this program.
#blastdbcmd -entry 'all' -db nr > nr.faa

echo im making the nr fasta file

#~/scratch/Downloads/diamond-0.7.9/bin/diamond makedb --in nr.faa -d nr

echo nr fasta done
#diamond makedb --in /mnt/shared/cluster/blast/ncbi/extracted/uniprot_sprot.faa -d uniprot

#diamond makedb --in /mnt/shared/cluster/blast/ncbi/extracteduniref90.faa -d uniref90


#files required for pyhon script to get tax id and species name ..

echo im downloading files from NCBI


##remove older version
#rm -rf taxdump.tar.gz*
#rm -rf gi_taxid_prot.dmp.gz*
#rm -rf *.dmp
#rm -rf *.zip
#
#
#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/gi_taxid_prot.dmp.gz
#gunzip gi_taxid_prot.dmp.gz
#
#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxcat.zip
#unzip taxcat.zip
#
#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
#tar -zxvf taxdump.tar.gz

#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz.md5
#wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz
#md5sum -c prot.accession2taxid.gz.md5
#gunzip prot.accession2taxid.gz


#
#echo downloading and unzipping done
#
#python ~/misc_python/diamond_blast_to_kingdom/prepare_gi_to_description_databse.py
#
#echo single discription to gi number database done
#
#rm -rf nr.faa
#rm -rf *.zip
#rm -rf taxdump.tar.gz*
#
# run diamond

test_fa="test.fa"

diamond_mk_db="diamond makedb --in ${test_fa} -d tests"
echo ${diamond_mk_db}
eval ${diamond_mk_db}
wait

blastp="diamond blastp -p 4 --sensitive -e 0.00001 -v 
		-q query.fa -d tests.dmnd 
		-a test_out.da"
echo ${blastp}
eval ${blastp}
wait

# convert to tab file
view="diamond view -a test_out.da.daa -f tab -o tests.tab"
echo ${view}
eval ${view}
wait

# generate a accession to description database
echo "2) testing making the accession to annotation databse"
DB_command="python $HOME/public_scripts/Diamond_BLAST_add_taxonomic_info/prepare_accession_to_description_db.py 
-i ${test_fa} -o test_acc_annot.tab"
echo ${DB_command}
eval ${DB_command}
wait

# annot the output
echo "3) annotating the ouput"
annot_command="python $HOME/public_scripts/Diamond_BLAST_add_taxonomic_info/Diamond_blast_to_taxid.py 
-i tests.tab -d test_acc_annot.tab -o tests_tax.tab"
echo ${annot_command}
eval ${annot_command}
wait

# annot the output
echo "3) annotating the ouput with old and new hits in testfile"
annot_command="python $HOME/public_scripts/Diamond_BLAST_add_taxonomic_info/Diamond_blast_to_taxid.py 
-i tests_old_and_new.tab -d test_acc_annot.tab -o tests_old_and_new_tax.tab"
echo ${annot_command}
eval ${annot_command}
wait





