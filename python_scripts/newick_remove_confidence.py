import sys
from Bio import Phylo

def remove_confidence(in_filename, out_filename, tree_format):
    tree = Phylo.read(in_filename, tree_format)
    for clade in tree.find_clades():
        clade.confidence = None
    Phylo.write(tree, out_filename, tree_format)

input_file, output_file = sys.argv[1:]
remove_confidence(input_file, output_file, "newick")
print("%s --> %s" % (input_file, output_file))
quit
