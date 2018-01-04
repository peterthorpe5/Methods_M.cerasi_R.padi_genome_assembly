# How to McScanX - program to draw synteny...
http://chibba.pgml.uga.edu/mcscan2/documentation/manual.pdf
download, unzip type make.
cannot run with GCC version 4.9, so have to revert to older verison. 

cd /home/PATH_TO/scratch/synteny_working

0) # get the gene on the scaffold of interest .. python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py ../whole_genomes/fastafile/Mp_O_v1.AA.fasta mp_gene_to_get mp_Mp1087439_TGAC_V1.1_scaffold_172_genes.fasta
#put the AA gene models fasta file in a folder.

#cat them together.

cat *fasta ./fastafile/Mp_O_v1.AA.fasta > all.faa

1)


#going to run with diamond instead.


diamond makedb --in all.faa -d all.dmd

diamond blastp -p 16 --sensitive -e 1e-5 -v -q all.faa -d all.dmd.dmnd -a p.all_vs_all.da

diamond view -a p.all_vs_all.da*.daa -f tab -o p.all_vs_all.blast

 

diamond makedb --in A.pisum.AA.fasta -d  A.pisum.AA.dmd 
diamond makedb --in Dnox.v1.AA.fasta -d  Dnox.v1.AA.dmd
diamond makedb --in M.cerasi.V1.AA.fasta -d  M.cerasi.V1.AA.dmd
diamond makedb --in Mp_O_v1.AA.fasta -d  Mp_O_v1.AA.dmd
diamond makedb --in Rp.v1.AA.fasta -d  Rp.v1.AA.dmd

#blast searches betwen and within all speices. 

 # sensitive blastx vs nr 
 # --max-target-seqs 5 if required
diamond blastp -p 16 --sensitive -e 1e-5 -v -q M.cerasi.V1.AA.fasta -d Dnox.v1.AA.dmd.dmnd -a p.M.cera_Dnox.v.da

diamond view -a p.M.cera_Dnox.v.da*.daa -f tab -o p.M.ce_Dnox.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Dnox.v1.AA.fasta -d Rp.v1.AA.dmd.dmnd -a p.Dnox.v_Rp.v1..da

diamond view -a p.Dnox.v_Rp.v1..da*.daa -f tab -o p.Dnox_Rp.v.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mp_O_v1.AA.fasta -d M.cerasi.V1.AA.dmd.dmnd -a p.Mp_O_v_M.cera.da

diamond view -a p.Mp_O_v_M.cera.da*.daa -f tab -o p.Mp_O_M.ce.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mp_O_v1.AA.fasta -d A.pisum.AA.dmd.dmnd -a p.Mp_O_v_A.pisu.da

diamond view -a p.Mp_O_v_A.pisu.da*.daa -f tab -o p.Mp_O_A.pi.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Rp.v1.AA.fasta -d A.pisum.AA.dmd.dmnd -a p.Rp.v1._A.pisu.da

diamond view -a p.Rp.v1._A.pisu.da*.daa -f tab -o p.Rp.v_A.pi.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Rp.v1.AA.fasta -d Mp_O_v1.AA.dmd.dmnd -a p.Rp.v1._Mp_O_v.da

diamond view -a p.Rp.v1._Mp_O_v.da*.daa -f tab -o p.Rp.v_Mp_O.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Rp.v1.AA.fasta -d M.cerasi.V1.AA.dmd.dmnd -a p.Rp.v1._M.cera.da

diamond view -a p.Rp.v1._M.cera.da*.daa -f tab -o p.Rp.v_M.ce.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mp_O_v1.AA.fasta -d Mp_O_v1.AA.dmd.dmnd -a p.Mp_O_v_Mp_O_v.da

diamond view -a p.Mp_O_v_Mp_O_v.da*.daa -f tab -o p.Mp_O_Mp_O.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Dnox.v1.AA.fasta -d Mp_O_v1.AA.dmd.dmnd -a p.Dnox.v_Mp_O_v.da

diamond view -a p.Dnox.v_Mp_O_v.da*.daa -f tab -o p.Dnox_Mp_O.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Rp.v1.AA.fasta -d Rp.v1.AA.dmd.dmnd -a p.Rp.v1._Rp.v1..da

diamond view -a p.Rp.v1._Rp.v1..da*.daa -f tab -o p.Rp.v_Rp.v.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q A.pisum.AA.fasta -d Mp_O_v1.AA.dmd.dmnd -a p.A.pisu_Mp_O_v.da

