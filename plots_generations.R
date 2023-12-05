library(ggplot2)
mytheme = theme(
  #	plot.background = element_rect(fill = 'black', color = "black"), 
  axis.ticks.y = element_line(color = "black", linewidth = 1), 
  axis.ticks.x = element_line(color = "black", linewidth = 1), 
  axis.ticks.length = unit(0.5, "cm"), 
  axis.line.x = element_line(color = "black", linewidth = 1), 
  axis.line.y = element_line(color = "black", linewidth = 1), 
  
  axis.text.x = element_text(color = 'black', size = 24, margin = margin(rep(4, 4))), 
  axis.text.y = element_text(color = 'black', size = 24, margin = margin(rep(2, 4))), 
  axis.title.x = element_text(color = "black", size = 24, margin = margin(rep(15, 4))), 
  axis.title.y = element_text(color = "black", size = 24,  margin = margin(rep(15, 4))), 
  plot.title = element_text(color = "black", size = 24, margin = margin(rep(15, 4))), 
  panel.background = element_rect(fill = "white"), 
  #	panel.border = element_blank(),
  panel.grid.major.y = element_blank(), 
  panel.grid.minor.y = element_blank(), 
  panel.grid.major.x = element_blank(), 
  panel.grid.minor.x = element_blank(),
  legend.background = element_blank())

mytheme_hm = theme(
  #	plot.background = element_rect(fill = 'black', color = "black"), 
  axis.ticks.y = element_line(color = "black", linewidth = 0), 
  axis.ticks.x = element_line(color = "black", linewidth = 0), 
  axis.ticks.length = unit(0, "cm"), 
  axis.line.x = element_line(color = "white", linewidth = 0), 
  axis.line.y = element_line(color = "white", linewidth = 0), 
  
  axis.text.x = element_text(color = 'black', size = 24, margin = margin(rep(4, 4))), 
  axis.text.y = element_text(color = 'black', size = 24, margin = margin(rep(2, 4))), 
  axis.title.x = element_text(color = "black", size = 24, margin = margin(rep(15, 4))), 
  axis.title.y = element_text(color = "black", size = 24,  margin = margin(rep(15, 4))), 
  plot.title = element_text(color = "black", size = 24, margin = margin(rep(15, 4))), 
  panel.background = element_rect(fill = "white"), 
  #	panel.border = element_blank(),
  panel.grid.major.y = element_blank(), 
  panel.grid.minor.y = element_blank(), 
  panel.grid.major.x = element_blank(), 
  panel.grid.minor.x = element_blank(),
  legend.background = element_blank())

###Fig. 1###
###Fig. 1A###
additive <- function(x){1-0.001*x}
multiplicative <- function(x) {(1-0.002)^x}
synergistic <- function(x) {1-0.00002*(x^2)}
colors <- c("additive" = "#56B4E9", "multiplicative" = "#E69F00", "synergistic" = "#009E73")
p<-ggplot()+ geom_function(fun = additive,aes(colour = "additive"),size =2)+ geom_function(fun = multiplicative,aes(colour = "multiplicative"), size =2,xlim = c(0,999))+ geom_function(fun = synergistic,aes(colour = "synergistic"), size =2,xlim = c(0,999))
p1<-p+xlim(0, 1001)+scale_color_manual(values = colors)+mytheme+ylim(0,1)+theme(legend.text=element_text(size=24))+labs(x="TE copies", y="Fitness")
p1

additive <- function(x){log(1-0.001*x)}
multiplicative <- function(x) {log((1-0.002)^x)}
synergistic <- function(x) {log(1-0.00002*(x^2))}
colors <- c("additive" = "#56B4E9", "multiplicative" = "#E69F00", "synergistic" = "#009E73")
p<-ggplot()+ geom_function(fun = additive,aes(colour = "additive"),size =2)+ geom_function(fun = multiplicative,aes(colour = "multiplicative"), size =2,xlim = c(0,999))+ geom_function(fun = synergistic,aes(colour = "synergistic"), size =2,xlim = c(0,999))
p1<-p+xlim(0, 1001)+scale_color_manual(values = colors)+mytheme+theme(legend.text=element_text(size=24))+labs(x="TE copies", y="Fitness")
p1
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/log_fitness_function_s_0.001_0.002_0.00002_legend.pdf", sep = ""), plot = p1, width = 8, height = 5)

