#!/usr/bin/env python
# author: Peter Thorpe September 2014. The James Hutton Insitute, Dundee, UK.
# Title: script to open up a tab MCL output and get the sequences for each
# cluster.
# This script is old and I do not recomemd this being used.

# imports
import os
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

file_name = 'test.txt'
script_dir = os.path.dirname(os.path.abspath(__file__))
dest_dir = os.path.join(script_dir, 'Bos2010')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Conserved')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"

try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'pea_saliva')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"


dest_dir = os.path.join(script_dir, 'All_clusters')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"

dest_dir = os.path.join(script_dir, 'Mass_spec')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Mcerasi_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Mp_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Myzus_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Pea_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'RNAseq_clusters', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Rpadi_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'Soybean_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"


dest_dir = os.path.join(script_dir, 'expression', 'Bos2010')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Conserved')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"


dest_dir = os.path.join(script_dir, 'expression', 'Mass_spec')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Mcerasi_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Mp_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Myzus_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Pea_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'RNAseq_clusters', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Rpadi_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
dest_dir = os.path.join(script_dir, 'expression', 'Soybean_only', 'no_NR_hit')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"
    

#######################################################################################

def get_names_of_interest(interesting_names):
    with open(interesting_names) as file:
        return file.read().split("\n")
    
Bos2010 = get_names_of_interest("$HOME/putative_lists/Bos2010.names")
#RNA_seq_full_list = get_names_of_interest ("$HOME/dn_ds_working/Clustering/RNA_seq_full_list.names")
#mass_spec_full_list = get_names_of_interest ("$HOME/dn_ds_working/Clustering/mass_spec_full_list.names")
#repeated using final gene models. 
RNA_seq_full_list = get_names_of_interest ("$HOME/putative_lists/RNAseq_effector.names")
mass_spec_full_list = get_names_of_interest ("$HOME/putative_lists/MS_All.names")
pea_saliva_names = get_names_of_interest ("$HOME/putative_lists/Pea_aphid_secreted_saliva.names")

#repeated GG

###########################################################################################




trinotate_database = open('$HOME/annotation/trinnotate/trinotate_annotat.out', 'r')

expression_database = open('$HOME/expression/expression_database.txt',"r")

description_file_data = open('$HOME/annotation/top_hit_database.out', 'r')

trinotate_database_dict = {}
##for line in trinotate_database:
##    if line.startswith("#"):
##        continue
##    database_file_line = line.rstrip("\n").split("\t")        
##    transcript = database_file_line[1]
##    trnasdecoder_protein = database_file_line[5]
##    trinotate_database_dict[trnasdecoder_protein] = transcript

expression_database_dic = {}
for line in expression_database:
    if not line.startswith("	"):
        if line.startswith("#"):
            continue
        expression_file_line = line.rstrip("\n").split("\t")
        #print expression_file_line
        transcript_expression = expression_file_line[0]
        #print "transcript = ", transcript_expression
        expression = expression_file_line[1:]
        #print expression
        expression_database_dic[transcript_expression] = expression    
#####################################################################################
#################### blast description file - assign to dictionary ##################

    
description_file_dic = {}
for line in description_file_data:
    if line.startswith("#"):
        continue
    description_file_line = line.rstrip("\n").split("\t")
    gene_id = description_file_line[0]
    data_formatted = "%s" %(description_file_line[1:])
    info = data_formatted
    description_file_dic[gene_id] = info
    #print "gene_id,",gene_id, info
    
trinotate_database.close()

expression_database.close()

description_file_data.close()
####################################################################################