diamond view -a p.A.pisu_Mp_O_v.da*.daa -f tab -o p.A.pi_Mp_O.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q M.cerasi.V1.AA.fasta -d A.pisum.AA.dmd.dmnd -a p.M.cera_A.pisu.da

diamond view -a p.M.cera_A.pisu.da*.daa -f tab -o p.M.ce_A.pi.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q A.pisum.AA.fasta -d A.pisum.AA.dmd.dmnd -a p.A.pisu_A.pisu.da

diamond view -a p.A.pisu_A.pisu.da*.daa -f tab -o p.A.pi_A.pi.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mp_O_v1.AA.fasta -d Dnox.v1.AA.dmd.dmnd -a p.Mp_O_v_Dnox.v.da

diamond view -a p.Mp_O_v_Dnox.v.da*.daa -f tab -o p.Mp_O_Dnox.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q M.cerasi.V1.AA.fasta -d Mp_O_v1.AA.dmd.dmnd -a p.M.cera_Mp_O_v.da

diamond view -a p.M.cera_Mp_O_v.da*.daa -f tab -o p.M.ce_Mp_O.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Rp.v1.AA.fasta -d Dnox.v1.AA.dmd.dmnd -a p.Rp.v1._Dnox.v.da

diamond view -a p.Rp.v1._Dnox.v.da*.daa -f tab -o p.Rp.v_Dnox.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mp_O_v1.AA.fasta -d Rp.v1.AA.dmd.dmnd -a p.Mp_O_v_Rp.v1..da

diamond view -a p.Mp_O_v_Rp.v1..da*.daa -f tab -o p.Mp_O_Rp.v.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Dnox.v1.AA.fasta -d M.cerasi.V1.AA.dmd.dmnd -a p.Dnox.v_M.cera.da

diamond view -a p.Dnox.v_M.cera.da*.daa -f tab -o p.Dnox_M.ce.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q A.pisum.AA.fasta -d Rp.v1.AA.dmd.dmnd -a p.A.pisu_Rp.v1..da

diamond view -a p.A.pisu_Rp.v1..da*.daa -f tab -o p.A.pi_Rp.v.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q A.pisum.AA.fasta -d Dnox.v1.AA.dmd.dmnd -a p.A.pisu_Dnox.v.da

diamond view -a p.A.pisu_Dnox.v.da*.daa -f tab -o p.A.pi_Dnox.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q A.pisum.AA.fasta -d M.cerasi.V1.AA.dmd.dmnd -a p.A.pisu_M.cera.da

diamond view -a p.A.pisu_M.cera.da*.daa -f tab -o p.A.pi_M.ce.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q M.cerasi.V1.AA.fasta -d Rp.v1.AA.dmd.dmnd -a p.M.cera_Rp.v1..da

diamond view -a p.M.cera_Rp.v1..da*.daa -f tab -o p.M.ce_Rp.v.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q M.cerasi.V1.AA.fasta -d M.cerasi.V1.AA.dmd.dmnd -a p.M.cera_M.cera.da

diamond view -a p.M.cera_M.cera.da*.daa -f tab -o p.M.ce_M.ce.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Dnox.v1.AA.fasta -d A.pisum.AA.dmd.dmnd -a p.Dnox.v_A.pisu.da

diamond view -a p.Dnox.v_A.pisu.da*.daa -f tab -o p.Dnox_A.pi.blast
diamond blastp -p 16 --sensitive -e 1e-5 -v -q Dnox.v1.AA.fasta -d Dnox.v1.AA.dmd.dmnd -a p.Dnox.v_Dnox.v.da

diamond view -a p.Dnox.v_Dnox.v.da*.daa -f tab -o Dnox.blast

#mk folders:

mkdir A_A
mkdir A_Dnox
mkdir A_M
mkdir A_Mp_O_v1
mkdir A_Rp
mkdir Dnox_A
mkdir Dnox_Dnox
mkdir Dnox_M
mkdir Dnox_Mp_O_v1
mkdir Dnox_Rp
mkdir M_A
mkdir M_Dnox
mkdir M_M
mkdir M_Mp_O_v1
mkdir M_Rp
mkdir Mp_O_v1_A
mkdir Mp_O_v1_Dnox
mkdir Mp_O_v1_M
mkdir Mp_O_v1_Mp_O_v1
mkdir Mp_O_v1_Rp
mkdir Rp_A
mkdir Rp_Dnox
mkdir Rp_M
mkdir Rp_Mp_O_v1
mkdir Rp_Rp


