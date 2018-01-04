#!/bin/bash
#$ -cwd
#Abort on any error,
set -e
cd '/PATH_TO/cegma_v2.4.010312'
#mkdir Mc.blessed.v2.20150622
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v2/Mc.blessed.v2.20150622.fa" ./Mc.blessed.v2.20150622/
cd Mc.blessed.v2.20150622
cegma -g Mc.blessed.v2.20150622.fa


######################################################################################################################################################


cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mc.blessed.v3.20150626
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v3/Mc.blessed.v3.20150626.fa" ./Mc.blessed.v3.20150626.fa/
cd Mc.blessed.v3.20150626
cegma -g Mc.blessed.v3.20150626.fa


######################################################################################################################################################
cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mc.blessed.v4.20150710
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v4/Mc.blessed.v4.20150710.fa" ./Mc.blessed.v4.20150710/
cd Mc.blessed.v4.20150710
cegma -g Mc.blessed.v4.20150710.fa


######################################################################################################################################################
cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mc.blessed.v5.20150714
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v5/Mc.blessed.v5.20150714.fa" ./Mc.blessed.v5.20150714/
cd Mc.blessed.v5.20150714
cegma -g Mc.blessed.v5.20150714.fa
 
######################################################################################################################################################
cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mc.blessed.v6.20150716
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v6/Mc.blessed.v6.20150716.fa" ./Mc.blessed.v6.20150716/
cd Mc.blessed.v6.20150716
cegma -g Mc.blessed.v6.20150716.fa



######################################################################################################################################################
cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mc.blessed.v8.20150722
cp "/PATH_TO/M.cerasi_genome_data/clc.blessed.v8/Mc.blessed.v8.20150722.fa" ./Mc.blessed.v8.20150722/
cd Mc.blessed.v8.20150722
cegma -g Mc.blessed.v8.20150722.fa


######################################################################################################################################################
cd '/PATH_TO/cegma_v2.4.010312'
mkdir Mpersicae
cp "/PATH_TO/M.persicae_O_genome_data/Mp1087439_TGAC_V1.1-scaffolds.fa" ./Mpersicae/
cd Mpersicae
cegma -g Mp1087439_TGAC_V1.1-scaffolds.fa




