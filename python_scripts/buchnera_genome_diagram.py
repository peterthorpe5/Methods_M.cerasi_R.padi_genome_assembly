#Title: Python script to draw the genome using, genome diagram

"""
this is an untaural process of voodoo to make a very pretty picture!!!

"""

############################################################################
#imports.......

from reportlab.lib import colors
from reportlab.lib.units import cm
# Biopython core
from Bio import SeqIO
from Bio.SeqFeature import SeqFeature, FeatureLocation

# Bio.Graphics.GenomeDiagram
from Bio.Graphics.GenomeDiagram import Diagram



################################################################################

#load the genbank file that contains the genes
gbk_filename = "Buchnera.gbk"
genbank_entry = SeqIO.read(open(gbk_filename), "genbank")

gdd = Diagram('Test Diagram')

#Add a track of features,
gdt_features = gdd.new_track(1, greytrack=True,
                             name="CDS Features",
                             scale_largetick_interval=10000,
                             scale_smalltick_interval=1000,
                             scale_fontsize=4,
                             scale_format = "SInt",
                             greytrack_labels=False, #e.g. 5
                             height=0.75)

#We'll just use one feature set for these features,
gds_features = gdt_features.new_set()



    
for feature in genbank_entry.features:
    #if feature.type not in ["CDS", "tRNA", "rRNA"] :
    if feature.type in ["source", "gene"] :
        #We're going to ignore these (ignore genes as the CDS is enough)
        continue

    #Note that I am using strings for color names, instead
    #of passing in color objects.  This should also work!
    if feature.type == "tRNA" :
        color = "red"
    elif feature.type == "rRNA":
        color = "purple"
    elif feature.type != "CDS" :
        color = "lightgreen"
    elif len(gds_features) % 2 == 0 :
        color = "blue"
    else :
        color = "green"

    gds_features.add_feature(feature, color=color,
                             sigil="ARROW",
                             arrowshaft_height=0.6,
                             arrowhead_length=0.5,
                             label_position = "start",
                             label_size = 3,
                             label_angle = 90,
                             label=True)


    

#And draw it...
gdd.draw(format='linear', orientation='landscape',
         tracklines=False, pagesize='A4', fragments=10)
gdd.write("Buchnera_linear_everything.pdf", 'PDF')
#gdd.write("NC_005213_linear.svg", 'SVG')

#And a circular version
#Change the order and leave an empty space in the center:
gdd.move_track(1,3)
gdd.draw(format='circular', tracklines=False, pagesize=(30*cm,30*cm))
gdd.write("Buchnera_everything.pdf", 'PDF')
#gdd.write("NC_005213_circular.svg", 'SVG')

print "Done"
