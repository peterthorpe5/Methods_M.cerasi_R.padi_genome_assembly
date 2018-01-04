#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute, Dundee, UK.

# imports
import os
import sys
from optparse import OptionParser
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

# Title: get_NNN_content of a file

def get_NNN_content(dna_file):
    """function to  NNN content 
    """
    total_NNN = 0
    total = 0
    for seq_record in SeqIO.parse(dna_file, "fasta"):
        sequence = str(seq_record.seq)
        total_NNN = total_NNN + sequence.count('N')
        total = total + len(seq_record.seq)
    print("\n%s\tTOTAL_BASES = %d\tN_count = %d\n" % (dna_file,
                                                  total,
                                                  total_NNN))
    print("percentage of bases as NNN = %.2f\n" % ((total_NNN/(float(total)))*100))
                                                    

###################################################################
if "-v" in sys.argv or "--version" in sys.argv:
    print "v0.0.1"
    sys.exit(0)

usage = """Use as follows:

$ python -i genes.fa -o results.out

"""

parser = OptionParser(usage=usage)
parser.add_option("--in", "-i",
                  dest="infile",
                  default=None,
                  help="nucleotide fasta file",
                  metavar="FILE")

(options, args) = parser.parse_args()
infile = options.infile

# Run as script
if __name__ == '__main__':
    get_NNN_content(infile)



