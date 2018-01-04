#!/usr/bin/env python
# author: Peter Thorpe September 2016. The James Hutton Insitute, Dundee, UK.

# Title: Script to prepare the gen catergories for the heat map
# RNAseq_effecotr/ MS_effector list needs to be updated for whatever
# species you are using
# python 2.7 script

RNAseq_effector = """Rpa00042
Rpa10968
Rpa24776
Rpa11055
Rpa11152
Rpa11300
Rpa11315
Rpa24973
Rpa11357
Rpa02362
Rpa02363
Rpa11453
Rpa11537
Rpa11578
Rpa02432
Rpa11683
Rpa25243
Rpa11767
Rpa11786
Rpa11787
Rpa11788
Rpa11789
Rpa11832
Rpa11872
Rpa02525
Rpa02540
Rpa02547
Rpa11979
Rpa12011
Rpa12023
Rpa12069
Rpa12143
Rpa02624
Rpa25498
Rpa12268
Rpa12352
Rpa25576
Rpa12396
Rpa12412
Rpa02686
Rpa02705
Rpa02711
Rpa12484
Rpa25645
Rpa12518
Rpa00394
Rpa12636
Rpa12672
Rpa12673
Rpa02773
Rpa02779
Rpa12770
Rpa12773
Rpa12777
Rpa12798
Rpa12801
Rpa12854
Rpa12860
Rpa12861
Rpa25851
Rpa12919
Rpa13027
Rpa13080
Rpa13113
Rpa13141
Rpa13157
Rpa26039
Rpa13456
Rpa13457
Rpa13458
Rpa02963
Rpa13507
Rpa26190
Rpa13677
Rpa03041
Rpa13696
Rpa13708
Rpa13710
Rpa13737
Rpa13759
Rpa03066
Rpa03077
Rpa03078
Rpa26256
Rpa13848
Rpa13849
Rpa13926
Rpa13959
Rpa14027
Rpa14180
Rpa14243
Rpa14244
Rpa14285
Rpa14415
Rpa14416
Rpa00488
Rpa00490
Rpa03278
Rpa03279
Rpa14450
Rpa14538
Rpa03305
Rpa03307
Rpa03310
Rpa14574
Rpa14576
Rpa14611
Rpa14618
Rpa03359
Rpa03363
Rpa14753
Rpa14770
Rpa14837
Rpa14839
Rpa00506
Rpa00519
Rpa14868
Rpa14875
Rpa14898
Rpa14995
Rpa14996
Rpa15017
Rpa03431
Rpa15067
Rpa15151
Rpa15175
Rpa00542
Rpa00543
Rpa15316
Rpa15322
Rpa03548
Rpa03554
Rpa15385
Rpa15566
Rpa15594
Rpa00066
Rpa03629
Rpa15682
Rpa15684
Rpa15724
Rpa03692
Rpa03698
Rpa15770
Rpa15771
Rpa15772
Rpa03763
Rpa15926
Rpa15982
Rpa15992
Rpa15993
Rpa00648
Rpa03881
Rpa03902
Rpa03905
Rpa16303
Rpa16304
Rpa16323
Rpa03965
Rpa03966
Rpa03967
Rpa03968
Rpa03972
Rpa03991
Rpa16472
Rpa16544
Rpa16577
Rpa04084
Rpa04093
Rpa04094
Rpa16746
Rpa16747
Rpa16748
Rpa04118
Rpa04119
Rpa00722
Rpa17003
Rpa17051
Rpa17052
Rpa17053
Rpa17054
Rpa00773
Rpa04295
Rpa04339
Rpa17321
Rpa17339
Rpa17397
Rpa17398
Rpa17400
Rpa17427
Rpa04421
Rpa04431
Rpa04432
Rpa17531
Rpa04438
Rpa04443
Rpa17590
Rpa17604
Rpa17701
Rpa17722
Rpa04553
Rpa04558
Rpa04645
Rpa04746
Rpa18380
Rpa18429
Rpa18430
Rpa04921
Rpa18688
Rpa18870
Rpa05131
Rpa18942
Rpa18947
Rpa19281
Rpa19477
Rpa19491
Rpa05456
Rpa05457
Rpa19526
Rpa19527
Rpa19623
Rpa19662
Rpa19663
Rpa05543
Rpa05545
Rpa05557
Rpa19774
Rpa19821
Rpa05798
Rpa05827
Rpa20144
Rpa05865
Rpa05876
Rpa05877
Rpa05878
Rpa05879
Rpa05881
Rpa05883
Rpa05884
Rpa05885
Rpa20258
Rpa05978
Rpa01107
Rpa06080
Rpa01125
Rpa01129
Rpa20537
Rpa20538
Rpa20655
Rpa06213
Rpa20669
Rpa20683
Rpa06241
Rpa06332
Rpa06339
Rpa06340
Rpa06341
Rpa20889
Rpa20890
Rpa20960
Rpa06476
Rpa06477
Rpa20974
Rpa20975
Rpa06482
Rpa06483
Rpa01197
Rpa21050
Rpa06625
Rpa06662
Rpa06666
Rpa06669
Rpa06714
Rpa21332
Rpa21380
Rpa01261
Rpa01269
Rpa01270
Rpa06842
Rpa06891
Rpa01292
Rpa21532
Rpa06966
Rpa07038
Rpa07121
Rpa07162
Rpa01366
Rpa07240
Rpa07357
Rpa01388
Rpa01402
Rpa01404
Rpa07425
Rpa07426
Rpa07550
Rpa07569
Rpa07571
Rpa07592
Rpa07595
Rpa01445
Rpa01468
Rpa07621
Rpa07641
Rpa07643
Rpa07644
Rpa07646
Rpa07674
Rpa22268
Rpa22281
Rpa07690
Rpa22322
Rpa07735
Rpa22337
Rpa01530
Rpa01532
Rpa01534
Rpa07780
Rpa22448
Rpa07837
Rpa22455
Rpa01550
Rpa01554
Rpa01568
Rpa07964
Rpa07967
Rpa22613
Rpa22615
Rpa08050
Rpa22651
Rpa08145
Rpa22802
Rpa08218
Rpa08409
Rpa08417
Rpa23075
Rpa08528
Rpa08567
Rpa08568
Rpa08569
Rpa08570
Rpa08571
Rpa08574
Rpa08605
Rpa08606
Rpa08609
Rpa23144
Rpa08667
Rpa23219
Rpa00240
Rpa00241
Rpa01743
Rpa08791
Rpa08826
Rpa01773
Rpa01774
Rpa01781
Rpa08950
Rpa01796
Rpa09011
Rpa09012
Rpa09017
Rpa09018
Rpa09019
Rpa09079
Rpa09080
Rpa09119
Rpa09120
Rpa09216
Rpa09220
Rpa09224
Rpa09273
Rpa09274
Rpa09306
Rpa09438
Rpa23810
Rpa09493
Rpa09555
Rpa09558
Rpa09641
Rpa09776
Rpa01940
Rpa09901
Rpa10044
Rpa10057
Rpa10085
Rpa10103
Rpa10104
Rpa10144
Rpa10159
Rpa10297
Rpa10321
Rpa10322
Rpa10324
Rpa10326
Rpa02087
Rpa10384
Rpa10401
Rpa10410
Rpa02134
Rpa10445
Rpa10500
Rpa10518
Rpa10563
Rpa24612
Rpa10746
Rpa02224
Rpa10848
Rpa10849
Rpa24687
Rpa10924
Rpa10965
    """.split()
    


