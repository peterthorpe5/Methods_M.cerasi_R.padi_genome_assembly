#!/usr/bin/env python
# author: Peter Thorpe September 2015. The James Hutton Insitute, Dundee, UK.
# script to convert genbank to fasta

from Bio import SeqIO
import os
from sys import stdin,argv
import sys
from optparse import OptionParser

def convert_file(in_file, out_file):
    """function to convert genbank to fasta"""
    sequences = SeqIO.parse(in_file, "genbank")
    g = open(out_file, "w")
    SeqIO.write(sequences, out_file, "fasta")

def rename(in_file, prefix, out_file):
    """function to reformat the names"""
    for seq_record in SeqIO.parse(in_file, "fasta"):
        seq_record.id = in_file.replace("BUSCOa", prefix + "_").split(".")[0]
        seq_record.description = ""
        SeqIO.write(seq_record, out_file, "fasta")

usage = """Use as follows:

converts

$ python ...py -p Mc

script to walk through all files in a folder convert them from genbank
to fasta and renames the seq id usin ght eprefix provided. 
to start with Prefix.


"""

parser = OptionParser(usage=usage)

parser.add_option("-p", "--prefix",
                  dest="prefix",
                  default=None,
                  help="Output filename",
                  metavar="FILE")
(options, args) = parser.parse_args()

prefix = options.prefix

# Run as script
if __name__ == '__main__':
    # walk through all the files in the folder
    for filename in os.listdir("."):
        if not filename.endswith(".gb") : continue
        print filename
        try:
            convert_file(filename, filename.split(".gb")[0] + ".temp")
        except:
            ValueError

    # walk through all the files in the folder
    for filename in os.listdir("."):
        if not filename.endswith(".temp") : continue
        rename(filename, prefix, filename.split(".temp")[0] + ".nt.fas")