##Fig. 1B##
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_10-6Rec_Pjump_0.01_K_0_R_0_multiplicative.txt",header=F)
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_10-6Rec_Pjump_0.01_K_0_R_0_synergistic_varying_initial.txt",header=F)
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_inital_TE_0.01_K_0_R_0_additive_varying_initial.txt",header=F)
te_num = te_num_t[seq(1, nrow(te_num_t), 5), ]
te_num$V1 <- factor(te_num$V1, levels = c("-0.01","-0.001","-1e-04"));
p<-ggplot(te_num, aes(x = V2/1000, y = V3))+geom_point(aes(color=V1, group=V1),size=0.1) + scale_color_manual(values = c("#346db2","#bf478e","#d993bc"))#"#346db2","#bfbfbf" , "#d993bc"
p1<-p+theme(axis.line.x = element_line(color="black", size = 0.8), axis.line.y = element_line(color="black", size = 1),axis.title.x = element_text(face="bold",  size=20),axis.title.y = element_text(angle=90,size=20,face="bold"), axis.text.x  = element_text(size=20, colour="Black"),axis.text.y = element_text(size=20,colour="Black"), legend.text = element_text(hjust=0,size=15,face="italic"),legend.title = element_text(hjust=0,size=17,face="bold"),panel.background = element_rect(fill = "white"))+xlab("generation (1K)")+ ylab("TE abundance")#+xlim(0,5)+ylim(0,1450)#+ylim(0,1450)#+ylim(0,65)
p1<-p1+theme(legend.text=element_text(size=15))+ guides(colour = guide_legend(override.aes = list(size=5)))+mytheme
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/TE_num_trajectory_1.0e-06_0_0_10000.pdf", sep = ""), plot = p1, width = 7, height = 5)

##Fig. 1C##
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/additive_equilibrium.csv",header=T)
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/multiplicative_equilibrium.csv",header=T)
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/synergistic_equilibrium.csv",header=T)

equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/multiplicative_finer_0.6_0.7.csv",header=T)
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/synergistic_equilibrium_10-7.csv",header=T)

##e9995c
p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= TE_num)) + geom_tile(data=subset(equi,!is.na(TE_num)),color = "black",lwd = 1,linetype = 1) +scale_fill_gradient(low = "white", high = "#e9995c", guide = guide_colourbar(direction = "vertical",label.position = "right"))+geom_tile(data = subset(equi,  is.na(TE_num)),color="black",lwd = 1,linetype = 1, fill = "#bfbfbf", alpha = 1)#+scale_fill_distiller(palette = "Oranges", direction = 1)
p<-p1+mytheme_hm+theme(legend.direction = "vertical", legend.position = "right",axis.title.x = element_text(size=0))
p
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_additive_equilibrium.pdf", sep = ""), plot = p, width = 7.5, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_multiplicative_equilibrium.pdf", sep = ""), plot = p, width = 7.5, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_synergistic_equilibrium.pdf", sep = ""), plot = p, width = 7.5, height = 6)

p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= mean_fitness)) + geom_tile(data=subset(equi,!is.na(mean_fitness)),color = "black",lwd = 1,linetype = 1)+scale_fill_gradient(low = "white", high = "#b0d146", guide = guide_colourbar(direction = "vertical",label.position = "right",size = FALSE)) +geom_tile(data = subset(equi,  is.na(mean_fitness)),color="black",lwd = 1,linetype = 1, fill = "#bfbfbf", alpha = 1)
p<-p1+mytheme_hm+theme(legend.position = "none")
p
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_additive_equilibrium_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_multiplicative_equilibrium.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_synergistic_equilibrium_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)

