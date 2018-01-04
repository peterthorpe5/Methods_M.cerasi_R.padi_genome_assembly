#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd '$HOME/virtual_env'
cd matplotlib
source bin/activate
which python
 
cd pathto/R.padi_genome/discovar_v4

cat /home/pt40963/uni_ref/uniref100.taxlist <(diamond view -a *.daa) | perl -ne 'chomp; if (/^UniRef100_(.*?)\t(\d+)$/) {$uniref2taxid {$1} = $2; next;} if (/^\S+\tUniRef90_(\S+)/) {@F = split /\t/; if (exists $uniref2taxid {$1}) { print join("\t", $F[0],$uniref2taxid {$1}, $F[11]) ."\n";}} ' >prelim.diamond.uniref90.domblast

mkdir blobplots

cd ./blobplots

$HOME/blobtools-light-master/makeblobs.py -a ../a.lines.fasta -cov ../contig.mapping250.cas.cov  -taxdb $HOME/ -blast ../prelim.diamond.uniref90.domblast ../n.Rp_disc_v3_vs_nr_tax.tab_for_blobplots.txt ../n.Rp.disco_v3_q15_20150908.favs_Pea_aphid.fa.out  ../n.Rp.disco_v3_q15_20150908.favs_Mp.scaffolds.out ../n.Rp.disco_v3_q15_20150908.favs_Mc.v8.20150722.fa.out -o n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out

$HOME/blobtools-light-master/plotblobs.py n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out.blobplot.txt

#history > making_blobplots.txt
$HOME/blobtools-light-master/plotblobs.py -m n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out.blobplot.txt

perl -ne '@temp = split("\t"); @tax = split(",", $temp[4]); if (scalar @tax >= 2){print}' n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out.blobplot.txt > contigs_competing_tax_id.out

cd ..
mkdir blobs_tx_rule_B
 
cd ./blobs_tx_rule_B

$HOME/blobtools-light-master/makeblobs.py -taxrule B -a ../a.lines.fasta -cov ../contig.mapping250.cas.cov  -taxdb $HOME/ -blast ../prelim.diamond.uniref90.domblast ../n.Rp_disc_v3_vs_nr_tax.tab_for_blobplots.txt ../n.Rp.disco_v3_q15_20150908.favs_Pea_aphid.fa.out  ../n.Rp.disco_v3_q15_20150908.favs_Mp.scaffolds.out ../n.Rp.disco_v3_q15_20150908.favs_Mc.v8.20150722.fa.out -o n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out

$HOME/blobtools-light-master/plotblobs.py n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out.blobplot.txt

#history > making_blobplots.txt
$HOME/blobtools-light-master/plotblobs.py -m n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1.out.blobplot.txt

#history > making_blobplots.txt
$HOME/blobtools-light-master/plotblobs.py -m n.Rp.disco_v3_q15_20150908.fa.vs.nt.1e25.20seqs.cul1_taxruleB.out.blobplot.txt

###################################################################################################
# To identify the contig we removed:

# Any contig assigned as Arthopoda or no-hit were KEPT - we wasnt to keep these. Others are identified to be removed.
perl -ne 'chomp; @line = split("\t"); @cov=split(";", $line[3]); print $line[0]."\t".$line[1]."\t".$line[2]."\t".join("\t",@cov)."\t".$line[4]."\n";' n.*.blobplot.txt | sed 's/SUM=//g' | awk '$4 < 40' | grep -v "Arthropoda" |grep -v "no-hit" | wc -l 

# we also removed contigs with less than 10 coverage, as these may be sequencing errors. 
perl -ne 'chomp; @line = split("\t"); @cov=split(";", $line[3]); print $line[0]."\t".$line[1]."\t".$line[2]."\t".join("\t",@cov)."\t".$line[4]."\n";' n.*.blobplot.txt | sed 's/COV_1=//g' | awk '$4 < 40' | grep -v "Arthropoda" 

|grep -v "no-hit" | wc -l 



