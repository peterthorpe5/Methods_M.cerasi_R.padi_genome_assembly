#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute, Dundee, UK.

# imports
import os
import sys
from optparse import OptionParser
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

# Title: Get AT of genes in a file


def get_stats_on_AT_content(dna_file, out_file):
    """function to  AT content 
    all genes"""
    f_out = open(out_file, "w")
    f_out.write("#gene\tAT_content\n")
    for seq_record in SeqIO.parse(dna_file, "fasta"):
        seq_record.seq = seq_record.upper()
        sequence = str(seq_record.seq)
        a_count = sequence.count('A')
        t_count = sequence.count('T')
        # count AT content
        AT = a_count + t_count/float(len(seq_record.seq))
        outformat = "%s\t%.2f\n" % (seq_record.id, AT)
        f_out.write(outformat)
    f_out.close()
    return AT


###################################################################
if "-v" in sys.argv or "--version" in sys.argv:
    print "v0.0.1"
    sys.exit(0)


usage = """Use as follows:

$ python -i genes.fa -o results.out

Script to return the AT content of a given fasta file

"""

parser = OptionParser(usage=usage)
parser.add_option("--in", "-i",
                  dest="infile",
                  default=None,
                  help="nucleotide fasta file",
                  metavar="FILE")
parser.add_option("-o", "--out_file",
                  dest="out_file",
                  default="test_output.txt",
                  help="outfile name and AT content")

(options, args) = parser.parse_args()
infile = options.infile
out_file = options.out_file

# run the program
# Run as script
if __name__ == '__main__':
    get_stats_on_AT_content(infile, out_file)