equi$equili <- factor(equi$equili, levels = c("TE loss","stable equilibrium","population crash","Unknown"));
p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= equili))  +   geom_tile(color = "black",lwd = 1,linetype = 1,width =0.1,height =0.1)+scale_fill_manual(breaks = levels(equi$equili), values = c("#9cbce2","#d993bc","#bfbfbf","#EFEBC8"))
p1<-ggplot(equi, aes(mu, sel, fill= equili))  +   geom_tile(color = "black",lwd = 1,linetype = 1,width =1,height =0.001)+scale_fill_manual(breaks = levels(equi$equili), values = c("#9cbce2","#d993bc","#bfbfbf","#EFEBC8"))
p<-p1+mytheme_hm+theme(legend.position = "none",legend.text=element_text(size=14),legend.direction = "horizontal",legend.title=element_blank())
p

ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_additive_equilibrium.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_multiplicative_equilibrium.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_synergistic_equilibrium.pdf", sep = ""), plot = p, width = 6, height = 6)

ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_multiplicative_u_0.1_s_0.06-0.07.pdf", sep = ""), plot = p, width = 6, height = 6)

###Fig. 2###
#Fig. 2A#
additive <- function(x){1-0.001*x}
additive_B_0.2 <- function(x) {1-0.001*(1+0.02*x*0.2)*x}
additive_B_2 <- function(x) {1-0.001*(1+0.02*x*2)*x}
additive_B_20 <- function(x) {1-0.001*(1+0.02*x*20)*x}

additive <- function(x){log(1-0.001*x)}
additive_B_0.2 <- function(x) {log(1-0.001*(1+0.02*x*0.2)*x)}
additive_B_2 <- function(x) {log(1-0.001*(1+0.02*x*2)*x)}
additive_B_20 <- function(x) {log(1-0.001*(1+0.02*x*20)*x)}
colors <- c("additive" = "#56B4E9", "additive_B_0.2" = "#9cbce2", "additive_B_2" = "#5d95c7","additive_B_20" = "#687cbb")
p<-ggplot()+ geom_function(fun = additive,aes(colour = "additive"), size =2)+ geom_function(fun = additive_B_0.2,aes(colour = "additive_B_0.2"), size =2)+ geom_function(fun = additive_B_2,aes(colour = "additive_B_2"), size =2)+ geom_function(fun = additive_B_20,aes(colour = "additive_B_20"), size =2)
p1<-p+mytheme+scale_color_manual(values = colors)+theme(legend.text=element_text(size=15))+xlim(0,1001)
p1
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/fitness_function_s_additive_with_without_epi.pdf", sep = ""), plot = p1, width = 8, height = 5)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/log_fitness_function_s_additive_with_different_b.pdf", sep = ""), plot = p1, width = 8, height = 5)

#Fig. 2B#
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_inital_TE_count_2_Pjump_0.01_K_0_R_0.txt",header=F)
te_num = te_num_t[seq(1, nrow(te_num_t), 5), ]

te_num_epi_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_10-6Rec_Pjump_0.01_K_0.2_R_0.2_additive.txt",header=F)
te_num_epi_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_trajectory_NoModifer_0.01_1.0e-07_0_2_10000",header=F)
te_num_epi = te_num_epi_t[seq(1, nrow(te_num_epi_t), 3), ]
te_num_epi$V1 <- factor(te_num_epi$V1, levels = c("0.01","0.001","1e-04"));

