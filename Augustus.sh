#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd /PATH_TO/


tophat --num-threads 8 mc.final_index /PATH_TO/RNAseq_data/Mc_R1_paired.fq.gz /PATH_TO/RNAseq_data/Mc_R2_paired.fq.gz

cd ./tophat_out
samtools mpileup accepted_hits.bam | perl -ne 'BEGIN{print "track type=wiggle_0 name=fileName description=fileName\n"};($c, $start, undef, $depth) = split; if ($c ne $lastC) { print "variableStep chrom=$c\n"; };$lastC=$c;next unless $. % 10 ==0;print "$start\t$depth\n" unless $depth<3;'  > fileName.wig
wait
cat *.wig | wig2hints.pl --width=10 --margin=10 --minthresh=2 --minscore=4 --src=W --type=ep --radius=4.5 > ../hints.rnaseq.ep.gff
wait
cd ..

# generate v0.9 gene calls
augustus --genemodel=complete --protein=on --start=on --stop=on --cds=on --introns=on --gff3=on --extrinsicCfgFile=/PATH_TO/extrinsic.bug.cfg --hintsfile=hints.rnaseq.ep.gff --outfile=Mcerasi_pea_aphid_RNASEQ001.gff --noInFrameStop=true --strand=both --species=pea_aphid /PATH_TO/mc.final.fasta