cp p.Mc_Mp_vs_mc_mp.tab Mc_Mp.blast

cp p.Mc_vs_mc.tab Mc_Mc.blast

 3)
 
 #reformet the GFF files:
 
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Dnox.v1_alt.gff -s Dn -o Dnox.gff
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Mc.alt.final.gff -s Mc -o Mc.gff
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Mp_O_v1.gff -s Mp -o Mp.gff
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Pea_aphid.gff -s Ap -o Ap.gff
python ~/misc_python/re_format_GFF_Mcscanx.py --gff Rpa.v1.gff -s Rp -o Rp.gff

cat  cat *.gff > all.gff

cat Ap.gff Dnox.gff > Ap_Dnox.gff
cat Ap.gff Mc.gff > Ap_Mc.gff
cat Ap.gff Mp.gff > Ap_Mp.gff
cat Ap.gff Rp.gff > Ap_Rp.gff
cat Dnox.gff Ap.gff > Dnox_Ap.gff
cat Dnox.gff Mc.gff > Dnox_Mc.gff
cat Dnox.gff Mp.gff > Dnox_Mp.gff
cat Dnox.gff Rp.gff > Dnox_Rp.gff
cat Mc.gff Ap.gff > Mc_Ap.gff
cat Mc.gff Dnox.gff > Mc_Dnox.gff
cat Mc.gff Mp.gff > Mc_Mp.gff
cat Mc.gff Rp.gff > Mc_Rp.gff
cat Mp.gff Ap.gff > Mp_Ap.gff
cat Mp.gff Dnox.gff > Mp_Dnox.gff
cat Mp.gff Mc.gff > Mp_Mc.gff
cat Mp.gff Rp.gff > Mp_Rp.gff
cat Rp.gff Ap.gff > Rp_Ap.gff
cat Rp.gff Dnox.gff > Rp_Dnox.gff
cat Rp.gff Mc.gff > Rp_Mc.gff
cat Rp.gff Mp.gff > Rp_Mp.gff

4) move all the file to relevant folders.

#check for synteny - note the outfiles are called xyz for this .... 
#MCScanX dir/xyz   - need to name the outfiles tha same 

#-s number of gene required to call synteny
 #-m  MAX_GAPS, maximum gaps allowed (default: 25)

$ synteny
for the pea aphid:

MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/A_Dnox/A_Dnox

MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/A_Mc/Ap_Mc

MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/A_Mp_O_v1/Ap_Mp

MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/A_Rp/Ap_Rp

for Dnox
cd /home/PATH_TO/scratch/synteny_working/Dnox_M
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Dnox_M/Dnox_Mc
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1/Dnox_Mp
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Rp
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Dnox_Rp/Dnox_Rp
rm -rf *.html



for Mc

cd /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1/Mc_Mp
#rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Mc_Rp
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Mc_Rp/Mc_Rp
#rm -rf *.html


for mp
cd /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp
MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp/Mp_Rp
#rm -rf *.html

for all_vs_all

MCScanX -s 4 /home/PATH_TO/scratch/synteny_working/all_all/all
 
 
#MCScanX -s 3 -m 30 /home/PATH_TO/scratch/diagram_drawing_test/mp1_mpsec5/mp1_mpsec5_scff

5) $ GENE DUPLICATION

Gene
gene_type(0/1/2/3/4)
Note: 0, 1, 2, 3, 4  (0)stand for singleton, (1)dispersed, (2)proximal (near but separated by..), (3)tandem, (4)WGD/segmental, respectively

dispersed: Dispersed duplicates are neither adjacent to each other in the genome nor within homeologous chromosome segments
segmental: Segmental duplications give rise to low copy repeats (LCRs) and are believed to have played a role in creating new primate genes as reflected in human genetic variation. 

#It is not reasonable to apply this program to data of multiple genomes
# must be run on a single genomes
	#pea
duplicate_gene_classifier /home/PATH_TO/scratch/synteny_working/A_A/A_A > Ap.duplication.info
	#whate
duplicate_gene_classifier /home/PATH_TO/scratch/synteny_working/Dnox_Dnox/Dnox > Dnox.duplication.into
	#Mc
duplicate_gene_classifier /home/PATH_TO/scratch/synteny_working/Mc_Mc/Mc > Mc.duplication.info
	#Mp
