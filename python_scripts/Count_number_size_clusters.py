#!/usr/bin/env python
# author: Peter Thorpe September 2014. The James Hutton Insitute, Dundee, UK.
# Title:script to open up a tab MCL output and count the length of the line.
# The amount of sequences in each cluster.
# imports
import os

file_name = 'test.txt'
script_dir = os.path.dirname(os.path.abspath(__file__))
dest_dir = os.path.join(script_dir, 'cluster_sizes', 'total_info')
try:
    os.makedirs(dest_dir)
except OSError:
    print "already exists"

#######################################################################
def parse_tab_file_get_clusters():
    """#script to open up a tab MCL output and count the length of the line.
    The
    # amount of seuqnces in each cluster"""
    for_graph_file = open ("./cluster_sizes/graph.out", "w")
    print >> for_graph_file, "evalue\ttotal_num_clusters\tcluster>2\tsingletons"
    for filename in os.listdir("."):
        if filename.endswith("abc_seq.mci"):
            filename_chopped = filename[:-12]
            evalue_str = "1" + filename_chopped[-4:]
            evalue = float(evalue_str)
            #print >> for_graph_file, evalue
            #file to write to
            filename_write_out = "./cluster_sizes/total_info/%s_sizes.out" % (filename_chopped)
            out_file = open(filename_write_out,"w")
            print >> out_file,"#%s\n#length of clusters" % (filename_chopped)
            MCL_file = open(filename, "r")
            # parse through the cluster file
            count = int(0)
            #this way we can work out the singletons
            count_cluster_size_greater_than_two = int(0)
            for line in MCL_file:
                MCL_cluster_line = line.rstrip("\n").split("\t")
                cluster_size= len(MCL_cluster_line)
                #print >> out_file, cluster_size
                count += 1
                if len(MCL_cluster_line) >= 2:
                    count_cluster_size_greater_than_two += 1
                print >> out_file, "cluster\t%d\tlength\t%d" %(count,
                                                               cluster_size)

            print >> out_file,"count_cluster_size_greater_than_two\t", count_cluster_size_greater_than_two
            print >> out_file,"total count\t", count
            singleton = count - count_cluster_size_greater_than_two
            print >> out_file,"singleton\t", singleton
            print >> for_graph_file, "%.100f\t%d\t%d\t%d" %(evalue,
                                                            count,
                                                            count_cluster_size_greater_than_two,
                                                            singleton)

            MCL_file.close()
   
# run the program
# Run as script
if __name__ == '__main__':
    parse_tab_file_get_clusters()