def get_info(predicted_protein, description_file_dic, i):
    try:
        seq_record = predicted_protein[i]
    except:
        description= ""
        info = ""
        return info, description
    try:
        description = description_file_dic[i]
        #print seq_record.description
        #print "yes"
        data_formatted = description
        data_formatted_2 =data_formatted.replace("[", "")
        data_formatted_3 =data_formatted_2.replace("]", "")
        data_formatted_4 =data_formatted_3.replace("'", "")
        #seq_record.description = data_formatted_4
        name = seq_record.id.split("	")[0]
        info = ">%s\t%s\n%s" %(name,data_formatted_4.replace(",", "\t"), seq_record.seq)
        #print info
        #print data_formatted_4
        return info, data_formatted_4
    except:
        name = seq_record.id.split("	")[0]
        description = seq_record.description
        info = ">%s\t%s\n%s" %(name,seq_record.description, seq_record.seq)
        return info, description
        

def try_get_seq_record(predicted_protein, i):
    try:
        seq_record = predicted_protein[i]
    except:
        return ""
       
    return seq_record


def parse_tab_file_get_clusters(fasta_filename,filename1, muscle_out, outfile):
    """#script to open up a tab MCL output and count the length of the line. The
    # amount of seuqnces in each cluster"""
    #f= open(outfile, 'w')
    #open files, read and write.
    MCL_file = open (filename1, "r")
    out_file = open(outfile,"w")
    #description_file_data = open(description_file,"r")
    predicted_protein =  SeqIO.index(fasta_filename, "fasta")
    muscle_name_out= open(muscle_out,"w")
   
    ##########################################################
    ################ parse through the cluster file ##########
    count = int(0)
    for line in MCL_file:
        MCL_cluster_line = line.rstrip("\n").split("\t")
        cluster_size=len(MCL_cluster_line)
        print >> out_file, cluster_size
        count +=1
        #print MCL_cluster_line
        #print count
        #record = SeqIO.read(filename, "fasta")
        names_list = "mass_spec RNAseq Mp_only Myzus Rpadi_only Mcerasi_only Soybean_only Pea_only Conserved".split(" ")
        #for i in names_list:

        filename_mass_spec = "./Mass_spec/mass_spec_cluster_%d_len_%d.fasta" %(count,cluster_size)
	filename_mass_spec_expression = "./expression/Mass_spec/mass_spec_cluster_expression_%d_len_%d.txt" %(count,cluster_size)
	
	filename_all_clusters = "./All_clusters/All_clusters_%d_len_%d.txt" %(count,cluster_size)

        #f_mass_spec= open(filename_mass_spec, 'w')

        filename_RNAseq = "./RNAseq_clusters/RNAseq_cluster_%d_len_%d.fasta" %(count,cluster_size)
	filename_RNAseq_expression = "./expression/RNAseq_clusters/RNAseq_cluster_expression_%d_len_%d.txt" %(count,cluster_size)

	filename_pea_saliva = "./pea_saliva/pea_saliva_cluster_%d_len_%d.fasta" %(count,cluster_size)

        #f_RNAseq= open(filename_mass_spec, 'w')

        filename_Mp_only = "./Mp_only/Mp_only_cluster_%d_len_%d.fasta" %(count,cluster_size)
	filename_Mp_only_expresion = "./expression/Mp_only/Mp_only_cluster_%d_len_%d.txt" %(count,cluster_size)

        filename_Mp_only_no_NR_hit = "./Mp_only/no_NR_hit/Mp_only_cluster_expression_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_Myzus = "./Myzus_only/Myzus_cluster_%d_len_%d.fasta" %(count,cluster_size)
	filename_Myzus_expression = "./expression/Myzus_only/Myzus_cluster_expression_%d_len_%d.txt" %(count,cluster_size)

        filename_Myzus_no_NR_hit = "./Myzus_only/no_NR_hit/Myzus_cluster_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_Rpadi_only = "./Rpadi_only/Rpadi_cluster_%d_len_%d.txt" %(count,cluster_size)
	filename_Rpadi_only_expresion = "./expression/Rpadi_only/Rpadi_cluster_expression_%d_len_%d.txt" %(count,cluster_size)

        filename_Rpadi_only_no_NR_hit = "./Rpadi_only/no_NR_hit/Rpadi_cluster_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_Mcerasi_only = "./Mcerasi_only/Mcerasi_cluster_%d_len_%d.txt" %(count,cluster_size)
	filename_Mcerasi_only_expression = "./expression/Mcerasi_only/Mcerasi_cluster_expression_%d_len_%d.txt" %(count,cluster_size)

        filename_Mcerasi_only_no_NR_hit = "./Mcerasi_only/no_NR_hit/Mcerasi_cluster_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_Soybean_only = "./Soybean_only/Soybean_cluster_%d_len_%d.txt" %(count,cluster_size)
        filename_Soybean_only_no_NR_hit = "./Soybean_only/no_NR_hit/Soybean_cluster_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_Pea_only = "./Pea_only/Pea_cluster_%d_len_%d.fasta" %(count,cluster_size)
        filename_Pea_only_no_NR_hit = "./Pea_only/no_NR_hit/Pea_cluster_%d_len_%d_no_blast_vs_NR.fasta" %(count,cluster_size)

        filename_in_conserved = "./Conserved/Conserved_cluster_%d_len_%d.fasta" %(count,cluster_size)
	filename_in_conserved_expression = "./expression/Conserved/Conserved_cluster_expression_%d_len_%d.txt" %(count,cluster_size)


        #f_Myzus= open(filename_Myzus, 'w')

        filename_Bos2010 = "./Bos2010/Bos2010_cluster_%d_len_%d.fasta" %(count,cluster_size)
        filename_Bos2010_expression = "./expression/Bos2010/Bos2010_cluster_expression_%d_len_%d.txt" %(count,cluster_size)

        #f_Myzus= open(filename_Myzus, 'w')

        
    ##################################################################################
    ################ counting for assignment #########################################

        
        Mp_count = 0
        Mp_info =[]
        Mp_description_count=0

        Mcerasi_count = 0
        Mcerasi_info=[]
        Mcerasi_description_count=0

        pea_saliva_count = 0
        #pea_saliva
        pea_saliva_set = set([])
        
        Myzus_count = 0
        Myzus_info=[]
        Myzus_description_count=0
		
	All_clusters_count = 0
        All_clusters_info=[]
        All_clusters_count=0

        Rpadi_count = 0
        Rpadi_info=[]
        Rpadi_description_count=0
        
        Pea_soy_dro = 0

        Mass_spec_count = 0
        Mass_spec_cluster=[]
        Mass_spec_cluster_line=[]
        Mass_spec_cluster_set = set([])

        Pea_count = 0
        Pea_info=[]
        Pea_description_count=0

        Soybean_count = 0
        Soybean_info=[]
        Soybean_description_count=0

        RNAseq_count = 0
        RNAseq_cluster_set =set([])

        Bos2010_count = 0
        Bos2010_set=set([])

        multi_specied_count = 0
		
        filename_all_cluster = open(filename_all_clusters, 'w')


    #############################################################################################################
    ################ logic loops to see what the cluster line contains ################################################################

        for i in MCL_cluster_line:
	    All_clusters_count +=1
            #######################################All_clusters_info=[]
            All_clusters_count+=1
            seq_record = predicted_protein[i]
            try:
                description = description_file_dic[i]
                seq_record.description=description_file_dic[i]
            except:
                seq_record.description=""
            data_formatted = seq_record.description
            data_formatted_2 =data_formatted.replace("[", "")
            data_formatted_3 =data_formatted_2.replace("]", "")
            data_formatted_4 =data_formatted_3.replace("'", "")
            seq_record.description = data_formatted_4
            info = ">%s\t%s\n%s" %(seq_record.id,seq_record.description, seq_record.seq)
                
            All_clusters_info.append(info)
                    #for i in All_clusters_info:
            #filename_all_cluster = open(filename_all_clusters, 'w')
            print >> filename_all_cluster, "%s" %(info)
			
            #mp names
            if i.startswith("Mpe"):
                seq_record = try_get_seq_record(predicted_protein, i)
                Mp_count+=1
                info, description = get_info(predicted_protein, description_file_dic, i)                    
                Mp_info.append(info)


            #Mcerasi names
            if i.startswith("Mce"):
                Mcerasi_count+=1
                seq_record = try_get_seq_record(predicted_protein, i)
                info,description = get_info(predicted_protein, description_file_dic, i)
                Mcerasi_info.append(info)
                if len(description) >0:
                    Mcerasi_description_count+=1
                
            #myzus names
            if i.startswith("Mpe") or i.startswith("Mce") or i.startswith("Mp"):
                seq_record = try_get_seq_record(predicted_protein, i)
                Myzus_count+=1
                info,description = get_info(predicted_protein, description_file_dic, i)
                Myzus_info.append(info)
                if len(description) >0:
                    Myzus_description_count+=1

            #Rpadi
            if i.startswith("Rpa"):
                seq_record = try_get_seq_record(predicted_protein, i)
                Rpadi_count+=1
                info,description = get_info(predicted_protein, description_file_dic, i)
                if len(description) >0:
                    Rpadi_description_count+=1
                    
                Rpadi_info.append(info)

            #pea aphid
            if i.startswith("Api"):
                seq_record = try_get_seq_record(predicted_protein, i)
                Pea_count+=1
                seq_record = predicted_protein[i]
                seq_record = predicted_protein[i]
                info, description = get_info(predicted_protein, description_file_dic, i)
                if len(description) >0:
                    Pea_description_count+=1
                    
                Pea_info.append(info)


            # soybean

            if i.startswith("cds.S"):
                Soybean_count+=1
                seq_record = try_get_seq_record(predicted_protein, i)
                info, description = get_info(predicted_protein, description_file_dic, i)
                if len(description) >0:
                    Soybean_description_count+=1
                    
                Soybean_info.append(info)
                
            #bos 2010 names
            if i.startswith("Mp") and not i.startswith("Mpe"):
                Mp_count+=1
                seq_record = try_get_seq_record(predicted_protein, i)
                info, description = get_info(predicted_protein, description_file_dic, i)
                Mp_info.append(info)

            if i in Bos2010:
                Bos2010_count+=1
                for i in MCL_cluster_line:
                    seq_record = try_get_seq_record(predicted_protein, i)
                    info, description = get_info(predicted_protein, description_file_dic, i)
                    Bos2010_set.add(info)
                    
            #if in pea aphid saliva

            if i in pea_saliva_names:
                pea_saliva_count+=1
                for i in MCL_cluster_line:
                    seq_record = try_get_seq_record(predicted_protein, i)
                    info, description = get_info(predicted_protein, description_file_dic, i)
                    pea_saliva_set.add(info)
                
            #if startswith other names                
            if i.startswith("ACY") or i.startswith("cds.Soy"):
                Pea_soy_dro+=1
                
            #if in mass spec identified
            if i in mass_spec_full_list:
                Mass_spec_count+=1

                Mass_spec_cluster_line.append(MCL_cluster_line)
                for i in MCL_cluster_line:
                    seq_record = try_get_seq_record(predicted_protein, i)
                    info, description = get_info(predicted_protein, description_file_dic, i)
                    Mass_spec_cluster_set.add(info)

            # if in Rnaseq list
            if i in RNA_seq_full_list:
                RNAseq_count+=1
                for i in MCL_cluster_line:
                    seq_record = try_get_seq_record(predicted_protein, i)
                    info, description = get_info(predicted_protein, description_file_dic, i)
                    RNAseq_cluster_set.add(info)
                