duplicate_gene_classifier /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Mp_O_v1/Mp > Mp.duplication.info
	#Rp
duplicate_gene_classifier /home/PATH_TO/scratch/synteny_working/Rp_Rp/Rp > Rp.duplication.info

6) $ detect_syntenic_tandem_arrays - have to do a new blast with all the seq in

#detect_syntenic_tandem_arrays -g gff_file -b blast_file -s synteny_file -o output_file

cd /home/PATH_TO/scratch/synteny_working/A_Mc
cat ../fasta/A.pisum.AA.fasta ../fasta/M.cerasi.V1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o A_Mc.tab
detect_syntenic_tandem_arrays -g Ap_Mc.gff -b A_Mc.tab -s Ap_Mc.synteny -o Ap_Mc.syntenic_tandem_arrays.out
rm *temp*

cd /home/PATH_TO/scratch/synteny_working/A_Mp_O_v1/
cat ../fasta/A.pisum.AA.fasta ../fasta/Mp_O_v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o A_Mp.tab
detect_syntenic_tandem_arrays -g Ap_Mp.gff -b A_Mp.tab -s Ap_Mp.synteny -o Ap_Mp.syntenic_tandem_arrays.out
rm *temp*

cd /home/PATH_TO/scratch/synteny_working/A_Rp/
cat ../fasta/A.pisum.AA.fasta ../fasta/Rp.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o A_Rp.tab
detect_syntenic_tandem_arrays -g Ap_Rp.gff -b A_Rp.tab -s Ap_Rp.synteny -o Ap_Rp.syntenic_tandem_arrays.out
rm *temp*

######

cd /home/PATH_TO/scratch/synteny_working/A_Dnox/
cat ../fasta/A.pisum.AA.fasta ../fasta/Dnox.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o A_Dnox.tab
detect_syntenic_tandem_arrays -g A_Dnox.gff -b A_Dnox.tab -s A_Dnox.synteny -o A_Dnox.syntenic_tandem_arrays.out
rm *temp*

mc_vs_mp
detect_syntenic_tandem_arrays -g Mc_Mp.gff -b Mc_Mp.blast -s Mc_Mp.synteny -o Mc_Mp.syntenic_tandem_arrays.out
###############################################

for Dnox
cd /home/PATH_TO/scratch/synteny_working/Dnox_M
cat ../fasta/M.cerasi.V1.AA.fasta ../fasta/Dnox.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Dnox_Mc.tab
detect_syntenic_tandem_arrays -g Dnox_Mc.gff -b Dnox_Mc.tab -s Dnox_Mc.synteny -o Dnox_Mc.syntenic_tandem_arrays.out
rm *temp*



cd /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1
cat ../fasta/Mp_O_v1.AA.fasta ../fasta/Dnox.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Dnox_Mp.tab
detect_syntenic_tandem_arrays -g Dnox_Mp.gff -b Dnox_Mp.tab -s Dnox_Mp.synteny -o Dnox_Mp.syntenic_tandem_arrays.out
rm *temp*

cd /home/PATH_TO/scratch/synteny_working/Dnox_Rp
cat ../fasta/Mp_O_v1.AA.fasta ../fasta/Rp.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Dnox_Rp.tab
detect_syntenic_tandem_arrays -g Dnox_Rp.gff -b Dnox_Rp.tab -s Dnox_Rp.synteny -o Dnox_Rp.syntenic_tandem_arrays.out
rm *temp*

for Mc

cd /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1
cat ../fasta/Mp_O_v1.AA.fasta ../fasta/M.cerasi.V1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Mc_Mp.tab
detect_syntenic_tandem_arrays -g Mc_Mp.gff -b Mc_Mp.tab -s Mc_Mp.synteny -o Mc_Mp.syntenic_tandem_arrays.out
rm *temp*
#rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Mc_Rp
cat ../fasta/Rp.v1.AA.fasta ../fasta/M.cerasi.V1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Mc_Rp.tab
detect_syntenic_tandem_arrays -g Mc_Rp.gff -b Mc_Rp.tab -s Mc_Rp.synteny -o Mc_Rp.syntenic_tandem_arrays.out
rm *temp*

for mp
cd /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp
cat ../fasta/Mp_O_v1.AA.fasta ../fasta/Rp.v1.AA.fasta > temp.fasta
diamond makedb --in temp.fasta -d temp.da
diamond blastp -p 16 --sensitive -e 1e-5 -v -q temp.fasta -d temp.da.dmnd -a temp
diamond view -a temp.daa -f tab -o Mp_Rp.tab
detect_syntenic_tandem_arrays -g Mp_Rp.gff -b Mp_Rp.tab -s Mp_Rp.synteny -o Mp_Rp.syntenic_tandem_arrays.out
rm *temp*

	
cd ./A_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Ap
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

