Bedtools intercetp and Jacrd:

1)########################################################################################################
First of all we can "clean up " the gff using genometools
		gt gff3 -sort yes -tidy yes -addids -sortnum yes -retainids yes -fixregionboundaries yes -addintrons yes -force -o reformatted.gff3 *.gff 
	
		Rpadi reformatting:

		gt gff3 -sort -tidy -addids -sortnum -fixregionboundaries -addintrons -force -o R.padiV4_complete_pea_aphid_RNASEQ001.gff3 R.padiV4_complete_pea_aphid_RNASEQ001.gff
		gt gff3 -sort -tidy -addids -sortnum -fixregionboundaries -addintrons -force  -o R.padi_complete_Rp_models_ep_hints.gff3 R.padi_complete_Rp_models_ep_hints.gff
 
 2)########################################################################################################
 bedtools intersect: (http://bedtools.readthedocs.org/en/latest/content/tools/intersect.html)
 
 
	-wao Write amounts of overlap for all features.
 
	bedtools intersect -wao -a ./augustus_pea_models/R.padiV4_complete_pea_aphid_RNASEQ001.gff -b ./ausustus_retrained/R.padi_complete_Rp_models_ep_hints.gff
 
	report that the DO NOT MATCH:
 
	-v
 
	bedtools intersect -wa -wb -a ./augustus_pea_models/R.padiV4_complete_pea_aphid_RNASEQ001.gff -b ./ausustus_retrained/R.padi_complete_Rp_models_ep_hints.gff -v

	Or, let’s report only those intersections where 100% of the query record is overlapped by a database record: -filenames
	
	Real exmaple, then look at the output:
		bedtools intersect -wao -a ./augustus_pea_models/R.padiV4_complete_pea_aphid_RNASEQ001.gff -b ./ausustus_retrained/R.padi_complete_Rp_models_ep_hints.gff > test.out
		cat test.out | grep "gene" | grep "ID=" | cut -f1,3,9,19 | less
	
	lets look at only the gene part, as created in the following step below:
	bedtools intersect -wao -a ./augustus_pea_models/Rp_pea_genes_only.gff3 -b ./ausustus_retrained/Rp_retrained_genes_only.gff3 > Rp_pea_gene_vs_braker_genes_only.out
	 cat test.out | grep "gene" | grep "ID=" | cut -f1,3,4,5,9,13,14,19 | less
	 cat Rp_pea_gene_vs_braker_genes_only.out | grep "gene" | grep "ID=" |cut -f1,3,4,5,9,13,14,19 | sort -k8 -rn > Rp_pea_gene_vs_braker_genes_only_sorted.out
	 
	 #unique genes -v
	 
	 bedtools intersect -wao -v -a ./ausustus_retrained/Rp_retrained_genes_only.gff3 -b ./augustus_pea_models/Rp_pea_genes_only.gff3 > uniq_braker_genes_only.out

3)########################################################################################################	
bedtools jaccard (http://bedtools.readthedocs.org/en/latest/content/tools/jaccard.html)
Whereas the bedtools intersect tool enumerates each an every intersection between two sets of genomic intervals, one often needs a single statistic reflecting the similarity of the two sets based on the intersections between them. The Jaccard statistic is used in set theory to represent the ratio of the intersection of two sets to the union of the two sets. Similarly, Favorov et al [1] reported the use of the Jaccard statistic for genome intervals: specifically, it measures the ratio of the number of intersecting base pairs between two sets to the number of base pairs in the union of the two sets. The bedtools jaccard tool implements this statistic, yet modifies the statistic such that the length of the intersection is subtracted from the length of the union. As a result, the final statistic ranges from 0.0 to 1.0, where 0.0 represents no overlap and 1.0 represent complete overlap.
bedtools jaccard [OPTIONS] -a <BED/GFF/VCF> -b <BED/GFF/VCF>

	first, lets compare this on a gene level:
	cat R.padiV4_complete_pea_aphid_RNASEQ001.gff3 | grep "gene" | grep "ID=" > Rp_pea_genes_only.gff
	cat R.padi_complete_Rp_models_ep_hints.gff3 |  grep "gene" | grep "ID=" > Rp_retrained_genes_only.gff
	# fix the mistakes that have crept in
	gt gff3 -sort -tidy -addids -sortnum -fixregionboundaries -addintrons -force -o Rp_pea_genes_only.gff3 Rp_pea_genes_only.gff
	gt gff3 -sort -tidy -addids -sortnum -fixregionboundaries -addintrons -force -o Rp_retrained_genes_only.gff3 Rp_retrained_genes_only.gff

	-f min overlap
	
	bedtools jaccard -a ./augustus_pea_models/Rp_pea_genes_only.gff3 -b ./ausustus_retrained/Rp_retrained_genes_only.gff3 > jaccard_test.out
	#with the whole data set:
	
	bedtools jaccard -a ./augustus_pea_models/R.padiV4_complete_pea_aphid_RNASEQ001.gff3 -b ./ausustus_retrained/R.padi_complete_Rp_models_ep_hints.gff3 > jaccard_test.out
	