################################################################################################################
#################### write the results to files ################################################################
                    ################################################################################################################
#################### write the results to files ################################################################
                    ################################################################################################################
#################### write the results to files ################################################################

        #open up a Mp only logic loop
        if Mp_count >0 and Pea_soy_dro ==0 and Mcerasi_count==0:
            #open up the file to write to
            f_Mp_only= open(filename_Mp_only, 'w')
            filename_Mp_only_expresion= open(filename_Mp_only_expresion, 'w')
            print >> filename_Mp_only_expresion,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"
            for i in Mp_info:
                print >> f_Mp_only, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_Mp_only_expresion, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                     y = "w"
                    
                
            #print "Mp_description_count: ", Mp_description_count
            if Mp_description_count < 1:
                #print "after if: ", Mp_description_count, "\n"
                filename_Mp_only_no_NR = open(filename_Mp_only_no_NR_hit, 'w')
                for j in Mp_info:
                    print >> filename_Mp_only_no_NR, "%s" %(j)


        #open up a loop for Rpadi - specific
        if Rpadi_count >0 and Pea_soy_dro ==0 and Mcerasi_count==0 and Mp_count ==0:
            #open up the file to write to
            f_Rpadi_only= open(filename_Rpadi_only, 'w')
            filename_Rpadi_only_expresion= open(filename_Rpadi_only_expresion, 'w')
            print >> filename_Rpadi_only_expresion,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in Rpadi_info:
                print >> f_Rpadi_only, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_Rpadi_only_expresion, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                     y = "w"

            #print "Rpadi_description_count: ", Rpadi_description_count
            if Rpadi_description_count < 1:
                #print "after if: ", Rpadi_description_count, "\n"
                filename_Rpadi_only_no_NR = open(filename_Rpadi_only_no_NR_hit, 'w')
                for j in Rpadi_info:
                    print >> filename_Rpadi_only_no_NR, "%s" %(j)

        # loop for soy bean aphid
        if Soybean_count >0 and Pea_count ==0 and Mcerasi_count==0 and Mp_count ==0 and Rpadi_count==0:
            #open up the file to write to
            f_Soybean_only= open(filename_Soybean_only, 'w')
            for i in Soybean_info:
                print >> f_Soybean_only, "%s" %(i)
            #print "Soybean_description_count: ", Soybean_description_count
            if Soybean_description_count < 1:
                #print "after if: ", Soybean_description_count, "\n"
                filename_Soybean_only_no_NR = open(filename_Soybean_only_no_NR_hit, 'w')
                for j in Soybean_info:
                    print >> filename_Soybean_only_no_NR, "%s" %(j)
                    

        #loop for pea aphid
        if Pea_count >0 and Mcerasi_count==0 and Mp_count ==0 and Rpadi_count==0:
            #open up the file to write to
            f_Pea_only= open(filename_Pea_only, 'w')
            for i in Pea_info:
                print >> f_Pea_only, "%s" %(i)
            #print "Pea_description_count: ", Pea_description_count
            if Pea_description_count < 1:
                #print "after if: ", Pea_description_count, "\n"
                filename_Pea_only_no_NR = open(filename_Pea_only_no_NR_hit, 'w')
                for j in Pea_info:
                    print >> filename_Pea_only_no_NR, "%s" %(j)
                    

        #open up a loop for Mcerasi - specific
        if Mcerasi_count >0 and Pea_soy_dro ==0 and Mp_count ==0 and Rpadi_count==0:
            #open up the file to write to
            #print "Mcerasi only cluster"
            f_Mcerasi_only= open(filename_Mcerasi_only, 'w')
            filename_Mcerasi_only_expression= open(filename_Mcerasi_only_expression, 'w')
            print >> filename_Mcerasi_only_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in Mcerasi_info:
                print >> f_Mcerasi_only, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_Mcerasi_only_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                    y = "w"
                    
            #print "Mcerasi_description_count: ", Mcerasi_description_count
            if Mcerasi_description_count < 1:
                #print "after if: ", Mcerasi_description_count, "\n"
                filename_Mcerasi_only_no_NR = open(filename_Mcerasi_only_no_NR_hit, 'w')
                for j in Mcerasi_info:
                    print >> filename_Mcerasi_only_no_NR, "%s" %(j)
                

