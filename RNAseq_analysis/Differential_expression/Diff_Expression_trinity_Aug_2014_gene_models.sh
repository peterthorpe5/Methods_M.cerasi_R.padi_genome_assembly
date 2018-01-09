#!/bin/bash
#Abort on any error,
set -e

cd PATH_TO/De_analysis/

PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix *genes.counts.matrix --samples_file samples_described.txt --method edgeR --output genes_DE_analysis
wait 


wait 


PATH_TO/trinityrnaseq_r20131110/Analysis/DifferentialExpression/run_TMM_normalization_write_FPKM_matrix.pl --matrix *.genes.counts.matrix --lengths genes_feature_lengths.txt



##################################################################################################################################

cd PATH_TO/De_analysis/genes_DE_analysis

PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.genes.counts.matrix.TMM_normalized.FPKM -P 1e-2 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.genes.counts.matrix.TMM_normalized.FPKM -P 1e-3 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.genes.counts.matrix.TMM_normalized.FPKM -P 1e-4 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.genes.counts.matrix.TMM_normalized.FPKM -P 1e-5 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt

wait 



#################################################
PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_40.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_40
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_50.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_50
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_60.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_60
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_70.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_70
 
wait 



############################################
PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_40.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_40
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_50.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_50
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_60.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_60
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_70.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_70
wait 


###########################################

PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_40.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_40
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_50.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_50
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_60.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_60
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv *_P_70.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_70
wait 



##########################################################
PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-5_C2.matrix.RData

wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_40.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_40

PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_50.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_50
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_60.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_60
wait 


PATH_TO/trinityrnaseq_r20140717/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv PATH_TO/De_analysis/genes_DE_analysis/*_P_70.heatmap.heatmap.pdf PATH_TO/De_analysis/genes_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_70
wait 


##################################################################
