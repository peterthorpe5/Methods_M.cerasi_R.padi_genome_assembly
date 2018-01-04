#11932 values removed from this analysis


setwd("/home/PATH_TO/Desktop/Mc_wild")
library(png)
library(gridExtra)
library(ggplot2)


# how I have imported data into R before....
data<-read.table("Mc_info_classes_for_heat_map_WILD.txt",header=TRUE)


p <- ggplot (data, aes(fiveprime, threeprime))


p + geom_bin2d (bins = 50)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_001.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)



p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")



ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_002.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red", limits = c(0, 2000))


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_003.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)




#p + geom_point(aes(colour=class, shape=Class, size = 8))




ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_004.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)




p + geom_point(aes(colour=factor(Class), shape=factor(Class), size=Class))

p + geom_point(aes(colour=factor(Class), shape=factor(Class)))


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_005.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


t3 <- data[data$Class==3,]








p <- ggplot (data, aes(log(fiveprime), log(threeprime)))


p + geom_point(aes(colour=factor(Class), shape=factor(Class)))



ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_007.eps"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


p + geom_point(aes(colour=factor(Class), shape=factor(Class))) +facet_grid(.~Class)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_008.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, #limitsize = TRUE)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_008.eps"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


p + geom_point(aes(colour=factor(Class), shape=factor(Class))) +facet_wrap(~Class)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_009.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)





######### pete playing#######
#this code is the essential ines
p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_010.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)

ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_010.eps"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)

p + geom_bin2d (bins = 60)+ scale_fill_gradient (low="blue", high = "red")


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_011.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)



### this works

p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), shape=factor(Class))))


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_actual_result001.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)

ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_actual_result001.eps"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


#messing
        
p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class) + geom_point(colour="grey90", size = 4, show_guide = TRUE), shape=factor(Class)))) 


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_actual_result002.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)




p + geom_bin2d (bins = 60)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), size = 3, shape=factor(Class))))



p + geom_bin2d (bins = 60)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), size = 1, shape=factor(Class))))



p + geom_point(aes(colour=factor(Class), shape=factor(Class)))



######## to do facet with scale gradient


p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") + geom_point(aes(colour=factor(Class))) +facet_grid(.~Class)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_actual_result003a.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)



p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") + geom_point(aes(colour=factor(Class), )) +facet_grid(.~Class)



#p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") + geom_point(aes(colour=factor(Class))), +facet_grid(.~Class)



######### heat map facet grid


p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") +facet_grid(.~Class)


#p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") +(geom_point(aes(colour=factor(Class), +facet_grid(.~Class)

ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_facet001_wild_HCE.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_facet.eps"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)



#################################################### to get it to produce heat map

p <- ggplot (data, aes(fiveprime, threeprime))

p + geom_bin2d (bins = 50)

p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")
p <- ggplot (data, aes(log(fiveprime), log(threeprime)))
p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), shape=factor(Class))))

p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")

p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")  +facet_grid(.~Class) 

#p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red") +(geom_point(aes(colour=factor(Class) +facet_grid(.~Class)





######################################## to specifically change to colours of the points

#p + geom_bin2d (bins = 80)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), shape=factor(Class)))) + scale_colour_manual(values = c("yellow","None", "blue", "pink"))

ggsave(filename = ("/home/PATH_TO/Desktop/Mc/Mc_heat_maps_real001a_colours_wild.png"), plot = last_plot(), scale = 1, width = 7, height = 7, dpi = 1200, limitsize = TRUE)


 p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), shape=factor(Class)))) + scale_colour_manual(values = c("yellow","black", "green", "white", "purple"))




 p + geom_bin2d (bins = 50)+ scale_fill_gradient (low="blue", high = "red")+(geom_point(aes(colour=factor(Class), shape=factor(Class)))) + scale_colour_manual(values = c("green","yellow", "black"))
