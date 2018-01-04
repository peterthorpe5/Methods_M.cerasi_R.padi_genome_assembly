#!/usr/bin/env python
# author: Peter Thorpe September 2014. The James Hutton Insitute, Dundee, UK.
# Title: script to get contigsnot wanted from a fasta file

import os
from sys import stdin,argv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO


def seq_getter(filename_in, wantedfile, outfile):
    """Funtion to get the wanted contigs from a given fasta file"""
    f = open(outfile, 'w')
    wanted = open(wantedfile, "r")
    threshold = int(3)
    names = wanted.readlines()
    wanted_data = [line.replace("\t", "").rstrip("\n") for line in names
              if line.strip() != ""]
    name_set = set([])
    for i in wanted_data:
        if not i.startswith("#"):
            name_set.add(i)
    for seq_record in SeqIO.parse(filename_in, "fasta"):
        if seq_record.id in name_set:
            if len(seq_record.seq)> threshold:
                SeqIO.write(seq_record, f, "fasta")
        
    f.close()


if __name__ == '__main__':
    # in.fasta, wanted_names, out.fasta
    seq_getter(argv[1],argv[2], argv[3])



