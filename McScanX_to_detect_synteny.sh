# How to McScanX - program to draw synteny...
http://chibba.pgml.uga.edu/mcscan2/documentation/manual.pdf
download, unzip type make.
cannot run with GCC version 4.9, so have to revert to older verison. 

0) # get the gene on the scaffold of interest .. python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py ../whole_genomes/fastafile/Mp_O_v1.AA.fasta mp_gene_to_get mp_Mp1087439_TGAC_V1.1_scaffold_172_genes.fasta
#put the AA gene models fasta file in a folder.

#cat them together.

cat ./fastafile/M.cerasi.V1.AA.fasta ./fastafile/Mp_O_v1.AA.fasta > Mc_Mp.fasta

1)
#run:
$ formatdb -i Mc_Mp_annot.AA.fasta

# amino acids!
formatdb -i gene_of_interest.fasta

#run blast all:
-a (num of processors)
$ blastall -i Mc_Mp_annot.AA.fasta -d Mc_Mp_annot.AA.fasta -p blastp -e 1e5 -b 5 -v 5 -m 8 -a 12 -o xyz.blast

blastall -i gene_of_interest.fasta -d gene_of_interest.fasta -p blastp -e 1e5 -b 5 -v 5 -m 8 -a 12 -o mp1_mpsec5_scff.blast

1b)

#going to run with diamond instead.

cat ./fastafile/M.cerasi.V1.AA.fasta  ./fastafile/Mp_O_v1.AA.fasta > Mc_Mp.fasta
diamond makedb --in Mc_Mp.fasta -d Mc_Mp
 
diamond makedb --in ./fastafile/M.cerasi.V1.AA.fasta -d Mc
 
diamond makedb --in ./fastafile/Mp_O_v1.AA.fasta -d Mp

 # sensitive blastx vs nr 
 # --max-target-seqs 5 if required
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mc_Mp.fasta -d Mc_Mp.dmnd -a p.Mc_Mp_vs_mc_mp.da

diamond view -a p.Mc_Mp_vs_mc_mp.da*.daa -f tab -o p.Mc_Mp_vs_mc_mp.tab

cp p.Mc_Mp_vs_mc_mp.tab Mc_Mp.blast

# individual species Mc
diamond blastp -p 16 --sensitive -e 1e-10 --max-target-seqs 5 -v -q ./fastafile/M.cerasi.V1.AA.fasta -d Mc.dmnd -a p.Mc_vs_mc.da

diamond view -a p.Mc_vs_mc.da*.daa -f tab -o p.Mc_vs_mc.tab

cp p.Mc_vs_mc.tab Mc_Mc.blast

# individual species Mp
diamond blastp -p 16 --sensitive -e 1e-10 --max-target-seqs 5 -v -q ./fastafile/Mp_O_v1.AA.fasta -d Mp.dmnd -a p.Mp_vs_mp.da

diamond view -a p.Mp_vs_mp.da*.daa -f tab -o p.Mp_vs_mp_.tab

cp p.Mp_vs_mp.tab Mp_Mp.blast

 3)
 
 #reformet the GFF files:
 
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Mp_O_v1.gff -s Mp -o Mp.gff

python ~/misc_python/re_format_GFF_Mcscanx.py --gff Mc.alt.final.gff -s Mc -o Mc.gff


cat Mp.gff Mc.gff > Mc_Mp.gff

4) 

#check for synteny - note the outfiles are called xyz for this .... 
#MCScanX dir/xyz

#-s number of gene required to call synteny
 #-m  MAX_GAPS, maximum gaps allowed (default: 25)
MCScanX -s 3 -m 30 /home/PATH_TO/scratch/diagram_drawing_test/whole_genomes/Mc_Mp

#MCScanX -s 3 -m 30 /home/PATH_TO/scratch/diagram_drawing_test/mp1_mpsec5/mp1_mpsec5_scff

5)

#It is not reasonable to apply this program to data of multiple genomes
# must be run on a single genomes
duplicate_gene_classifier /home/PATH_TO/scratch/diagram_drawing_test/whole_genomes/Mp

duplicate_gene_classifier /home/PATH_TO/scratch/diagram_drawing_test/whole_genomes/Mc


6)

#detect_syntenic_tandem_arrays -g gff_file -b blast_file -s synteny_file -o output_file

detect_syntenic_tandem_arrays -g Mc_Mp.gff -b Mc_Mp.blast -s Mc_Mp.synteny -o Mc_Mp.syntenic_tandem_arrays.out

7)
#dissect_multiple_alignment -g gff_file -s synteny_file -o output_file

dissect_multiple_alignment -g Mc_Mp.gff -s Mc_Mp.synteny  -o Mc_Mp.dissect_multiple.out


8)
#dot plotter

#java dot_plotter -g gff_file -s synteny_file -c control_file -o output_PNG_file


java /home/PATH_TO/scratch/Downloads/MCScanx-master/downstream_analyses/dot_plotter -g Mc_Mp.gff -s Mc_Mp.synteny -c control_file -o Mc10_100_output_PNG_file



