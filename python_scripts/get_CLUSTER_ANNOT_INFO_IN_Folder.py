import os
for filename in os.listdir("."):
    if filename.endswith(".fasta"):
        start= filename.split("_")[0]

handle_name = "%s_Cluster_catorgory_summary.out" %(start)
handle = open(handle_name,"w")
count = 0
for filename in os.listdir("."):
    if filename.endswith(".fasta"):
        count +=1
        name = filename[:-4]
        annotation_info_data = open(filename, "r")
        annotation_list = []
        for i,(line) in enumerate(annotation_info_data):
            if i <160:
                if line.startswith(">"):
                    annotation_info = line.rstrip().split("\t")[1:]
                    annotation_list.append(annotation_info)
        
        annotation_list_formatted3 = str(annotation_list)
        annotation_list_formatted2 = annotation_list_formatted3.replace("[", "")
        annotation_list_formatted1 = annotation_list_formatted2.replace("]","")
        annotation_list_formatted = annotation_list_formatted1.replace("'", "")
        handle.write("%s\t%s\n" % (name,annotation_list_formatted))
        #print name
        #print sequence
        
handle.write("\nCLUSTER CATERGORY SIZE = %d\n" % (count))
handle.close()
print "Done"
