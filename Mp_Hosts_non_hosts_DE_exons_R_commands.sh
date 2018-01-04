R
#inDir = system.file("extdata", package="pasilla")


inDir = '/home/PATH_TO/Desktop/Mp_Hots_nnhost_DE_exon'

countFiles = list.files(inDir, pattern=".exon.counts$", full.names=TRUE)

basename(countFiles)

flattenedFile = list.files(inDir, pattern="gff$", full.names=TRUE)

basename(flattenedFile)


# [1] "treated1fb.txt"   "treated2fb.txt"   "treated3fb.txt"   "untreated1fb.txt"
## [5] "untreated2fb.txt" "untreated3fb.txt" "untreated4fb.txt"

				
				
				
sampleTable = data.frame(row.names = 

c("Mp_host_24h_1", "Mp_host_24h_2", "Mp_host_24h_3", "Mp_host_24h_4", "Mp_host_24h_5","Mp_nonhost_24h_1", "Mp_nonhost_24h_2", "Mp_nonhost_24h_3", "Mp_nonhost_24h_4", "Mp_nonhost_24h_5"), condition = c("Mp_host_24h", "Mp_host_24h", "Mp_host_24h", "Mp_host_24h", "Mp_host_24h", "Mp_nonhost_24h", "Mp_nonhost_24h", "Mp_nonhost_24h", "Mp_nonhost_24h", "Mp_nonhost_24h"),libType = c("paired-end", "paired-end", "paired-end", "paired-end", "paired-end", "paired-end", "paired-end", "paired-end", "paired-end", "paired-end"))
				

sampleTable


#dxd =read.HTSeqCounts(countFiles,sampleData=sampleTable,design= ~ sample + exon + condition:exon,flattenedfile=flattenedFile) 


library("DEXSeq")


######################################################################################################


dxd = DEXSeqDataSetFromHTSeq(countFiles,sampleData=sampleTable,design= ~ sample + exon + condition:exon,flattenedfile=flattenedFile)

# create a file with gene name, grep genome.gff | cut -f gene_name > geneIDsinsubset.txt


genesForSubset = read.table(file.path(inDir, "geneIDsinsubset.txt"),stringsAsFactors=FALSE)[[1]]


dxd = dxd[geneIDs( dxd ) %in% genesForSubset,]

colData(dxd)



head( counts(dxd), 5)

 
head( featureCounts(dxd), 5) 

 head ( rowRanges(dxd), 3 )

sampleAnnotation( dxd )



####################################################################################################################################################################################
4) normalisation

# can use multiple core if using  package BiocParallel,  and  implemented  the BPPARAM


#BPPARAM = MultiCoreParam(workers=3)


# uses DEseq2 method
dxd = estimateSizeFactors( dxd )



# dispersion estimation
dxd = estimateDispersions( dxd)

		# multi core
		#dxd = estimateDispersions( dxd, BPPARAM=BPPARAM)



plotDispEsts( dxd )


# test for DE (exon) expression) 
dxd = testForDEU( dxd )

		# multi core
		dxd = testForDEU( dxd, BPPARAM=BPPARAM)



# estimate fold change

dxd = estimateExonFoldChanges( dxd, fitExpToVar="condition")


dxr1 = DEXSeqResults( dxd )

write.table(dxr1, file = "Dexseq_results.out", append = FALSE, quote = TRUE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")

dxr1

#From this object, we can ask how many genes are signicant with a false discovery rate of 5%:
#table ( dxr1$padj < 0.05 )

#From this object, we can ask how many genes are signicant with a false discovery rate of 1%:
table ( dxr1$padj < 0.01 )

# ask how many genes are aected (FDR 0.001)
table ( tapply( dxr1$padj < 0.001, dxr1$groupID, any ) )


plotMA(dxr1, cex=0.8)



####################################################################################################################################################################################
4) visualization
# put in the appropriate gene name of interest!!!!!!!

#plotDEXSeq( dxr1, "FBgn0010909", legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

plotDEXSeq( dxr1, "1005", legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

#another

# put in the appropriate gene name of interest!!!!!!!

#plotDEXSeq( dxr2, "FBgn0010909", displayTranscripts=TRUE, legend=TRUE,cex.axis=1.2, cex=1.3, lwd=2 )

plotDEXSeq( dxr1, "1005", displayTranscripts=TRUE, legend=TRUE,cex.axis=1.2, cex=1.3, lwd=2 )

# to display it with the normalised counts.


#plotDEXSeq( dxr2, "FBgn0010909", expression=FALSE, norCounts=TRUE,legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2)


#plotDEXSeq( dxr2, "FBgn0010909", expression=FALSE, splicing=TRUE,legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

plotDEXSeq( dxr2, "1005", expression=FALSE, splicing=TRUE,legend=TRUE, cex.axis=1.2, cex=1.3, lwd=2 )

# WRITE TO BROWSEABLE HTML USING DEXSeqHTML


#DEXSeqHTML( dxr2, FDR=0.1, color=c("#FF000080", "#0000FF80") 
#colour command doesnt work!!!

#DEXSeqHTML( dxr1, FDR=0.001, color=c("#FF000080", "#0000FF80") 

DEXSeqHTML( dxr1, FDR=0.01)

#DEXSeqHTML( dxr1, FDR=0.001)









