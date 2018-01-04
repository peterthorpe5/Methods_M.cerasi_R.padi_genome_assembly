#!/usr/bin/env python
# author: Peter Thorpe September 2015. The James Hutton Insitute, Dundee, UK.
# title return single copy busco genes


from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
import os
from sys import stdin,argv
import sys
from optparse import OptionParser

########################################################################
# functions
def index_sequences(protein_file):
    """function to index the AA files
    so we can get the seq later"""
    protein_sequences =  SeqIO.index(protein_file, "fasta")
    return protein_sequences

def parse_busco_file(fasta, prefix, busco):
    """this is a function to open busco full ouput
    and only return seq which were single copy.
    Print each to new file. """
    #c all function to idex AA file
    protein_sequences = index_sequences(fasta)
    with open(busco) as handle:
        for line in handle:
            if not line.strip():
                continue # if the last line is blank
            if line.startswith("#"):
                continue
            if not line:
                print ("your file is empty")
                return False
            l ine_info = line.rstrip().split("\t")
            #first element
            Busco_name = line_info[0]
            # second element
            status = line_info[1]
            # third element
            gene = line_info[2]
            if status == "Complete":
                out_name = prefix + "_" + Busco_name.replace("BUSCOa", "") + ".fasta"
                f_out = open(out_name, "w")
                seq_record = protein_sequences[gene]
                seq_record.id = str(seq_record.id)
                seq_record.id = prefix + "_" + Busco_name.replace("BUSCOa", "")
                seq_record.description = ""
                SeqIO.write(seq_record, f_out, "fasta")
                f_out.close()
                
if "-v" in sys.argv or "--version" in sys.argv:
    print "v0.0.1"
    sys.exit(0)


usage = """Use as follows:

converts

$ python renaem....py -f Mce.AA.fasta -p Mce -b full_table_BUSCO_output

opens up the busco table and return the single copy genes. 

Used for Busco output.

give it the busco full ouput table. The script will only return
complete single copy gene. Duplicate gene will be ignored.

"""

parser = OptionParser(usage=usage)

parser.add_option("-f", "--fasta", dest="fasta",
                  default=None,
                  help="Amino acid file used for BUSCO predictions",
                  metavar="FILE")
parser.add_option("-p", "--prefix", dest="prefix",
                  default=None,
                  help="Output filename",
                  metavar="FILE")
parser.add_option("-b", "--busco", dest="busco",
                  default=None,
                  help="full_table_*_BUSCO output from BUSCO",
                  metavar="FILE")



(options, args) = parser.parse_args()
fasta = options.fasta
prefix = options.prefix
busco = options.busco

if __name__ == '__main__':
    #call function to get a list of dupicated gene.
    #these genes will be ignored
    parse_busco_file(fasta, prefix, busco)


    
        
      




