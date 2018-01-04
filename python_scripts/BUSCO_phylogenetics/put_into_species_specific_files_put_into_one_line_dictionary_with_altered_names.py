#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute, Dundee, UK.
# Title: put all the individual alignmnet files into one line sequence.
# imports
import os
import sys
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
from Bio import SeqIO


def get_other_insect_names():
    """ this is not actually needed!"""
    # this is a file containing all the species of insects in the
    # paper for insect phylogeny
    with open("$HOME/Aphid_phylogenetics/For_insect_tree_names.txt") as handle:
        return handle.read().strip().split("\n")

def extract_species_name(text):
    "this function slits up the names to retunr the species name"
    #bad list of some oditiny in their names
    bad_list = """
NVITR
AMELI
APISU
TCAST
AECHI
ZNEVA
DPULE
AGAMB
DMELA
ISCAP
PHUMA
BMORI
""".split("\n")
    #are they transdecoder predicted
    if text.startswith("cds.Mp"):
        species_names = text[4:8]
        
    elif text.startswith("cds."):
        species_names = text.split("_")[0][4:]
    
        #print species_names
    #pea aphid
    elif text.startswith("ACY"):
        species_names = "Acyrthosiphon_pisum"

    else:
        species_names = text
        #raise ValueError ("species name not found %s" % text) 
        
    #print text,"\t", species_names
    assert species_names, "Turned %s into empty string?" % text
    return species_names

assert extract_species_name("ACYPI009761-PA") == "Acyrthosiphon_pisum"
assert extract_species_name("cds.Mcerasi_40008_c0_seq1|m.87062") == "Mcerasi"
assert extract_species_name("cds.Mp_F_28895_c0_seq2|m.43737") == "Mp_F"
assert extract_species_name("cds.Soybean_aphid_8762_c0_seq1|m.17597") == "Soybean"



# this is for a massive insect tree
#insect_names = get_other_insect_names()
#insect_names.extend(["Mcerasi", "Mp_O", "Mp_J", "Rpadi", "Mp_F", "Soybean"])
insect_name_dictionary = {}
#for i in insect_names:
    #insect_name_dictionary[i] = ""  # sequence
insect_names = ["Dn", "Mc", "Rp", "DMEL", "Mp", "Pea"]
for i in insect_names:
    insect_name_dictionary[i] = ""  # sequence 

# print insect_name_dictionary

for filename in sorted(os.listdir(".")) :
    # print "\n", filename
    if not filename.endswith(".fasta-gb"):
        continue

    sequence_length = None
    species_present_in_this_file = set()
    for seq_record in SeqIO.parse(filename, "fasta"):
        # print seq_record.id
        sequence_length = len(seq_record.seq)
        species = seq_record.id.split("_")[0]
        assert species in insect_name_dictionary, "Unknown species %s" % species
        insect_name_dictionary[species] += seq_record.seq
        species_present_in_this_file.add(species)
    assert sequence_length is not None

    # Which species are missing?
    missing_count = 0 
    for species in insect_names:
        assert species, "Error - blank species found?"
        if species not in species_present_in_this_file:
            missing_count = missing_count+1
            new_made_up_seq = "N"*sequence_length
            insect_name_dictionary[species] += new_made_up_seq

#############################################################################################################


with open("all_together_using_python_nt.fasta", "w") as output:
    for species, seq in insect_name_dictionary.items():
        output.write(">%s\n%s\n" % (species, seq))
        
species = 4

print "checking more than %d seq" %species
for filename in sorted(os.listdir(".")) :
    #print "\n", filename
    if not filename.endswith(".fasta-gb"):
        continue
    id_count = 0
    for seq_record in SeqIO.parse(filename, "fasta"):
        id_count= id_count+1
    if id_count >species:
        print "cp %s ./%d_species"%(filename, species)

