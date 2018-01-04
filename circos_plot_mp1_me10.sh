# Circos plots - test with two scaffolds

http://circos.ca/documentation/tutorials/quick_start/hello_world/configuration

to run ciros on biolinux:

perl PATH_TO/bin/circos -conf circos_Mc.conf

# note see end of file for how RNAseq was mapped and some files were generated:

#########################################################
#prepare the gene files first:

cd circos/
cd Mp1_mpsec_5_all_genomes/
mkdir RP
cat Rpa.v1.gff | grep "Rp1827" | cut -f9 | grep "ID=" | grep -v ".t1" > RPgenes
ls
python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py R.padi_AA.annotated.fasta RPgenes Rp1827.scaffold.gene.fasta
head Rp1827.scaffold.gene.fasta
cd RP
python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py R.padi_AA.annotated.fasta RPgenes Rp1827.scaffold.gene.fasta
head Rp1827.scaffold.gene.fasta




cat Pea_aphid.gff | grep "GL349624" | grep "gene"
python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py A.pisum.AA.annotated.fasta peagenes GL349624.scaffold.gene.fasta


cat Dnox.v1.gff | grep JOTR01000179 | grep "gene" > Dnoxgenes

python ~/misc_python/get_sequences_i_want_from_fasta_command_line.py Dnox.v1.AA.fasta Dnoxgenes JOTR01000179.scaffold.gene.fasta

##############################################################



0) detect synteny using MCScanX first - this will help to identify syntenic scaffolds.

#############################################################################################################
1) create a GC window
		# arguments:  in.fasta windowsize > pipe_to_file
		
		$ python  ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py Mc_mp1_mpsec5_scaffold.fasta 25 > Mc_mp1_mpsec5_scaffold.fasta.gc.25.txt
		$ python  ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py Mc_mp1_mpsec5_scaffold.fasta 250 > Mc_mp1_mpsec5_scaffold.fasta.gc.250.txt
		$ python  ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py Mp1_Mpsec5.scaffodl.fasta 25 > Mp1_Mpsec5.scaffodl.fasta.gc.25.txt
		$ python  ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py Mp1_Mpsec5.scaffodl.fasta 250 > Mp1_Mpsec5.scaffodl.fasta.gc.250.txt
		
		#cat the coverage files of the scaffolds together in one file. , make sue the scaff names are consistent with later names
		cat *gc.250.txt > all.GC.250.txt
		$ cat *gc.25.txt > all.GC.25.txt
		
#############################################################################################################		
2) create a karytype file: save this file, as the confi file will use this

		#e.g. chr - ID LABEL START END COLOR
		
		# SPACE SEPAREATED!!!
		chr - Gr1_EF193005 Gr1 0 9210 vvvlgrey
		chr - Gr2_EF462976 Gr2 0 6604 vvvlgrey
		chr - Gr3_EF462977 Gr3 0 3192 vvvlgrey
		chr - Gr4_EF462978 Gr4 0 6010 vvvlgrey
		chr - Gr5_EF462979 Gr5 0 5480 vvvlgrey
		chr - Gr6_EF462980 Gr6 0 5797 vvvlgrey
		chr - Gr7_EF462981 Gr7 0 5308 vvvlgrey
		
		# so I wan to draw to scaffold. detail the star and end, and only put two scaffold in the file. 
		# get scaff len from files from step one
		chr - Mc363 Mc363 0 74024 vvvlgrey
		chr - scaffold_172 scaffold_172 0 382779 vvvlgrey
		chr - Rp1827 Rp1827 0 90145 vvvlgrey
		chr - GL349624 GL349624 0 2478080 vvvlgrey
		chr - JOTR01000179 JOTR01000179 0 536200 vvvlgrey

 
