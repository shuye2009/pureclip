#!/bin/bash

#

peakbeds=$1
dataName=$2
wd=$3
outd=$4
inputpeakbed=$5
percent=$6

if [ -z $percent ]; then percent=10; fi

cd $wd

## 1. combine replicates into one bed file
merge_beds.sh $peakbeds ${dataName}_peaks $percent

## 2. discover motif
dremeCMD=$HOME/Nabeel/clip_analysis/scripts_program/pureclip/crosslinksites_to_dreme_motif.sh
$dremeCMD ${dataName}_peaks_top${percent}percent.bed $inputpeakbed

## 3. annotate with GenomicPlot
#homerCMD=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/pureclip/homer_annotatePeaks.sh
#$homerCMD ${dataName}_peaks_top${percent}percent.bed $wd $outd $dataName
annotCMD=$HOME/HEATMAP/run_plot_peak_annotation.R
Rscript $annotCMD ${dataName}_peaks_top${percent}percent.bed \
	${dataName}_peaks_top${percent}percent \
	$outd \
	${dataName}_peaks_top${percent}percent_annotation

## 4. metagene plot in gene parts
#convert_bedWithScore_to_bigwig.sh ${dataName}_peaks.bed
#deeptoolsCMD=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/CLIP_signal/deepTools_computeMatrix_geneParts.sh
#$deeptoolsCMD ${dataName}_peaks.bw $wd
#rplotCMD=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/CLIP_signal/plot_profile_geneParts_se.R
#Rscript $rplotCMD ${dataName}_peaks.bw $wd $outd $dataName ${dataName}_peaks TRUE

plotCMD=$HOME/HEATMAP/run_plot_5parts_metagene.R
Rscript $plotCMD ${dataName}_peaks_top${percent}percent.bed \
        ${dataName}_peaks_top${percent}percent \
        $outd
