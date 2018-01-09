Methods used to assemble aphid genomes: M. cerasi and R. padi
===========================================================

basic usage for most python scripts (python folder, or follow links) to obtain the help menu:

``./script.py`` -h 

Genome assembly
===============
The raw genomic reads for M. cerasi and R. padi are available at study accession: PRJEB24287 and PRJEB24204, respectively

1) First pass assemblies were generated using CLC. An interative process of contaminant read removal was performed, as can be seen in the following shell script. 
8 rounds were performed for M. cerasi and 5 were performed for R. padi. However, at the time of assembly
Blobtools was in its infancy and this version was used: https://github.com/DRL/blobtools-light . 
``clc_assembly_remove_contaminants.sh``
The folder R.padi_contaimination_filtering contains exact command used, and how blobplots were generated. 
And how contaiminat contigs were identified and those contributing reads were removed.

2) Once the reads were "cleaned", the final reads were converted to sam/bam using:
``./fastq_to_sam.py``  ``fastq_to_bam.sh``

3) The resulting bam file was subjected to assembly using DISCOVAR, for example:
``discovar_assemble_genome.sh``

Assemblers: platanus_v7, IBDA, Abyss, SOAP, Spades were all tried but the results were not used.
Bless error corrected reads were tried but not used in the final assembly. 

4) Busco with arthropoda hmm models was used to gain a relative measure of genome "completeness", along with CEGMA:
``BUSCO.sh``
``cegma_all.sh``

R. padi genomic reads can be obtained from this: study accession number is: PRJEB24204 Sample	ERS2070958 (SAMEA104453016)
The lib prep was PCR-free with an insert size avergae of 405bp. The reads were 2X250bp on HiSeq 2500. This is what DISCOVAR assembler requires.

Gene models
===========
RNAseq data from previous aphid studies was used, for heads versus bodies RNAseq data: 

``Data_Summary_APHID_RNASEQ.xlsx``

PRJEB9912: http://www.ebi.ac.uk/ena/data/view/PRJEB9912


Diuraphis noxia data from:

http://www.ebi.ac.uk/ena/data/view/SRR1999270

http://www.ebi.ac.uk/ena/data/view/SRX962821

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/000/SRR1999270/SRR1999270_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/000/SRR1999270/SRR1999270_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/009/SRR1999279/SRR1999279_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/009/SRR1999279/SRR1999279_2.fastq.gz

A. pisum data from:

data from http://www.ebi.ac.uk/ena/data/view/PRJNA209321

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924106/SRR924106_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924106/SRR924106_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924118/SRR924118_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924118/SRR924118_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924119/SRR924119_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924119/SRR924119_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924120/SRR924120_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924120/SRR924120_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924121/SRR924121_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924121/SRR924121_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924122/SRR924122_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR924/SRR924122/SRR924122_2.fastq.gz

1) Verson 0.9 gene calls were produced using the folowing script. This uses the pea aphid config files bundled with Augustus:
``Augustus.sh``

2) RNAseq was mapped back to the final genome using a splice aware aligner, STAR. This allowed --outFilterMultimapNmax 5 --outFilterMismatchNmax 7: 
``STAR.sh``

3) The resulting bam file was sorted and indexed with samtools (default commands). A RNAseq intron hints file was genereated from this:
``bam2hints --intronsonly --in=rnaseq.fs.bam --out=hints.gff``

4) version 1.0 gene models were produced using Braker:
``Braker_GENE_models.sh``
For BRAKER, even though it says it renames contigs names, it still failed for me. So, the RNAseq.Intron.hints and the fasta names were renamed using the using the following, proir to running Braker:
https://github.com/peterthorpe5/public_scripts/tree/master/reformat_fasta_hints_names_for_Braker

5) Gene models testing and interogation was used with this:
https://github.com/peterthorpe5/public_scripts/tree/master/gene_model_testing

This was used to gain an insight in the amount of RNAseq mapping the was to gene models, gene number, lenght etc ... BLAST versus NR with and without filtering for pea aphid, arthropoda. Alignment to known - cloned 
sequences. This helped us identify that the Braker method also produced much better intron exon boundry prediction when aligned to our known - cloned sequences verus Augustus run with 
the pea aphid config files. 


Gene model annotation and analysis
==================================

6) Signal peptide and transmembrane domain rediction was perfomed using:
``PHOBIUS.sh``

7) Diamond blast output was taxonomically annotated using:
https://github.com/peterthorpe5/public_scripts/tree/master/Diamond_BLAST_add_taxonomic_info

blast versus NR:
``Blast_vs_NR.sh``

8) Intron analysis was interogeated using:
https://github.com/DRL/GenomeBiology2016_globodera_rostochiensis/blob/master/scripts/extractRegionFromCoordinates.py

https://github.com/peterthorpe5/public_scripts/tree/master/Introns

9) Lateral/ Horizontal gene transfer was predicted using:
https://github.com/peterthorpe5/public_scripts/tree/master/Lateral_gene_transfer_prediction_tool

``HGT_filtering_20170919.sh``

10) Blast output filtering was applied using (top hits or taxonomocally filtered for example to remove pea aphid hits):
https://github.com/peterthorpe5/public_scripts/tree/master/blast_output