#############################################################################################################  
 3) get the coverage plots.
 
 #I am chosing RNAseq cov.
 #map the RNAseq to the whole genome:
 
		mkdir star_indicies
		$ STAR --runMode genomeGenerate --runThreadN 10 --limitGenomeGenerateRAM 74554136874 --genomeDir PATH/scratch/PATH_TO/Mp_O/Mp_O_host_non_RNAseq_assembly/star_indicies --genomeFastaFiles PATH/scratch/PATH_TO/Mp_O/Mp_O_host_non_RNAseq_assembly/Mp1087439_TGAC_V1.1-scaffolds.fa
		$ STAR --genomeDir star_indicies/  --runThreadN 12 --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outFilterMismatchNmax 7 --readFilesCommand zcat --outFileNamePrefix Mp_O_RNA_mapped --readFilesIn ../Mp_O_RNAseq/Mp_O_R1.fq.gz ../Mp_O_RNAseq/Mp_O_R2.fq.gz
		
		# index the genome
		$ STAR --runMode genomeGenerate --runThreadN 10 --limitGenomeGenerateRAM 74554136874 --genomeDir PATH/scratch/PATH_TO/M.cerasi/star_indicies --genomeFastaFiles PATH/scratch/PATH_TO/M.cerasi/Mc_alt.fasta
		$ STAR --genomeDir star_indicies/  --runThreadN 12 --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outFilterMismatchNmax 7 --readFilesCommand zcat --outFileNamePrefix Mc_wild --readFilesIn PATH/scratch/PATH_TO/M.cerasi/RNAseq/Mc_R1.fq.gz PATH/scratch/PATH_TO/M.cerasi/RNAseq/Mc_R2.fq.gz
		
		# sort the bam file
		$ samtools sort -@ 16 Mc_wildAligned.sortedByCoord.out.bam mc_sorted
		
		# index the sorted bam file
		
		$ samtools index mc_sorted
		
		#get the depth of coverage at each postition: samtools depth
		$ samtools depth mc_sorted.bam > Mc_whole_genome.RNAseq.depth
		$ samtools depth Mp_O_RNA_mappedAligned.sortedByCoord.out.bam > Mp_O_RNA.depth
		
		# python to return the cov of ONLY the scaffold of interest
		# have to set up a file with the scaffolds of interest in arg.var[2]
		
		$ python ~/misc_python/Circos_python_scripts/get_scaffold_cov_only.py Mc_whole_genome.RNAseq.depth wanted_scaff > Mc363_RNAseq.dpeth.out
		
		python ~/misc_python/Circos_python_scripts/get_scaffold_cov_only.py PATH/scratch/PATH_TO/Mp_O/Mp_O_host_non_RNAseq_assembly/Mp_O_RNA.depth wanted_scaff > Mp1087439_TGAC_V1.1_scaffold_172_RNAseq.dpeth.out
		
		#python cov_window_for_covfile.py covfile window_size karyoteyp_file > output_file.txt
		$ python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py Mc363_RNAseq.dpeth.out 250 ./plotting_files/karyotype.Mc.txt > Mc363_RNAseq.dpeth.250.window
		
		$ python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py Mp1087439_TGAC_V1.1_scaffold_172_RNAseq.dpeth.out 250 ./plotting_files/karyotype.Mc.txt > Mp1087439_TGAC_V1.1_scaffold_172_RNAseq.dpeth.out.250.window

		$ python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py Mp1087439_TGAC_V1.1_scaffold_172_RNAseq.dpeth.out 100 ./plotting_files/karyotype.Mc.txt > Mp1087439_TGAC_V1.1_scaffold_172_RNAseq.dpeth.out.100.window
		
		#cat the cov plots:
		cat *cov.100.txt > all.RNAseq.dpeth.out.100.windw
		

#############################################################################################################
4) blast the proteins sequences already ...

		# sensitive blastx vs nr 
		# --max-target-seqs 5 if required
		diamond blastp -p 16 --sensitive -e 1e-5 -v -q Mc_Mp.fasta -d Mc_Mp.dmnd -a p.Mc_Mp_vs_mc_mp.da
		diamond view -a p.Mc_Mp_vs_mc_mp.da*.daa -f tab -o p.Mc_Mp_vs_mc_mp.tab
		
		cp p.Mc_Mp_vs_mc_mp.tab Mc_Mp.blast
		# individual species Mc
		diamond blastp -p 16 --sensitive -e 1e-10 -v -q ./fastafile/M.cerasi.V1.AA.fasta -d Mc.dmnd -a p.Mc_vs_mc.da
		diamond view -a p.Mc_vs_mc.da*.daa -f tab -o p.Mc_vs_mc.tab
		
		cp p.Mc_vs_mc.tab Mc_Mc.blast
		# individual species Mp
		diamond blastp -p 16 --sensitive -e 1e-10 -v -q ./fastafile/Mp_O_v1.AA.fasta -d Mp.dmnd -a p.Mp_vs_mp.da
		diamond view -a p.Mp_vs_mp.da*.daa -f tab -o p.Mp_vs_mp_.tab
		cp p.Mp_vs_mp.tab Mp_Mp.blast


