#!/usr/bin/env python
# author: Peter Thorpe September 2015. The James Hutton Insitute, Dundee, UK.
# title rename single copy busco genes

from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
import os
from sys import stdin,argv
import sys
from optparse import OptionParser

########################################################################
# functions

def parse_busco_file(busco):
    """this is a function to open busco full ouput
    and get a list of duplicated genes. This list is required
    so we can ignore these genes later. Takes file,
    return list"""
    duplicated_list = []
    with open(busco) as handle:
        for line in handle:
            if not line.strip():
                continue # if the last line is blank
            if line.startswith("#"):
                continue
            if not line:
                print ("your file is empty")
                return False
            line_info = line.rstrip().split("\t")
            # first element
            Busco_name = line_info[0]
            # second element
            status = line_info[1]
            if status == "Duplicated" or status == "Fragmented":
                duplicated_list.append(Busco_name)
    return duplicated_list


def reformat_as_fasta(filename,prefix,outfile):
    "this function re-write a file as a fasta file"
    f= open(outfile, 'w')
    fas = open(filename, "r")
    for line in fas:
        if not line.strip():
            continue # if the last line is blank
        if line.startswith("#"):
            continue
        if not line:
            return False
        if not line.startswith(">"):
            seq = line

        title = ">" + prefix + "_" + filename.replace("BUSCOa", "").split(".fas")[0]
    data = "%s\n%s\n" %(title, seq)
    f.write(data)    
    f.close()

if "-v" in sys.argv or "--version" in sys.argv:
    print "v0.0.1"
    sys.exit(0)


usage = """Use as follows:

converts

$ python renaem....py -p Mce -b full_table_BUSCO_output

script to walk through all files in a folder and rename the seq id
to start with Prefix.

Used for Busco output.

give it the busco full ouput table. The script will only return
complete single copy gene. Duplicate gene will be ignored.

"""

parser = OptionParser(usage=usage)


parser.add_option("-p", "--prefix", dest="prefix",
                  default=None,
                  help="Output filename",
                  metavar="FILE")
parser.add_option("-b", "--busco", dest="busco",
                  default=None,
                  help="full_table_*_BUSCO output from BUSCO",
                  metavar="FILE")



(options, args) = parser.parse_args()

prefix = options.prefix
busco = options.busco

# Run as script
if __name__ == '__main__':
    #call function to get a list of dupicated gene.
    #these genes will be ignored
    duplicated_list = parse_busco_file(busco)

    #iterate through the dir 
    for filename in os.listdir("."):
        count = 1
        if not filename.endswith(".fas"):
            continue
        #filter out the ones we dont want
        if filename.split(".fa")[0] in duplicated_list:
            continue
        out_file = "../"+prefix+filename
        out_file = out_file.replace("BUSCOa", "")
        #out_file = "../"+filename
        try:
            #print filename
            reformat_as_fasta(filename, prefix, out_file)
        except:
            ValueError
            continue
    
        
      