##############################################################################                
        #open up a Myzus only logic loop
        if Mcerasi_count >0 and Pea_soy_dro ==0 and Mp_count >0:
            #open up the file to write to
            f_Myzus= open(filename_Myzus, 'w')
            filename_Myzus_expression= open(filename_Myzus_expression, 'w')
            print >> filename_Myzus_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in Myzus_info:
                print >> f_Myzus, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_Myzus_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                    y = "w"  

            if Myzus_description_count < 1:
                filename_Myzus_no_NR = open(filename_Myzus_no_NR_hit, 'w')
                for j in Myzus_info:
                    print >> filename_Myzus_no_NR, "%s" %(j)

                
        #open up a mass spec cluster
        if Mass_spec_count > 0:
            f_mass_spec= open(filename_mass_spec, 'w')
            filename_mass_spec_expression= open(filename_mass_spec_expression, 'w')
            print >> filename_mass_spec_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in Mass_spec_cluster_set:
                print >> f_mass_spec, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print "data name = ", data_name
                    #print "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                    #print corresponding_transcript_name, expresion
                    print >> filename_mass_spec_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                    y = "w"                   


#############################################################################################################
                        
#############################################################################################################
        #
        #open up a pea_aphid_saliva cluster
        if pea_saliva_count > 0:
            filename_pea_sal= open(filename_pea_saliva, 'w')


            for i in pea_saliva_set:
                print >> filename_pea_sal, "%s" %(i)
                

      
        #open up a RNAseq cluster
        if RNAseq_count > 0:
            f_RNAseq= open(filename_RNAseq, 'w')
            filename_RNAseq_expression= open(filename_RNAseq_expression, 'w')
            print >> filename_RNAseq_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in RNAseq_cluster_set:
                print >> f_RNAseq, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_RNAseq_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                    y = "w"

                #open up a RNAseq cluster
        if Bos2010_count > 0:
            Bos = open(filename_Bos2010, 'w')
            filename_Bos2010_expression = open(filename_Bos2010_expression, 'w')
            print >> filename_Bos2010_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"


            for i in Bos2010_set:
                print >> Bos, "%s" %(i)
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_Bos2010_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                     y = "w"

            
        # use some logic flow to identify clusters with lots of species.

        if Mcerasi_count >0 :
            #print "Mc"
            multi_specied_count+=1
        if Pea_soy_dro>0:
            #print "Pea"
            multi_specied_count+=1
        if Mp_count>0:
            #print "Mp"
            multi_specied_count+=1
        if Rpadi_count:
            multi_specied_count+=1

        #print "multi_specied_count: ", multi_specied_count
        if multi_specied_count >= 3:
            conserved = open(filename_in_conserved,"w")
            filename_in_conserved_expression = open(filename_in_conserved_expression,"w")
            print >> filename_in_conserved_expression,"\tbody1\tbody2\tbody3\thead1\thead2\thead3"

            for i in MCL_cluster_line:
                seq_record = try_get_seq_record(predicted_protein, i)
                info, description = get_info(predicted_protein, description_file_dic, i)
                print >> conserved, "%s" %(info)
                # to get the expression
                data = i.split("\t")[0]
                data_name = data[1:]
		try:
                    expresion = expression_database_dic[data_name]
                    #print corresponding_transcript_name, expresion
                    print >> filename_in_conserved_expression, "%s\t%s\t%s\t%s\t%s\t%s\t%s" %(data_name, expresion[0],expresion[1],expresion[2],expresion[3],expresion[4],expresion[5])
                except:
                     pass
      
##            SeqIO.write(seq_record, f, "fasta")
                
            #print Genus_names
    #muscle_name_out.close()
    MCL_file.close()
    return True
        

#############################################################################

# Run as script
if __name__ == '__main__':
    parse_tab_file_get_clusters('../putative_lists/all_genes.fa',
                                'all_results_eval_1e-31.abc_seq.mci',
                                'muscle.out',
                                'secreted_heads_out.seq.mci.I60_length_of_lines.txt')