#############################################################################################################
5) parse the blast file.
		python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py mp1_mpsec5_scff.blast 30 > mc_mp_ribbon.bit30.between.txt
		
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 30 | grep -v ".t2"  > all_blast.bit30.between.txt
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 50 > all_blast.bit50.between.txt
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 70 > all_blast.bit70.between.txt
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 1000 > all_blast.bit100.between.txt
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 100 | grep -v ".t2" | grep -v ".12" > all_blast.bit100.between.txt
python  ~/misc_python/Circos_python_scripts/DNA_blast_analysis.py all_vs_all.tab 150 > all_blast.bit150.between.txt



cat all_blast.bit100.between.txt  | grep -v ".t2" > all_blast.bit100.between2.txt
cat all_blast.bit30.between.txt   | grep -v ".t2" > all_blast.bit30.between2.txt 
cat all_blast.bit70.between.txt   | grep -v ".t2" > all_blast.bit70.between2.txt 
cat all_blast.bit150.between.txt  | grep -v ".t2" > all_blast.bit150.between2.txt
cat all_blast.bit50.between.txt   | grep -v ".t2" > all_blast.bit50.between2.txt 

rm all_blast.bit100.between.txt
rm all_blast.bit30.between.txt 
rm all_blast.bit70.between.txt 
rm all_blast.bit150.between.txt		
rm all_blast.bit50.between.txt 	


 python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit50.between2.txt -o temp	
 
 python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit100.between2.txt -o all_blast.bit100.between.txt
 python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit70.between2.txt  -o all_blast.bit70.between.txt 
 python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit150.between2.txt -o all_blast.bit150.between.txt
 python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit50.between2.txt  -o all_blast.bit50.between.txt 
 
 
  python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit30.between.txt --gff all.gff -o all_blast.bit30.between.genecoordinates.txt 
  
  python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit150.between.txt --gff all.gff -o all_blast.bit150.between.genecoordinates.redone.txt

   python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit100.between.txt --gff all.gff -o all_blast.bit100.between.genecoordinates.redone.txt

 
the blast file needs to be formatted correctly. - save as file so config can get it

python ~/misc_python/Circos_python_scripts/re_format_blast_results.py -i all_blast.bit50.between2.txt -o temp
		
		#scaffold	start	stop	saff2	start	stop	colour
		scaffold_172 103340	104192 Mc363 54754	55592 color=red
		scaffold_172 108506	109843 Mc363 60978	61364 color=red
		scaffold_172 273725	274104 scaffold_172 482 614 color=lgrey
		scaffold_172 297225	301530 scaffold_172 297225	301530 color=lgrey

#############################################################################################################		
6) creat a bands file

 cat Rpa.v1.gff | grep -Ff RPgenes | grep "gene" | cut -f1,4,5,9 >  Rp_gene_coordinates

