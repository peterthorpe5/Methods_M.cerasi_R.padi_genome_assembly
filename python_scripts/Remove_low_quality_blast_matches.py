#!/usr/bin/env python
# author: Peter Thorpe September 2013. The James Hutton Insitute, Dundee, UK.

##############################################################################
# Title: reduces blast tab output based on thrshold, evalue or bit score.
###############################################################################

"""take in an abc file. and reduces the file based on set thresholds"""
import os
import sys
from sys import stdin,argv

usage = """

python name.py blast_tab_file, outfile, threshold

take in an abc file. and reduces the file based on set thresholds

"""

print usage

###############################################################################
# function
###############################################################################

def filter_file(blast_tab_file, outfile, threshold):
    """this is a look through abc file and removes
    low quality blast matches."""
    f_out = open(outfile, 'w')
    blast_tab_file = open(blast_tab_file, 'r')
    threshold = float(threshold)
    for line in blast_tab_file:
        hit = line.rstrip("\n")
        hit_to_string = str(hit)
        hit_string_split = hit_to_string.rstrip("\n").split('\t')
        col1 = hit_string_split[0]
        col2 = hit_string_split[1]
        col3 = hit_string_split[2]
	col3_float = float(col3)
        if col3_float <= threshold:
            print >> f_out, "%s\t%s\t%s" %(col1,col2,col3)
    f_out.close()

if __name__ == '__main__':
    # blast_tab_file, outfile, threshold
    filter_file (argv[1], argv[2], argv[3])