MS_effector="""Rpa11055
Rpa24973
Rpa12143
Rpa02624
Rpa02624.t2
Rpa25498
Rpa25576
Rpa12919
Rpa14244
Rpa03278
Rpa03279
Rpa14576
Rpa14618
Rpa14753
Rpa14995
Rpa14996
Rpa15151
Rpa03553
Rpa16514
Rpa04094
Rpa17003
Rpa17321
Rpa04645
Rpa18430
Rpa18917
Rpa18947
Rpa19477
Rpa19526
Rpa19527
Rpa19623
Rpa19623.t2
Rpa19662
Rpa19663
Rpa19821
Rpa06482
Rpa06483
Rpa06891
Rpa06990.t2
Rpa06990
Rpa07425
Rpa07569
Rpa07570
Rpa07571
Rpa22281
Rpa07735
Rpa22455
Rpa08058
Rpa01686
Rpa23219
Rpa00241
Rpa09017
Rpa09018
Rpa09019
Rpa09347
Rpa10401
Rpa10410
""".split()

    
def seq_getter(filename1, outfile):
    """opens up a text file with gene names and distances to the nearest gene
    at the 5 prime and three prime direction. When given a list of wanted
    the scrpit will pull out the info for these genes of intesrest"""
    # text file with genes and distances - three columns
    f = open(filename1, "r")
    #outfile
    f_out = open(outfile, 'w')
    # assign the file contents to the variable data
    data = f.readlines()
    # load the data
    data1 = [line.rstrip("\n").split("\t") for line in (data)
             if line.strip() != "" and not line.startswith("g")]
    # to convert data 1 into a list of tuples.
    print data1[:10]
    location_data = [(str(s[0]), str(s[1]), str(s[2])) for s in (data1)]
    # genes of interest
    print >> f_out, 'geneid\tfiveprime\tthreeprime\tClass'
    name_set = set([])
    RNAseq_effector_count = 0
    sub_count = 0
    for i in location_data:
        gene_name = i[0].split(";")[0]
        if gene_name in RNAseq_effector:
            if not gene_name in name_set:
                name_set.add(gene_name)
                fiveprime = i[1]
                threeprime = i[2]
                print >> f_out, '%s\t%s\t%s\tRNAseq_effector' %(gene_name,
                                                                fiveprime,
                                                                threeprime)
                RNAseq_effector_count = RNAseq_effector_count + 1
                continue

        if gene_name in MS_effector:
            if not gene_name in name_set:
                name_set.add(gene_name)
                fiveprime = i[1]
                threeprime = i[2]
                print >> f_out, '%s\t%s\t%s\tMS_effector' %(gene_name,
                                                            fiveprime,
                                                            threeprime)
                sub_count = sub_count+1
                continue
        else:
            fiveprime = i[1]
            threeprime = i[2]
            print >> f_out, '%s\t%s\t%s\tOther' %(gene_name,
                                                  fiveprime,
                                                  threeprime)
    print "sub_count printed:", sub_count, "starting sub = ", len(MS_effector)
    print "RNAseq_effector_count printed:", RNAseq_effector_count, "starting sub = ", len(RNAseq_effector)


# you have to alter this 2 function input string to work with your data!
if __name__ == '__main__':
    seq_getter('distances_to_next_gene.txt',
               'Rp_info_classes_for_heat_map001_20150803.txt')