#saffold	start	stop	tag/info	label
		scaffold_172	9486	16018	Mpe06376|beat	lable=gene
		scaffold_172	31923	32321	Mpe06377|NA	lable=gene
		scaffold_172	47231	47605	Mpe06378|NA	lable=gene
		scaffold_172	72647	72952	Mpe06379|NA	lable=gene
		scaffold_172	103340	104192	Mpe06380|LOC100165393	lable=effector
		scaffold_172	108506	109843	Mpe06381|LOC100167427	lable=effector
		scaffold_172	117114	117401	Mpe06382|NA	lable=gene
		scaffold_172	120130	120610	Mpe06383|NA	lable=gene
		scaffold_172	142290	142616	Mpe06384|NA	lable=gene
		scaffold_172	168389	168634	Mpe06385|NA	lable=gene
		scaffold_172	169387	171558	Mpe06386|NA	lable=gene
		scaffold_172	190768	191079	Mpe06387|NA	lable=gene
		scaffold_172	217249	254885	Mpe06388|thiamine	lable=gene
		scaffold_172	255459	260980	Mpe06389|nuclear	lable=gene
		scaffold_172	266885	272296	Mpe06390|polymerase	lable=gene
		scaffold_172	273725	274104	Mpe06391|prestin	lable=gene
		scaffold_172	297225	301530	Mpe06392|prestin	lable=gene
		scaffold_172	366032	366484	Mpe06393|NA	lable=gene
		Mc363	17340	17753	Mca02123|NA	lable=gene
		Mc363	18196	18558	Mca02124|NA	lable=gene
		Mc363	19125	19403	Mca02125|NA	lable=gene
		Mc363	48996	49592	Mca02126|NA	lable=gene
		Mc363	54754	55592	Mca02127|LOC100165393	lable=effector
		Mc363	60978	61364	Mca02128|Me10	lable=effector
		
#############################################################################################################		
7)

#########################		
		
		
		
		
		cd PATH/scratch/PATH_TO/Pea_aphid



cat PATH/scratch/PATH_TO/Pea_aphid/data/N116_R1_Q30paired.fq.gz PATH/scratch/PATH_TO/Pea_aphid/data/PS01_R1_Q30paired.fq.gz > R1.fq.gz
cat PATH/scratch/PATH_TO/Pea_aphid/data/N116_R2_Q30paired.fq.gz PATH/scratch/PATH_TO/Pea_aphid/data/PS01_R2_Q30paired.fq.gz  > R2.fq.gz

STAR --genomeDir star_indicies/  --runThreadN 12 --sjdbGTFfile ./A.pisum.gtf --quantMode TranscriptomeSAM --outFilterMultimapNmax 5 --outSAMtype BAM SortedByCoordinate --outSAMmapqUnique 255 --outFilterMismatchNmax 5 --readFilesCommand zcat --outFileNamePrefix Pea  --readFilesIn R1.fq.gz R2.fq.gz 


#1) create a GC window
# arguments:  in.fasta windowsize > pipe_to_file
		
python ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py GL349624.scaffold.fasta 25 > GL349624.scaffold.fasta.gc.25.txt
python ~/misc_python/Circos_python_scripts/gc_window_for_sequences.py GL349624.scaffold.fasta 250 > GL349624.scaffold.fasta.gc.250.txt


samtools sort -@ 12 PeaAligned.sortedByCoord.out.bam Pea_sorted

samtools index Pea_sorted.bam


#get the depth of coverage at each postition: samtools depth
samtools depth Pea_sorted.bam > Pea_whole_genome.RNAseq.depth

#GL349624   wanted scaffold

python ~/misc_python/Circos_python_scripts/get_scaffold_cov_only.py Pea_whole_genome.RNAseq.depth wanted.scaff > GL349624_RNAseq.depth.out
		
#python cov_window_for_covfile.py covfile window_size karyoteyp_file > output_file.txt
		
python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py GL349624_RNAseq.depth.out 250 /home/PATH_TO/scratch/diagram_drawing_test/circos/mp1_mpsec5/plotting_files/karyotype.Mc.txt > GL349624_RNAseq.depth.out_RNAseq.dpeth.out.250.window

python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py GL349624_RNAseq.depth.out 100 /home/PATH_TO/scratch/diagram_drawing_test/circos/mp1_mpsec5/plotting_files/karyotype.Mc.txt > GL349624_RNAseq.depth.out_RNAseq.dpeth.out.100.window

python ~/misc_python/Circos_python_scripts/cov_window_for_bedfile.py GL349624_RNAseq.depth.out 50 /home/PATH_TO/scratch/diagram_drawing_test/circos/mp1_mpsec5/plotting_files/karyotype.Mc.txt > GL349624_RNAseq.depth.out_RNAseq.dpeth.out.500.window


gene_to_scaff_dict = {"Api": "GL349624",
                      "Mca": "Mc363",
                      "Mpe": "scaffold_172",
                      "Rpa": "Rp1827",
                      "Dno": "JOTR01000179",
                      "MYZPE": "scaffold_648"}