``Blast_vs_NR.sh``

11) Gene network Cluster interogation was performed using:
https://github.com/peterthorpe5/public_scripts/tree/master/cluster_analysis

12) Converting file formats, e.g. fasta to phylip:
https://github.com/peterthorpe5/public_scripts/tree/master/convert_file_format

13) For promoter finding, genomic upstream regions was obtained using:
https://github.com/peterthorpe5/public_scripts/tree/master/genomic_upstream_regions

14) Effectors: data from  http://www.ebi.ac.uk/ena/data/view/PRJEB9912 was mapped to the genomes for M. cerasi, M. persicae (Genotype O data only) and R. padi. The libraries 
were head and bodies. Differential expression analysis identified the gene upregulated in heads versus bodies. Phobius was used to identify 
genes that encoded a signal peptide and no transmembrane domain. Saliva proteomic data from https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2496-6 
was mapped to the predicted genes from M. cerasi, M. persicae and R. padi using Max Quant. Identified gene were again interogated for a signal peptide and no transmembrane domain. 
Any genes passing these criteria were considered putative effectors. For A. pisum, as there have been new gene calls, any gene that was 
greater 95% identity (BLASTp) to saliva protein identified (Carolan et al., 2011) (DOI:10.1021/pr100881q) were considered putative effectors from A. pisum.

15) Introgation of transposons was perfomed using:
https://github.com/peterthorpe5/public_scripts/tree/master/transposon_analysis

16) Recipricol best blast hit was performed. Clusters of interest were alined using muscle and refined using muscle. Alignments were converted to phylip files and dn/ds was calculated using codonphyml:
``dn_ds_from_1_to_1_cluster_parteners.sh``

cluster interogation was perfomred using:
``Interogate_clusters_commands.sh``

17) circos plots wer drawn using the following commands:
``circos_plot_C0002_all_genome.sh`` and ``circos_plot_mp1_me10.sh``

18) transrate was used to gain an insight into fused gene:
``transrate.sh``

For R. padi there may be 300 genes that are fused due to significanlty different coverage along the gene. We decided not to act on this information. 
Transrate was also used to gain a quantitative measure of the number of reads that map to the nt gene models. This wraps and uses SNAP for this process. 

19) Gene duplicatoion and synteny was performed using:
``McScanX_all_aphid_genes.sh`` , ``McScanX_to_detect_synteny.sh``, ``McScanX.sh``

20) Splicing sites:
``prepare_splicing_sites.sh``

21) Transposon and repetitive element prediction:
https://github.com/HullUni-bioinformatics/TE-search-tools

Once a collection of aphid specific repeats were modelled/ generated, CD-HIT-est was used at 100% to remove redundancy. This aphid de novo set of calssified repeats 
and repbase was then used to mask the genomes and predict transposons from all species. Transposable elements can be found in the folder ``transposable_elements``

``wheat_LTR_TE_finding.sh`` and ``wheat_aphid_TE_finding.sh``

22) Differential exon expression, although not reported on, this was performed anyway:
``Mp_Hosts_non_hosts_DE_exons_R_commands.sh`` and ``exon_counts.sh``

23) Differential expression:
``Diff_Expression_trinity_Aug_2014_gene_models.sh``

24) RNAseq mapping host and nonhost (STAR):
``Mp_host_non_map_to_genome.sh``

25) GFF fixing and formatting, jaccard statistic was done using genometools and bedtools:
``Bedtools_intercetp_and_Jacrd.txt.sh`` and ``genome_tools.txt``

26) GO and PFAM annotation was performed with BLAST2GO v2.8. The amino acid gene models were BLASTp searched against NR, the resulting xml file was imported into B2G.
GO and PFAM mapping was perfomed using the GUI:
``Rp_vs_nr_xml.sh``

27) Single copy busco genes were identified using scripts in BUSCO_phylogenetics.

28) Heat map were drawn using ggplot and R. Data was prepared using:
``catorgorise_genes_for_heat_map.py``  and  ``heat_map_R_script.R``

Genes at the start or end of contigs were not drawn on the heat map and were not considered in distance calculations.

29) genome tools was used to interogate the old A. pisum gene model coordinate with the new gene models. If there was overlap then the gene is assigned old name to new name in /A.pisum:
``A.pisum.AA.annotated_with_old_names.fasta.gz`` and 
``A.pisum_OLD_to_NEW_GENES_overlap.tab.gz``


RNAseq analysis
===============

30) RNAseq data: The raw RNAseq reads for R. padi and M. persicae reared on host, nonhost and artificial diet at time points 3hours and 24 hours are available at study accession: PRJEB24317

``PRJEB24317_data_summary.xlsx`` is a data summary which will hopefully be helpful due to the vast number of files: AD = artificial diet, H = host and NH = non host. 

31) shell scripts used are in ``RNAseq_analysis``

32) Quality control was performed using: ``Quality_control_final_QC_reads``

33) Read were mapped to the genomes using STAR. The resulting bam files were assebmled using Trinity. 

Trinity Genome guided RNaseq assemblies were produced.  ``Trinity_assembly/Rp_hostnon_GG_Trinity.sh``

34) Transcript abundance was quantified using Kalisto. 

33) annotating the transcriptome: ``Annotating_transcriptome``

