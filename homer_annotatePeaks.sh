#!/bin/bash
scriptd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/pureclip
gtf=/home/greenblattlab/shuyepu/GRCH37_gencode/gencode.v19.annotation.gtf
fasta=/home/greenblattlab/shuyepu/GRCH37_gencode/GRCh37.p13.genome.fa

inbed=$1
wd=$2 ##/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
cd $wd
plotd=$3
dataName=$4

prefix=$(basename $inbed .bed)

# annotate with gencode genome and gtf
#annotatePeaks.pl SP1_S2S3E_crosslinkregions_wInputwCL.bed $fasta -organism human -gtf $gtf -size 10 -norevopp -annStats SP1_S2S3E_crosslinkregions_wInputwCL_annotation_stats_gencode.txt > SP1_S2S3E_crosslinkregions_wInputwCL_annotation_gencode.txt

# annotate with Homer genome and annotation, which is ucsc hg19
annotatePeaks.pl $inbed hg19 -size 5 -norevopp -annStats ${prefix}_annotation_stats_ucsc.txt > ${prefix}_annotation_ucsc.txt

# find genes a peak falls in. Homer associate peak with promoter, promoter with gene
annotate_refseq_genes.pl $dataName ${prefix}_annotation_ucsc.txt $wd

# make a piechart of peak distribution within Promoter, 5'UTR, CDS, 3'UTR and TES
#Rscript $scriptd/plot_annotation_piechart.R SP1_S2S3E_crosslinkregions_wInputwCL_annotation_stats_ucsc.txt $wd /home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/plots/piechart SP1_S2S3E

Rscript $scriptd/summarize_and_plot_annotation_piechart.R ${prefix}_annotation_ucsc_description.txt $wd $plotd $dataName

mv *_ucsc*.txt $plotd
