#!/bin/bash

## CLmotifs are used as a covariate for pureclip peak calling
cmd=$HOME/Nabeel/clip_analysis/scripts_program/pureclip/make_custom_CLmotif.sh

## for SP1 Input
if [ 1 -eq 0 ]; then
bedprefix=SP1.Input.merged_crosslinksites
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/Input_bam/SP1.Input.merged.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks

submitjob -m 20 $cmd $bedprefix $inputbam $wd
fi

## for CPSF Input
if [ 1 -eq 0 ]; then
bedprefix=Input.NUDT21_CPA_merged_crosslinkregions
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/mergeInput/Input.NUDT21_CPA_merged.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks

submitjob -m 20 $cmd $bedprefix $inputbam $wd
fi

## for CPSF_siSP1
if [ 1 -eq 0 ]; then
for treat in siNT siSP1;do
	bedprefix=Input_${treat}.A.thUni.bam_crosslinkregions
	inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CPSF7_siSP1/Input_${treat}.A.thUni.bam
	wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CPSF7_siSP1/pureclip_peaks

	submitjob -m 20 $cmd $bedprefix $inputbam $wd
done
fi

## for YTHDF2 Input
if [ 1 -eq 0 ]; then
bedprefix=Input_YTHDF2_crosslinkregions
inputbam=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/Input_bam/Input.YTHDF2.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks

submitjob -m 20 $cmd $bedprefix $inputbam $wd
fi

## for ZNF121 Input
if [ 1 -eq 0 ]; then
bedprefix=Input_ZNF121.A_crosslinkregions
inputbam=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/Input_bam/Input_ZNF121.A.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks

submitjob -m 20 $cmd $bedprefix $inputbam $wd
fi

## for NXF1 Input
if [ 1 -eq 0 ]; then
bedprefix=Input.NXF1.A_crosslinkregions
inputbam=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/Input_bam/Input.NXF1.A.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks

submitjob -m 20 $cmd $bedprefix $inputbam $wd
fi

## for all Input
if [ 1 -eq 1 ]; then
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
cd $wd
for f in $(ls Input_G3BP1_crosslinkregions.bed Input.YY1.A_crosslinkregions.bed);do
        bamprefix=$(basename $f _crosslinkregions.bed)
	bedprefix=$(basename $f .bed)
        inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/Input_bam/${bamprefix}.thUni.bam

        $cmd $bedprefix $inputbam $wd
done
fi
