#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute, Dundee, UK.
# Title: Report to totla exome size
# imports
import os
from sys import stdin,argv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

def exome_size(filename_in):
    "fnction to count total exome size"
    exome = 0
    for seq_record in SeqIO.parse(filename_in, "fasta"):
        exome = exome+len(seq_record.seq)
    print "exome = ", exome, "\n\n"

if __name__ == '__main__':
    exome_size(argv[1])



