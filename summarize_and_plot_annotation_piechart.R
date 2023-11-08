 
library(ggpubr)
library(plyr)
library(magrittr)

args = commandArgs(trailingOnly=TRUE)

inputfile <- args[1] ##"SP1_S2S3E_peaks_count_table_0_100.tab"
wd <- args[2] ##"C:\\RSYNC\\Nabeel\\clip_analysis\\SP1_2021"
plotd <- args[3]
target <- args[4]

setwd(wd)
total_table <- read.delim(inputfile, header=T, sep="\t")
geneType_count <- as.data.frame(t(data.frame(as.list(table(total_table$GeneType)))))
geneType_count <- mutate(geneType_count, geneType=rownames(geneType_count))
colnames(geneType_count) <- c("peakCount", "geneType")
geneType_count <- mutate(geneType_count, Percentage=peakCount*100/sum(peakCount))

## plot peak count in all gene types 
p <- ggbarplot(geneType_count, x="geneType", y="Percentage", fill="geneType", color="geneType", palette="ucscgb",
        xlab=FALSE, main=inputfile) %>%
        ggpar(legend="none", x.text.angle=45) +
        grids(axis="y", linetype = "dashed")

ggexport(p, filename=file.path(plotd, paste(target,"_peak_annotation_barchart_geneType.pdf", sep="")))
write.table(geneType_count, file.path(plotd, paste(target,"_peak_geneType_table_for_barchart.tab", sep="")), col.names=NA, sep="\t", quote=F)

## plot peak count in all feature types of protein-coding genes
protein_coding_table <- total_table[total_table$GeneType=="protein-coding",]

feature_info <- protein_coding_table$Feature
feature_name <- unlist(lapply(feature_info, function(x) strsplit(as.character(x), split="\\s+")[[1]][1]))

featureType_count <- as.data.frame(t(data.frame(as.list(table(feature_name))))) %>%
        mutate(featureType=c("3'UTR", "5'UTR", "CDS", "Intron","Non-coding", "Promoter", "TES")) 
colnames(featureType_count) <- c("peakCount", "featureType")
featureType_count <- mutate(featureType_count, Percentage=round(peakCount*100/sum(peakCount)))
labs <- paste(featureType_count$Percentage,"%",sep="")
p <- ggpie(featureType_count, x="Percentage", label=labs, lab.pos="out", fill="featureType", color="white", palette="ucscgb")

ggexport(p, filename=file.path(plotd, paste(target,"_peak_annotation_piechart_allFeatureType.pdf", sep="")))

write.table(featureType_count, file.path(plotd, paste(target,"_peak_allFfeatureType_table_for_piechart.tab", sep="")), col.names=NA, sep="\t", quote=F)

## plot peak count in selected feature types of protein-coding genes
ann_table <- featureType_count[featureType_count$featureType %in% c("Promoter", "5'UTR", "CDS", "3'UTR", "TES"),] %>%
	mutate(Percentage=round(peakCount*100/sum(peakCount)))
	
labs <- paste(ann_table$Percentage,"%",sep="")
p <- ggpie(ann_table, x="Percentage", label=labs, lab.pos="out", fill="featureType", color="white", palette="ucscgb")

ggexport(p, filename=file.path(plotd, paste(target,"_peak_annotation_piechart_featureType.pdf", sep=""))) 

write.table(ann_table, file.path(plotd, paste(target,"_peak_featureType_table_for_piechart.tab", sep="")), col.names=NA, sep="\t", quote=F)

###################### Extract gene names in each feature type ####################################################

protein_coding_genes <- cbind(protein_coding_table[, c("GeneName", "Entrez", "Refseq", "Ensembl", "Description")], feature_name)
protein_coding_genes_n <- aggregate(list(nPeaks=rep(1, nrow(protein_coding_genes))), protein_coding_genes, length)
write.table(protein_coding_genes_n, file.path(plotd, paste(target,"_peak_targeted_genes.tab", sep="")), row.names=FALSE, sep="\t", quote=F)


## END
