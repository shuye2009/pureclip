#!/bin/bash
cmd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/pureclip/homer_annotatePeaks.sh

if [ 1 -eq 0 ]; then
	wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
	plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/plots/piecharts
	mkdir -p $plotd
	cd $wd
	bed=ZNF121_ABC_crosslinkregions_wInputwCL.bed
	dataName=ZNF121_ABC
	submitjob -m 20 $cmd $bed $wd $plotd $dataName
	
	wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
	plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/plots/piecharts
	mkdir -p $plotd
	cd $wd
	bed=YTHDF2_AB_crosslinkregions_wInputwCL.bed
	dataName=YTHDF2_AB
	submitjob -m 20 $cmd $bed $wd $plotd $dataName
fi

if [ 1 -eq 0 ]; then
	wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZNF281_CITS_crosslinkSite
	plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/plots/piecharts
	mkdir -p $plotd
	cd $wd
	bed=combined_crosslink_ZNF281.uniq.bed
	dataName=ZNF281_combined
	submitjob -m 20 $cmd $bed $wd $plotd $dataName

fi

if [ 1 -eq 0 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZBTB48_CITS_crosslinkSite
        plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZBTB48_CITS_crosslinkSite/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=combined_CITS_0.01_ZBTB48.merged.bed
        dataName=ZBTB48_combined
        $cmd $bed $wd $plotd $dataName

fi

if [ 1 -eq 0 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZNF121_CITS_crosslinkSite
        plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZNF121_CITS_crosslinkSite/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=combined_CITS_0.01_ZNF121.recurring.bed
        dataName=ZNF121_CITS_recurring
        $cmd $bed $wd $plotd $dataName

fi

## putative M6A and m6Am from m6AHek
if [ 1 -eq 0 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/m6AHek_CITS_crosslinkSite
        plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/m6AHek_CITS_crosslinkSite/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=combined_CITS_0.01_m6AHek.merged_DRACH_slopl2r2.bed
        dataName=Hek_m6A
        $cmd $bed $wd $plotd $dataName

	bed=putative_m6Am_sites_from_m6AHek_CITS.bed
        dataName=Hek_m6Am
        $cmd $bed $wd $plotd $dataName
fi

## FTO clip
if [ 1 -eq 1 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/FTO_CITS_crosslinkSite
        plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/FTO_CITS_crosslinkSite/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=combined_CITS_0.01_FTO.merged.bed
        dataName=FTO_CITS_merged
        $cmd $bed $wd $plotd $dataName
fi

## FTO clip
if [ 1 -eq 1 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZBTB48_CITS_crosslinkSite
        plotd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_cits/ZBTB48_CITS_crosslinkSite/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=combined_CITS_0.01_ZBTB48.merged.bed
        dataName=ZBTB48_CITS_merged
        $cmd $bed $wd $plotd $dataName
fi


## ZBTB48 ChIPseq summit peaks
if [ 1 -eq 0 ]; then
        wd=/home/greenblattlab/shuyepu/Nabeel/ChIPseq/Greenblatt_Oct072019/data_input/chipseq_bam
        plotd=/home/greenblattlab/shuyepu/Nabeel/ChIPseq/Greenblatt_Oct072019/data_input/chipseq_bam/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=ZBTB48_ChIPseq_summits.bed
        dataName=ZBTB48_ChIPseq
        $cmd $bed $wd $plotd $dataName
fi


## ZNF281 ChIPseq summit peaks
if [ 1 -eq 0 ]; then
        wd=/home/greenblattlab/shuyepu/Nujhat/ChIPseq/ZNF768_684_281/GREENBLATT/macs2_results
        plotd=/home/greenblattlab/shuyepu/Nujhat/ChIPseq/ZNF768_684_281/GREENBLATT/macs2_results/homer_annot
        mkdir -p $plotd
        cd $wd
        bed=ZNF281_ChIPseq_summits.bed
        dataName=ZNF281_ChIPseq
        $cmd $bed $wd $plotd $dataName
fi



