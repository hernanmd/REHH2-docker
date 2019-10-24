
setwd("D:\\Huellas_de_Seleccion\\CBBA+CAl")

library(dplyr)
library(rehh)
library(ggplot2)
source("rehh_patches.R")

for(i in 1:29) {
  hapFile1 <- paste0("chr-", i , "rehh_hap_pop-1.txt")
  hapFile2 <- paste0("chr-", i , "rehh_hap_pop-2.txt")
  mapFile <- paste0("chr-", i ,"rehh_map_pop-1.txt")
  data1 <- data2haplohh(
    hap_file = hapFile1, 
    mapFile, 
    chr.name=i,
    # haplotype.in.columns = TRUE, 
    recode.allele = TRUE, 
    # min_maf = 0.1,
    min_perc_geno.hap = 95,
    min_perc_geno.snp = 50)

    data2 <- data2haplohh(
    hap_file = hapFile2, 
    mapFile, 
    chr.name=i,
    # haplotype.in.columns = TRUE, 
    recode.allele = TRUE, 
    # min_maf = 0.1,
    min_perc_geno.hap = 95,
    min_perc_geno.snp = 50)
  
  ehhScan1<-scan_hh(data1)
  ehhScan2<-scan_hh(data2)  
  if(i==1) {
    wg.res1 <- ehhScan1
    wg.res2 <- ehhScan2 }  
  else { 
    wg.res1 <- rbind(wg.res1, ehhScan1)
    wg.res2 <- rbind(wg.res2, ehhScan2)
    }
}

# Set rowname to first column name
wg.res1rm <- tibble::rownames_to_column(wg.res1,"SNPs")
wg.res2rm <- tibble::rownames_to_column(wg.res2,"SNPs")
# Difference between res1 and res2
wg.res1filtered <- wg.res1rm[wg.res1rm$SNPs %in% wg.res2rm$SNPs,]
# Clean row names
rownames(wg.res1filtered) <- c()
wg.res1rm <- tibble::column_to_rownames(wg.res1filtered,"SNPs")

wg.rsb <- ies2rsb(wg.res1rm, wg.res2, method="bilateral")

rsbPngName <- paste0("rsb-wg.png")
png(filename = rsbPngName)
rsbTitle <- paste0("Rsb WGS ")
rsbplot_mod(wg.rsb, main = rsbTitle)
dev.off()	


wg.xpehh <- ies2xpehh(wg.res1rm, wg.res2)

wg.xpehhTableName <- paste0("rehh_wg-xpehh.csv")
write.table(wg.xpehh, file = wg.xpehhTableName)

xpehhPngName <- paste0("xpehh-wg.png")
png(filename = xpehhPngName)
rsbTitle <- paste0("XPEHH WGS ")
xpehhplot(wg.xpehh, main = rsbTitle)
dev.off()	



