#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
File    	: extractRegionFromCoordinates.py
Author  	: Dominik R. Laetsch, dominik.laetsch at gmail dot com
Version 	: 0.1
Description :
	- INPUT: fasta file, gff file (with intron features), coordinates
	- OUTPUT: line for each intron
"""

from __future__ import division
import sys, time

class DataObj():
	def __init__(self, filename):
		self.filename = filename
		self.geneObj_order = []
		self.geneObj_dict = {}

	def add_geneObj(self, geneObj):
		if not geneObj.name in self.geneObj_dict:
			self.geneObj_order.append(geneObj.name)
			self.geneObj_dict[geneObj.name] = geneObj

	def add_intronObj(self, intronObj):
		gene_name = intronObj.name
		if gene_name in self.geneObj_dict:
			self.geneObj_dict[gene_name].add_intronObj(intronObj)
		else:
			sys.exit("ERROR1")

	def yield_introns(self):
		for gene_name in self.geneObj_order:
			geneObj = self.geneObj_dict[gene_name]
			introns = ""
			if geneObj.strand == "+":
				for idx, intronObj in enumerate(geneObj.introns):
					introns += "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % ( \
						geneObj.contig, \
						intronObj.start, \
						intronObj.stop, \
						geneObj.strand, \
						geneObj.name + "_" + str(idx + 1), \
						geneObj.name, \
						idx + 1, \
						len(geneObj.introns) \
						)
			elif geneObj.strand == "-":
				for idx, intronObj in enumerate(reversed(geneObj.introns)):
					introns += "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % ( \
					geneObj.contig, \
					intronObj.start, \
					intronObj.stop, \
					geneObj.strand, \
					geneObj.name + "_" + str(idx + 1), \
					geneObj.name, \
					idx + 1, \
					len(geneObj.introns) \
					)
			yield introns

	def write_intron_pos(self):
		out_f = self.filename + ".intronpos.txt"
		print "Writing %s" % out_f
		with open(out_f, "w") as fh:
			for string in dataObj.yield_introns():
				fh.write(string)

class GeneObj():
	def __init__(self, contig, strand, name):
		self.contig = contig
		self.strand = strand
		self.name = name
		self.introns = []

	def add_intronObj(self, intronObj):
		self.introns.append(intronObj)

class IntronObj():
	def __init__(self, name, start, stop):
		self.name = name
		self.start = start
		self.stop = stop

def parse_gff(gff_f):
	dataObj = DataObj(gff_f)
	with open(gff_f) as fh:
		for line in fh:
			if not line.startswith("#"):
				temp = line.rstrip("\n").split()
				if temp[2] == "intron":
					contig = temp[0]
					start = int(temp[3])
					stop = int(temp[4])
					strand = temp[6]
					name = temp[8].replace("Parent=", "")
					geneObj = GeneObj(contig, strand, name)
					intronObj = IntronObj(name, start, stop)
					dataObj.add_geneObj(geneObj)
					dataObj.add_intronObj(intronObj)
					#print "%s\t%s\t%s\t%s\t%s" % (contig, start, stop, strand, name)
	return dataObj

def parse_fasta(fasta_f):
	fasta_dict = {}
	header, seq = '', ''
	with open(fasta) as fh:
		for line in fh:
			if line.startswith(">"):
				if (seq):
					fasta_dict[header] = seq.upper()
					seq = ''
				header = line.rstrip("\n").lstrip(">").split(" ")[0]
			else:
				seq += line.rstrip("\n")
	fasta_dict[header] = seq
	return fasta_dict

def compute_splice_sites(fasta_dict, dataObj, upstream_start, downstream_start, upstream_end, downstream_end):
	'''
	1234567890	2	9	+	4	7	-
	-23----89-	0 1 1 0	D=2:4	A=8:10 	=> D=(start-1)-UP:(start-1)+DOWN A=(end-1)-UP:(end-1)
	---4567---	0 1 1 0 A=4:6	D=6:8
	0123456789
	AGTGATGAGG 			D=1:3	A=7:9	D=(start-1)-UP:(start)+DOWN A=(end-1)-UP:(end)+DOWN
	GCACTACTCC			A=3:5	D=5:7   A=(start-1)-UP:(start)+DOWN D=(end-1)-UP:end+DOWN
	0123456789
	'''
	for introns in dataObj.yield_introns():
		for line in introns.split("\n"):
			if (line):
				field = line.rstrip("\n").split("\t") # LOCATION\tSTART\tSTOP\tORIENTATION\tNAME
				location = field[0]
				start = int(field[1])
				end = int(field[2])
				strand = field[3]
				name = field[4]
				gene = field[5]
				intron_pos = field[6]
				intron_count = field[7]
				donor_start, donor_end, acceptor_start, acceptor_end = 0,0,0,0
				if location in fasta_dict:
					if end - start > MIN_INTRON_LENGTH:
						if strand == '+':
							donor_start = (start-1)-upstream_start
							donor_end = start + downstream_start
							acceptor_start = (end-1)-upstream_end
							acceptor_end = end + downstream_end
							if donor_start < 0:
								donor_start = 0
							if acceptor_end > len(fasta_dict[location]):
								acceptor_end = len(fasta_dict[location])
						elif strand == '-':
							acceptor_start = (start-1) - downstream_end
							acceptor_end = start + upstream_end
							donor_start = (end-1) - downstream_start
							donor_end = end + upstream_start
							if donor_start > len(fasta_dict[location]):
								donor_start = len(fasta_dict[location])
							if acceptor_end < 0:
								acceptor_end = 0
						else:
							sys.exit("[ERROR] - strand should be +/-, not : %s" % (strand))
						#print "Start", donor_start, donor_end
						#print str(donor_start) + ":" + str(donor_end) + "," + str(acceptor_start) + ":" + str(acceptor_end)

						#donor_header = ">donor;"+ str(start) + "|" + str(donor_start) + ":" + str(donor_end) + ":" + strand #+ " " + fasta_dict[location]
						donor_seq = getRegion(fasta_dict[location], donor_start, donor_end, strand)


						#acceptor_header = ">acceptor;"+ str(end) + "_" + str(acceptor_start) + ":" + str(acceptor_end) + ":" + strand #+ " " + fasta_dict[location]
						acceptor_seq = getRegion(fasta_dict[location], acceptor_start, acceptor_end, strand)
						print "%s\t%s\t%s" % ("\t".join(field), donor_seq, acceptor_seq)
						#print ">Donor_%s\n%s\n>Acceptor_%s\n%s" % (name, donor_seq, name, acceptor_seq)
					else:
						print "[WARN] - %s\t : Intron length is below threshold of %s " % ("\t".join(field), MIN_INTRON_LENGTH)
				else:
					print line
					print fasta_dict.keys()
					sys.exit("[ERROR] %s from coordinate %s not found in fasta %s" % (location, coordinates, fasta))

	#with open(coordinates) as fh:
#		for line in fh:
#			if line.startswith("#"):
#				pass
#			else:
#				field = line.rstrip("\n").split("\t") # LOCATION\tSTART\tSTOP\tORIENTATION\tNAME
#				location = field[0]
#				start = int(field[1])
#				end = int(field[2])
#				strand = field[3]
#				name = field[4]
#				gene = field[5]
#				intron_pos = field[6]
#				intron_count = field[7]
#				#print field
#
#				donor_start, donor_end, acceptor_start, acceptor_end = 0,0,0,0
#				if location in fasta_dict:
#					if end - start > MIN_INTRON_LENGTH:
#						if strand == '+':
#							donor_start = (start-1)-upstream_start
#							donor_end = start + downstream_start
#							acceptor_start = (end-1)-upstream_end
#							acceptor_end = end + downstream_end
#							if donor_start < 0:
#								donor_start = 0
#							if acceptor_end > len(fasta_dict[location]):
#								acceptor_end = len(fasta_dict[location])
#						elif strand == '-':
#
#
#							acceptor_start = (start-1) - downstream_end
#							acceptor_end = start + upstream_end
#							donor_start = (end-1) - downstream_start
#							donor_end = end + upstream_start
#
#							if donor_start > len(fasta_dict[location]):
#								donor_start = len(fasta_dict[location])
#							if acceptor_end < 0:
#								acceptor_end = 0
#						else:
#							sys.exit("[ERROR] - strand should be +/-, not : %s" % (strand))
#						#print "Start", donor_start, donor_end
#						#print str(donor_start) + ":" + str(donor_end) + "," + str(acceptor_start) + ":" + str(acceptor_end)
#
#						#donor_header = ">donor;"+ str(start) + "|" + str(donor_start) + ":" + str(donor_end) + ":" + strand #+ " " + fasta_dict[location]
#						donor_seq = getRegion(fasta_dict[location], donor_start, donor_end, strand)
#
#
#						#acceptor_header = ">acceptor;"+ str(end) + "_" + str(acceptor_start) + ":" + str(acceptor_end) + ":" + strand #+ " " + fasta_dict[location]
#						acceptor_seq = getRegion(fasta_dict[location], acceptor_start, acceptor_end, strand)
#						print "%s\t%s\t%s" % ("\t".join(field), donor_seq, acceptor_seq)
#						#print ">Donor_%s\n%s\n>Acceptor_%s\n%s" % (name, donor_seq, name, acceptor_seq)
#					else:
#						print "[WARN] - %s\t : Intron length is below threshold of %s " % ("\t".join(field), MIN_INTRON_LENGTH)
#				else:
#					print line
#					print fasta_dict.keys()
#					sys.exit("[ERROR] %s from coordinate %s not found in fasta %s" % (location, coordinates, fasta))


def getRegion(seq, start, stop, strand):
		region = seq[int(start):int(stop)]
		if strand == '-':
			complement = {'A':'T','C':'G','G':'C','T':'A','N':'N'}
			region = "".join([complement.get(nt.upper(), '') for nt in region[::-1]])
		elif strand == '+':
			pass
		else :
			sys.exit("[ERROR] - strand should be +/-, not : %s" % (strand))
		return region

if __name__ == "__main__":
	MIN_INTRON_LENGTH = 4
	try:
		gff_f = sys.argv[1]
		fasta = sys.argv[2]
		upstream_start = int(sys.argv[3])
		downstream_start = int(sys.argv[4])
		upstream_end = int(sys.argv[5])
		downstream_end = int(sys.argv[6])
	except:
		sys.exit("Usage: ./extractRegionFromCoordinates.py [GFF] [FASTA] [US] [DS] [UE] [DE] \n\n\
	[GFF] : Intron features have to be present in GFF (use Genometools)\n\
	[US] : Positions upstream of start of intron feature in GFF\n\
	[DS] : Positions downstream of start of intron feature in GFF\n\
	[UE] : Positions upstream of end of intron feature in GFF\n\
	[DS] : Positions downstream of end of intron feature in GFF\n\n   - Extracting splice sites : \n\n   ./extractRegionFromCoordinates.py nGr.v1.0.gff3 nGr.v1.0.fa 0 1 1 0 \n\n")

	dataObj = parse_gff(gff_f)
	#dataObj.write_intron_pos()

	fasta_dict = parse_fasta(fasta)
	compute_splice_sites(fasta_dict, dataObj, upstream_start, downstream_start, upstream_end, downstream_end)