##############################################################################################################################################################################################
###### 3 gene min


MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/A_Dnox/A_Dnox

MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/A_Mc/Ap_Mc

MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/A_Mp_O_v1/Ap_Mp

MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/A_Rp/Ap_Rp

for Dnox
cd /home/PATH_TO/scratch/synteny_working/Dnox_M
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Dnox_M/Dnox_Mc
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1/Dnox_Mp
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Rp
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Dnox_Rp/Dnox_Rp
rm -rf *.html

for Mc

cd /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1/Mc_Mp
#rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Mc_Rp
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Mc_Rp/Mc_Rp
#rm -rf *.html


for mp
cd /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp
MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp/Mp_Rp
#rm -rf *.html




for all_vs_all

MCScanX -s 3 /home/PATH_TO/scratch/synteny_working/all_all/all
 
cd ./A_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Ap
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

python annotate_results.py

mv *.annotated ./gene_min_synteny_3

##########################################################################################################################################
# min synteny 2



MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/A_Dnox/A_Dnox

MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/A_Mc/Ap_Mc

MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/A_Mp_O_v1/Ap_Mp

MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/A_Rp/Ap_Rp

#for Dnox
cd /home/PATH_TO/scratch/synteny_working/Dnox_M
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Dnox_M/Dnox_Mc
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1/Dnox_Mp
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Rp
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Dnox_Rp/Dnox_Rp
rm -rf *.html

#for Mc

cd /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1/Mc_Mp
#rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Mc_Rp
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Mc_Rp/Mc_Rp
#rm -rf *.html


#for mp
cd /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp
MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp/Mp_Rp
#rm -rf *.html


for all_vs_all

MCScanX -s 2 /home/PATH_TO/scratch/synteny_working/all_all/all
 
cd ./A_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Ap
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

python annotate_results.py

mv *.annotated ./gene_min_synteny_2

####################

cd /home/PATH_TO/scratch/synteny_working

MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/A_Dnox/A_Dnox

MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/A_Mc/Ap_Mc

MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/A_Mp_O_v1/Ap_Mp

MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/A_Rp/Ap_Rp

#for Dnox
cd /home/PATH_TO/scratch/synteny_working/Dnox_M
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Dnox_M/Dnox_Mc
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Dnox_Mp_O_v1/Dnox_Mp
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Dnox_Rp
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Dnox_Rp/Dnox_Rp
rm -rf *.html

#for Mc

cd /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Mc_Mp_O_v1/Mc_Mp
rm -rf *.html

cd /home/PATH_TO/scratch/synteny_working/Mc_Rp
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Mc_Rp/Mc_Rp
rm -rf *.html


#for mp
cd /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp
MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/Mp_O_v1_Rp/Mp_Rp
rm -rf *.html


#for all_vs_all

#MCScanX -s 1 /home/PATH_TO/scratch/synteny_working/all_all/all

cd /home/PATH_TO/scratch/synteny_working 
cd ./A_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./A_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Dnox_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Ap
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mc
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mc_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Mp_O_v1_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_A
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Dnox
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_M
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Mp_O_v1
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..

 cd ./Rp_Rp
cp *.synteny ../ 
cp *syntenic_tandem_arrays.out ../ 
cp *gene_type ../ 
cp *duplication.info ../
cd ..
cd /home/PATH_TO/scratch/synteny_working
python annotate_results.py

mv *.annotated ./gene_min_synteny_1


















#example
detect_syntenic_tandem_arrays -g Mc_Mp.gff -b Mc_Mp.blast -s Mc_Mp.synteny -o test.txt

7)
#dissect_multiple_alignment -g gff_file -s synteny_file -o output_file

dissect_multiple_alignment -g Mc_Mp.gff -s Mc_Mp.synteny  -o Mc_Mp.dissect_multiple.out


8)
#dot plotter

#java dot_plotter -g gff_file -s synteny_file -c control_file -o output_PNG_file


java /home/PATH_TO/scratch/Downloads/MCScanx-master/downstream_analyses/dot_plotter -g Mc_Mp.gff -s Mc_Mp.synteny -c control_file -o Mc10_100_output_PNG_file



