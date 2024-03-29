# rehh Workflow Script version 1.0

setwd(".")
list.of.packages <- c("dplyr", "gplots", "ggplot2", "rehh")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.us.r-project.org")

library(dplyr)
library(rehh)
library(ggplot2)
source("rehh_patches.R")
args<-commandArgs(TRUE)

print(args)

haps1 <- read.table(args[2], stringsAsFactors = FALSE)
sample1 <- read.table(args[3], header = TRUE, stringsAsFactors = FALSE)
haps2 <- read.table(args[4], stringsAsFactors = FALSE)
sample2 <- read.table(args[5], header = TRUE, stringsAsFactors = FALSE)
haps3 <- read.table(args[6], stringsAsFactors = FALSE)
sample3 <- read.table(args[7], header = TRUE, stringsAsFactors = FALSE)

########################
# Count Frequencies 1
########################

# Count frequencies of haps1 (0,1) by row and convert to matrix
count_frq <- apply(haps1[,-(1:5)], 1, function(x) { table(factor(x, levels=0:1)) })
# Column 1 = 0
# Column 2 = 1
tr_freq <- t(as.data.frame(count_frq))

# Sum frequencies for each allele by row (SNP)
al_a1 <- tr_freq[,c(T,F)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
al_b1 <- tr_freq[,c(F,T)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
########################
# Count Frequencies 2
########################

# Count frequencies of haps1 (0,1) by row and convert to matrix
count_frq <- apply(haps2[,-(1:5)], 1, function(x) { table(factor(x, levels=0:1)) })
# Column 1 = 0
# Column 2 = 1
tr_freq <- t(as.data.frame(count_frq))

# Sum frequencies for each allele by row (SNP)
al_a2 <- tr_freq[,c(T,F)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
al_b2 <- tr_freq[,c(F,T)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
########################
# Count Frequencies 3
########################

# Count frequencies of haps1 (0,1) by row and convert to matrix
count_frq <- apply(haps3[,-(1:5)], 1, function(x) { table(factor(x, levels=0:1)) })
# Column 1 = 0
# Column 2 = 1
tr_freq <- t(as.data.frame(count_frq))

# Sum frequencies for each allele by row (SNP)
al_a3 <- tr_freq[,c(T,F)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
al_b3 <- tr_freq[,c(F,T)] / (tr_freq[,c(T,F)] + tr_freq[,c(F,T)])
############################
# Apply composition formula
############################

compPop1 <- 5/8
compPop2 <- 3/8

# Iterate simultaneously both frequency tables
f0_snps <- apply(data.frame(al_a1, al_b1), 1, function(row) (compPop1 * row[1]) + (compPop2 * row[2]))
f1_snps <- apply(data.frame(al_a2, al_b2), 1, function(row) (compPop1 * row[1]) + (compPop2 * row[2]))

maxrow <- function(row) { 
  if (max(row[1],row[2]) == row[1])
    c(1,0)
  else if (max(row[2],row[1]) == row[2])
        c(0,1)
      else
        c(1,0)
}

# Iterate simultaneously both frequency tables and assign 1 to maximum of each row
map <- apply(
    data.frame(f0_snps, f1_snps), 
    1,
    maxrow)
map <- t(map)

# Iterate simultaneously both frequency tables and assign 1 to maximum of each row
# map <- apply(data.frame(f0_snps, f1_snps), 1, function(row) ifelse(max(row[1],row[2]),1,0))######################
# Write MAP 1
######################

#View(map)
#str(map)

maps1 <- data.frame(haps1[,2], haps1[,1], haps1[,3], anc = map[,1] , der = map[,2])

# maps1 <- haps1[c(2,1,3)
finalMap1 <- maps1

mapFileName1 <- paste0("chr-", args[1] ,"-rehh_map_pop-1.txt")

# write to file
write.table(
    finalMap1, 
    file = mapFileName1, 
    quote = FALSE, 
    col.names = FALSE, 
    row.names = FALSE)

############################################
# HAP Formatting 1
############################################

# Remove header row from samples file
sample1 <- sample1[-1,]

# Convert haplotype data frame into matrix
haps1 <- haps1[,-(1:5)] %>% as.matrix

# Assign column/row names as positions/individual IDs
row.names(haps1) <- haps1[,3]
colnames(haps1) <- rep(sample1$ID_1, each = 2)

# Add 1 to each cell
haps1 <- haps1 + 1

# Transpose
haps1 <- t(haps1)

# Annotate rows
haplo.names <- rep(sample1$ID_2, each = 2)
first.haplos <- seq(from = 1, to = length(haplo.names), by = 2)
second.haplos <- seq(from = 2, to = length(haplo.names), by = 2)

haplo.reps <- c()
haplo.reps[first.haplos] <- paste0(haplo.names[first.haplos],"_1")
haplo.reps[second.haplos] <- paste0(haplo.names[second.haplos],"_2")

haps1 <- data.frame(haps1) %>%
  mutate(ind = haplo.reps) %>%
  select(ind, everything())
# write to file (necessary for rehh for some reason)

tableHap1 <- paste0("chr-", args[1] , "-rehh_hap_pop-1.txt") 

write.table(haps1, file = tableHap1, quote = FALSE, col.names = FALSE, row.names = FALSE)

######################
# Write MAP 2
######################

#View(map)
#str(map)

maps2 <- data.frame(haps2[,2], haps2[,1], haps2[,3], anc = map[,1] , der = map[,2])

# maps2 <- haps2[c(2,1,3)
finalMap2 <- maps2

mapFileName2 <- paste0("chr-", args[1] ,"-rehh_map_pop-2.txt")

# write to file
write.table(
    finalMap2, 
    file = mapFileName2, 
    quote = FALSE, 
    col.names = FALSE, 
    row.names = FALSE)

############################################
# HAP Formatting 2
############################################

# Remove header row from samples file
sample2 <- sample2[-1,]

# Convert haplotype data frame into matrix
haps2 <- haps2[,-(1:5)] %>% as.matrix

# Assign column/row names as positions/individual IDs
row.names(haps2) <- haps2[,3]
colnames(haps2) <- rep(sample2$ID_1, each = 2)

# Add 1 to each cell
haps2 <- haps2 + 1

# Transpose
haps2 <- t(haps2)

# Annotate rows
haplo.names <- rep(sample2$ID_2, each = 2)
first.haplos <- seq(from = 1, to = length(haplo.names), by = 2)
second.haplos <- seq(from = 2, to = length(haplo.names), by = 2)

haplo.reps <- c()
haplo.reps[first.haplos] <- paste0(haplo.names[first.haplos],"_1")
haplo.reps[second.haplos] <- paste0(haplo.names[second.haplos],"_2")

haps2 <- data.frame(haps2) %>%
  mutate(ind = haplo.reps) %>%
  select(ind, everything())
# write to file (necessary for rehh for some reason)

tableHap2 <- paste0("chr-", args[1] , "-rehh_hap_pop-2.txt") 

write.table(haps2, file = tableHap2, quote = FALSE, col.names = FALSE, row.names = FALSE)

######################
# Write MAP 3
######################

#View(map)
#str(map)

maps3 <- data.frame(haps3[,2], haps3[,1], haps3[,3], anc = map[,1] , der = map[,2])

# maps3 <- haps3[c(2,1,3)
finalMap3 <- maps3

mapFileName3 <- paste0("chr-", args[1] ,"-rehh_map_pop-3.txt")

# write to file
write.table(
    finalMap3, 
    file = mapFileName3, 
    quote = FALSE, 
    col.names = FALSE, 
    row.names = FALSE)

############################################
# HAP Formatting 3
############################################

# Remove header row from samples file
sample3 <- sample3[-1,]

# Convert haplotype data frame into matrix
haps3 <- haps3[,-(1:5)] %>% as.matrix

# Assign column/row names as positions/individual IDs
row.names(haps3) <- haps3[,3]
colnames(haps3) <- rep(sample3$ID_1, each = 2)

# Add 1 to each cell
haps3 <- haps3 + 1

# Transpose
haps3 <- t(haps3)

# Annotate rows
haplo.names <- rep(sample3$ID_2, each = 2)
first.haplos <- seq(from = 1, to = length(haplo.names), by = 2)
second.haplos <- seq(from = 2, to = length(haplo.names), by = 2)

haplo.reps <- c()
haplo.reps[first.haplos] <- paste0(haplo.names[first.haplos],"_1")
haplo.reps[second.haplos] <- paste0(haplo.names[second.haplos],"_2")

haps3 <- data.frame(haps3) %>%
  mutate(ind = haplo.reps) %>%
  select(ind, everything())
# write to file (necessary for rehh for some reason)

tableHap3 <- paste0("chr-", args[1] , "-rehh_hap_pop-3.txt") 

write.table(haps3, file = tableHap3, quote = FALSE, col.names = FALSE, row.names = FALSE)


#######################
# Scan_hh() funtion 1
#######################

# Haplotype are recoded (if recode.allele option is activated) according to the ancestral and derived allele 
# definition available in the map file (fourth and fifth columns) as :
# 0=missing data, 
# 1=ancestral allele, 
# 2=derived allele. 

hap1 <- data2haplohh(
        hap_file = tableHap1, 
        map_file = mapFileName1, 
    		# haplotype.in.columns = TRUE , 
  			# recode.allele = TRUE, 
			# min_maf = 0.1,
      		# min_perc_geno.hap = 95,
        	# min_perc_geno.snp = 50,
        chr.name = args[1])
ehhScan1 <- scan_hh(hap1)
scanFileName1 <- paste0("chr-", args[1] , "-rehh_scanhh_pop-1.txt") 
write.table(
    ehhScan1,
    file = scanFileName1)

######################
# iHS 1
######################

ihsFileName1 <- paste0("chr-", args[1] , "-rehh_ihs_pop1.txt")  
ihs1 <- ihh2ihs(ehhScan1, freqbin=0.5)
write.table(ihs1, file = ihsFileName1)
write.csv(ihs1, file = "rehh_table_ihs_pop-1.csv")

ihsFileName1Png <- paste0("chr-", args[1] , "-rehh_ihs_pop-1.png") 
ihsTitleName1 <- paste0("iHS Population 1 chr " , args[1])
png(filename = ihsFileName1Png)
ihsplot_mod(ihs1, plot.pval = TRUE, ylim.scan=2, main = ihsTitleName1)
dev.off()


#######################
# Scan_hh() funtion 2
#######################

# Haplotype are recoded (if recode.allele option is activated) according to the ancestral and derived allele 
# definition available in the map file (fourth and fifth columns) as :
# 0=missing data, 
# 1=ancestral allele, 
# 2=derived allele. 

hap2 <- data2haplohh(
        hap_file = tableHap2, 
        map_file = mapFileName1, 
    		# haplotype.in.columns = TRUE , 
  			# recode.allele = TRUE, 
			# min_maf = 0.1,
      		# min_perc_geno.hap = 95,
        	# min_perc_geno.snp = 50,
        chr.name = args[1])
ehhScan2 <- scan_hh(hap2)
scanFileName2 <- paste0("chr-", args[1] , "-rehh_scanhh_pop-2.txt") 
write.table(
    ehhScan2,
    file = scanFileName2)



######################
# iHS 2
######################

ihsFileName2 <- paste0("chr-", args[1] , "-rehh_ihs_pop2.txt")  
ihs2 <- ihh2ihs(ehhScan2, freqbin=0.5)
write.table(ihs2, file = ihsFileName2)
write.csv(ihs2, file = "rehh_table_ihs_pop-2.csv")

ihsFileName2Png <- paste0("chr-", args[1] , "-rehh_ihs_pop-2.png") 
ihsTitleName2 <- paste0("iHS Population 2 chr " , args[1])
png(filename = ihsFileName2Png)
ihsplot_mod(ihs2, plot.pval = TRUE, ylim.scan=2, main = ihsTitleName2)
dev.off()


#######################
# Scan_hh() funtion 3
#######################

# Haplotype are recoded (if recode.allele option is activated) according to the ancestral and derived allele 
# definition available in the map file (fourth and fifth columns) as :
# 0=missing data, 
# 1=ancestral allele, 
# 2=derived allele. 

hap3 <- data2haplohh(
        hap_file = tableHap3, 
        map_file = mapFileName1, 
    		# haplotype.in.columns = TRUE , 
  			# recode.allele = TRUE, 
			# min_maf = 0.1,
      		# min_perc_geno.hap = 95,
        	# min_perc_geno.snp = 50,
        chr.name = args[1])
ehhScan3 <- scan_hh(hap3)
scanFileName3 <- paste0("chr-", args[1] , "-rehh_scanhh_pop-3.txt") 
write.table(
    ehhScan3,
    file = scanFileName3)



######################
# iHS 3
######################

ihsFileName3 <- paste0("chr-", args[1] , "-rehh_ihs_pop3.txt")  
ihs3 <- ihh2ihs(ehhScan3, freqbin=0.5)
write.table(ihs3, file = ihsFileName3)
write.csv(ihs3, file = "rehh_table_ihs_pop-3.csv")

ihsFileName3Png <- paste0("chr-", args[1] , "-rehh_ihs_pop-3.png") 
ihsTitleName3 <- paste0("iHS Population 3 chr " , args[1])
png(filename = ihsFileName3Png)
ihsplot_mod(ihs3, plot.pval = TRUE, ylim.scan=2, main = ihsTitleName3)
dev.off()

#######################
# Rsb
#######################

rsb <- ies2rsb(ehhScan1, ehhScan2, method="bilateral")
rsbTableName <- paste0("chr-", args[1], "-1-2", "-rehh_rsb-bilateral.csv")
write.table(rsb, file = rsbTableName)
#View(rsb)

rsbPngName <- paste0("chr-", args[1] , "-rehh_rsb-1-2-bilateral.png")
png(filename = rsbPngName)
rsbTitle <- paste0("Rsb chr " , args[1], "1 vs 2")
rsbplot_mod(rsb, main = rsbTitle)
dev.off()

rsbSvgName <- paste0("chr-", args[1] , "-rehh_rsb-1-2-bilateral.svg")
svg(filename = rsbSvgName)
rsbTitle <- paste0("Rsb chr " , args[1], "1 vs 2")
rsbplot_mod(rsb, main = rsbTitle)
dev.off()

#######################
# Rsb
#######################

rsb <- ies2rsb(ehhScan2, ehhScan3, method="bilateral")
rsbTableName <- paste0("chr-", args[1] , "-2-3", "-rehh_rsb-bilateral.csv")
write.table(rsb, file = rsbTableName)
#View(rsb)

rsbPngName <- paste0("chr-", args[1] , "-rehh_rsb-2-3-bilateral.png")
png(filename = rsbPngName)
rsbTitle <- paste0("Rsb chr " , args[1], "2 vs 3")
rsbplot_mod(rsb, main = rsbTitle)
dev.off()

rsbSvgName <- paste0("chr-", args[1] , "-rehh_rsb-2-3-bilateral.svg")
svg(filename = rsbSvgName)
rsbTitle <- paste0("Rsb chr " , args[1], "2 vs 3")
rsbplot_mod(rsb, main = rsbTitle)
dev.off()
