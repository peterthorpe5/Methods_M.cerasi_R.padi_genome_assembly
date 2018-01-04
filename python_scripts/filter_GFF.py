#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute,Dundee,UK.
# Title:
# script to reduce redundancy in GFF file. Used in intron boundries work

# imports
import os
import sys
from sys import stdin,argv
import sys
import datetime
from optparse import OptionParser

def parse_GFF(gff):
    in_file = open(gff, "r")
    prefix = gff.split(".")[0]
    donor = prefix + "donor.fasta"
    donor = open(donor, "w")
    acceptor = prefix + "acceptor.fasta"
    acceptor = open(acceptor, "w")
    for line in in_file:
        if line.startswith("#"):
            continue
        if not line.strip():
            continue # if the last line is blank
        data = line.split("\t")
        name = data[4]
        name = name.replace(";", "")
        donor_seq = data[8]
        accept_seq = data[9]
        donor_out = ">%s\n%s\n" % (name, donor_seq.rstrip())
        donor.write(donor_out)
        accp_out = ">%s\n%s\n" % (name, accept_seq.rstrip())
        acceptor.write(accp_out)
    in_file.close()
    donor.close()
    acceptor.close()


###########################################################################
if "-v" in sys.argv or "--version" in sys.argv:
    print ("v0.0.1")
    sys.exit(0)


usage = """Use as follows:
python filter_GFF.py -gff name.gff

"""

parser = OptionParser(usage=usage)

parser.add_option("-g", "--gff",
                  dest="gff",
                  default=None,
                  help="gff file of interet",
                  metavar="FILE")

(options, args) = parser.parse_args()
gff = options.gff
#run the program
# Run as script
if __name__ == '__main__':
    if not os.path.isfile(gff):
        print("sorry, couldn't open the file: " + ex.strerror + "\n")
        print ("current working directory is :", os.getcwd() + "\n")
        print ("files are :", [f for f in os.listdir('.')])
        sys_exit("\n\nInput blast file not found: %s" % gff)
    # call the top function
    parse_GFF(gff)


