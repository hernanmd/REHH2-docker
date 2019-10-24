library(dplyr)
library(rehh)
library(ggplot2)
source("rehh_patches.R")

args<-commandArgs(TRUE)
chr <- args[1]

for(i in 1:chr) {
		hapFile <- paste0("chr-", i , "-rehh_hap_pop-1.txt")
		mapFile <- paste0("chr-", i ,"-rehh_map_pop-1.txt")
		data <- data2haplohh(
				hap_file = hapFile, 
				mapFile, 
				chr.name=i
				# haplotype.in.columns = TRUE, 
				# recode.allele = TRUE, 
				# min_maf = 0.1,
				# min_perc_geno.hap = 95,
				# min_perc_geno.snp = 50
				)
		res <- scan_hh(data)
		if (i == 1) 
			wg.res <- res
		else 
			wg.res <- rbind(wg.res, res) 
		}
	wg.ihs <- ihh2ihs(wg.res, freqbin=0.5)
	
ihsFileNamePng <- paste0("wgs-rehh_ihs_pop-1.png") 
ihsTitleName <- paste0("WGS iHS Population 1")
png(filename = ihsFileNamePng)
ihsplot_mod(wg.ihs, plot.pval = TRUE, ylim.scan=2, main = ihsTitleName)
dev.off()	

for(i in 1:chr) {
		hapFile <- paste0("chr-", i , "-rehh_hap_pop-2.txt")
		mapFile <- paste0("chr-", i ,"-rehh_map_pop-2.txt")
		data <- data2haplohh(
				hap_file = hapFile, 
				mapFile, 
				chr.name=i
				# haplotype.in.columns = TRUE, 
				# recode.allele = TRUE, 
				# min_maf = 0.1,
				# min_perc_geno.hap = 95,
				# min_perc_geno.snp = 50
				)
		res <- scan_hh(data)
		if (i == 1) 
			wg.res <- res
		else 
			wg.res <- rbind(wg.res, res) 
		}
	wg.ihs <- ihh2ihs(wg.res, freqbin=0.5)
	
ihsFileNamePng <- paste0("wgs-rehh_ihs_pop-2.png") 
ihsTitleName <- paste0("WGS iHS Population 2")
png(filename = ihsFileNamePng)
ihsplot_mod(wg.ihs, plot.pval = TRUE, ylim.scan=2, main = ihsTitleName)
dev.off()	
	 