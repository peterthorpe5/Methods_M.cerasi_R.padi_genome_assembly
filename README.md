Methods used to assembly M.cerasi and R.padi genomes
====================================================

basic usage for most python scripts (python folder, or follow links) to obtain the help menu:

``./script.py`` -h 

genome assembly
===============
1)First pass assemblies were generated using CLC. An interative process of contaminant read removal was performed, as can be seen in the following shell script. 
8 rounds were performed for M. cerasi and 5 were performed for R. padi. However, at the time of assembly
Blobtools was in its infancy and this version was used: https://github.com/DRL/blobtools-light . 
``clc_assembly_remove_contaminants.sh``
The folder R.padi_contaimination_filtering contains exact command used, and how blobplots were generated. And how contaiminat contigs were identified. 

2) once the reads were "cleaned", the final reads were converted to sam/bam using:
``./fastq_to_sam.py``  ``fastq_to_bam.sh``

3) The resulting bam file were subjected to assembly using DISCOVAR, for example:
``discovar_assemble_genome.sh``

Assemblers: platanus_v7, IBDA, Abyss, SOAP, Spades were all tried but the results were not used.
Bless error corrected reads were tried but not used in the final assembly. 

4) Busco with arthropoda busco models was used to gain a relative measure of genome "completeness", along with CEGMA:
``BUSCO.sh``
``cegma_all.sh``

Gene models
===========
RNAseq data from previous aphid studies was used, for heads versus bodies RNAseq data: 
``Data_Summary_APHID_RNASEQ.xlsx``
Diuraphis noxia data from 
http://www.ebi.ac.uk/ena/data/view/SRR1999270

http://www.ebi.ac.uk/ena/data/view/SRX962821

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/000/SRR1999270/SRR1999270_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/000/SRR1999270/SRR1999270_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/009/SRR1999279/SRR1999279_1.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR199/009/SRR1999279/SRR1999279_2.fastq.gz

A. pisum data from 
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

1) verson 0.9 gene calls were produced using the folowing script. This uses the pea aphid config files bundled with Augustus:
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


Gene model annotation and analysis
==================================

6)signal peptide and transmembrane domain rediction was perfomed using:
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

14) Heat map were drawn using ggplot and R. Data was prepared using:
``catorgorise_genes_for_heat_map.py``  and  ``heat_map_R_script.R``

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
``wheat_LTR_TE_finding.sh`` and ``wheat_aphid_TE_finding.sh``

22) differential exon expression:
``Mp_Hosts_non_hosts_DE_exons_R_commands.sh`` and ``exon_counts.sh``

23) differential expression:
``Diff_Expression_trinity_Aug_2014_gene_models.sh``

24) RNAseq mapping host and nonhost:
``Mp_host_non_map_to_genome.sh``

25) GFF fixing and formatting, jaccard statistic was done using genometools and bedtools:
``Bedtools_intercetp_and_Jacrd.txt.sh`` and ``genome_tools.txt``

26) GO and PFAM annotation was performed with BLAST2GO v2.8. The amino acid gene models were BLASTp searched against NR, the resulting xml file was imported into B2G.
GO and PFAM mapping was perfomed using the GUI:
``Rp_vs_nr_xml.sh``

27) Single copy busco genes were identified using script in BUSCO_phylogenetics.