#p<-ggplot(te_num_epi, aes(x = V2/1000, y = V3))+geom_point(data=te_num,aes(x = V2/1000, y = V3),colour='#EFEBC8',size=0.1)+geom_point(aes(color=V1, group=V1),size=0.1) + scale_color_manual(values = c("#346db2","#bf478e","#d993bc"))
p<-ggplot(te_num_epi, aes(x = V2/1000, y = V3))+geom_point(aes(color=V1, group=V1),size=0.1) + scale_color_manual(values = c("#346db2","#bf478e","#d993bc"))
p1<-p+theme(axis.line.x = element_line(color="black", size = 0.8), axis.line.y = element_line(color="black", size = 1),axis.title.x = element_text(face="bold",  size=20),axis.title.y = element_text(angle=90,size=20,face="bold"), axis.text.x  = element_text(size=20, colour="Black"),axis.text.y = element_text(size=20,colour="Black"), legend.text = element_text(hjust=0,size=15,face="italic"),legend.title = element_text(hjust=0,size=17,face="bold"),panel.background = element_rect(fill = "white"))+xlab("generation (1K)")+ ylab("TE abundance")#+xlim(0,5)+ylim(0,1450)#+ylim(0,1450)#+ylim(0,65)
p1<-p1+theme(legend.text=element_text(size=15))+ guides(colour = guide_legend(override.aes = list(size=5)))+mytheme#+ylim(0,1450)
p1
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/TE_num_trajectory_NoModifer_10-7Rec_u0.01_k0_varying_s_b2_additive.pdf", sep = ""), plot = p1, width = 7, height = 5)

#Fig. 2C#
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/additive_k0_b20_equilibrium.csv",header=T)
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/additive_k0.2_b0_equilibrium.csv",header=T)
equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/additive_k0.2_b0.2_equilibrium.csv",header=T)

equi<-read.csv("~/Documents/Postdoc_UCI/TE_simulations/Results/additive_k0_b20_equilibrium_10-7.csv",header=T)

##e9995c
p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= TE_num)) + geom_tile(data=subset(equi,!is.na(TE_num)),color = "black",lwd = 1,linetype = 1) +scale_fill_gradient(low = "white", high = "#e9995c", guide = guide_colourbar(direction = "vertical",label.position = "right"))+geom_tile(data = subset(equi,  is.na(TE_num)),color="black",lwd = 1,linetype = 1, fill = "#bfbfbf",width =1,height =1)
p<-p1+mytheme_hm+theme(legend.direction = "vertical", legend.position = "right",axis.title.x = element_text(size=0))
p
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_additive_k0_b20_10-7.pdf", sep = ""), plot = p, width = 7.5, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_additive_k0.2_b0_10-7.pdf", sep = ""), plot = p, width = 7.5, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_TE_num_additive_k0.2_b0.2_10-7.pdf", sep = ""), plot = p, width = 7.5, height = 6)

p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= mean_fitness)) + geom_tile(data=subset(equi,!is.na(mean_fitness)),color = "black",lwd = 1,linetype = 1)+scale_fill_gradient(low = "white", high = "#b0d146", guide = guide_colourbar(direction = "vertical",label.position = "right",size = FALSE)) +geom_tile(data = subset(equi,  is.na(mean_fitness)),color="black",lwd = 1,linetype = 1, fill = "#bfbfbf", alpha = 1)
p<-p1+mytheme_hm+theme(legend.position = "none")
p
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_additive_k0_b20_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_additive_k0.2_b0_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_meanfitness_additive_k0.2_b0.2_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)

equi$equili <- factor(equi$equili, levels = c("TE loss","stable equilibrium","population crash","Unknown"));
p1<-ggplot(equi, aes(log10(mu), log10(sel), fill= equili))  +   geom_tile(color = "black",lwd = 1,linetype = 1)+scale_fill_manual(breaks = levels(equi$equili), values = c("#9cbce2","#d993bc","#bfbfbf","#EFEBC8"))
p<-p1+mytheme_hm+theme(legend.position = "none",legend.text=element_text(size=14),legend.direction = "horizontal",legend.title=element_blank())
p

ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_additive_equil_k0_b20_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_additive_equil_k0.2_b0_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/HeatMap_additive_equil_k0.2_b0.2_10-7.pdf", sep = ""), plot = p, width = 6, height = 6)

###Fig. 3&4###
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/Freq_Modifier_each_replicate_trajectory_0.1_0.01_1.0e-06",header=F)
te_mean_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/Freq_Modifer_0.1_0.01_1.0e-06",header=F)
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_each_replicate_trajectory_0.1_0.01_1.0e-06_10000",header=F)
te_mean_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/TE_num_0.1_0.01_1.0e-06_10000",header=F)
te_num_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/Mean_fitness_each_replicate_trajectory_0.1_0.01_1.0e-06_10000",header=F)
te_mean_t<-read.table("~/Documents/Postdoc_UCI/TE_simulations/Results/Mean_fitness_0.1_0.01_1.0e-06_10000",header=F)

te_num<-subset(te_num_t, V5 == "0.2_01.0e-06")
te_mean<-subset(te_mean_t, V8 == "0.2_01.0e-06")
te_num = te_num[seq(1, nrow(te_num), 5), ]
te_mean = te_mean[seq(1, nrow(te_mean), 5), ]
te_num$ID <- paste0(te_num$V1,"_",te_num$V4)
p0<-ggplot(te_num, aes(x = (V2-5000)/1000, y = V3, group=ID,color=V1))+geom_line(alpha=0.5,size=0.1)+ scale_color_manual(values = c("#be9ac7","#87be4c"))#+ guides(color = guide_legend(override.aes = list(size = 0.01)))  
p<-p0+geom_point(data=te_mean,aes(x = (V2-5000)/1000, y = V3, group=V1,color=V1),size=0.5)+ guides(colour = guide_legend(override.aes = list(size=5)))
#p1<-p+xlab("generation (1K)")+ ylab("Modifier frequency")+ylim(-0.1,1)+theme(axis.line.x = element_line(color="black", linewidth  = 0.8), axis.line.y = element_line(color="black", linewidth  = 1),axis.title.x = element_text(face="bold",  size=20),axis.title.y = element_text(angle=90,size=20,face="bold"), axis.text.x  = element_text(size=20, colour="Black"),axis.text.y = element_text(size=20,colour="Black"), legend.text = element_text(size=20,face="italic"),legend.title = element_text(hjust=0,size=17,face="bold"),panel.background = element_rect(fill = "white"))
#p1<-p+xlab("generation (1K)")+ ylab("TE number")+theme(axis.line.x = element_line(color="black", size = 0.8), axis.line.y = element_line(color="black", size = 1),axis.title.x = element_text(face="bold",  size=20),axis.title.y = element_text(angle=90,size=20,face="bold"), axis.text.x  = element_text(size=20, colour="Black"),axis.text.y = element_text(hjust=1, size=20,colour="Black"), legend.text = element_text(size=20,face="italic"),legend.title = element_text(hjust=0,size=17,face="bold"),panel.background = element_rect(fill = "white"))
p1<-p+xlab("generation (1K)")+ ylab("Mean fitness")+theme(axis.line.x = element_line(color="black", size = 0.8), axis.line.y = element_line(color="black", size = 1),axis.title.x = element_text(face="bold",  size=20),axis.title.y = element_text(angle=90,size=20,face="bold"), axis.text.x  = element_text(size=20, colour="Black"),axis.text.y = element_text(hjust=1, size=20,colour="Black"), legend.text = element_text(size=20,face="italic"),legend.title = element_text(hjust=0,size=17,face="bold"),panel.background = element_rect(fill = "white"))
p1<-p1+mytheme
p1
#ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/u0.1_k0.2_s0.01_b0_r1.0e-06_Modifier_frequency_each_replicate.pdf", sep = ""), plot = p1, width = 7, height = 5)
#ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/u0.1_k0.2_s0.01_b0_r1.0e-06_TE_num_each_replicate.pdf", sep = ""), plot = p1, width = 7, height = 5)
ggsave(file = paste("/Users/yuhenghuang/Documents/Postdoc_UCI/TE_simulations/Results/plot/u0.1_k0.2_s0.01_b0_r1.0e-06_mean_fitness_each_replicate.pdf", sep = ""), plot = p1, width = 7, height = 5)
