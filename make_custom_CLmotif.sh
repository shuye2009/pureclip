#!/bin/bash

## create input for dreme according to:
## https://pureclip.readthedocs.io/en/latest/PureCLIPTutorial/customCLmotifs.html#customclmotifs-label
## and run dreme
## and create customCLmotifs for pureclip

refsize=/home/greenblattlab/shuyepu/GRCH37_gencode/GRCh37.p13.genome.fa.size
cmd=/home/greenblattlab/shuyepu/PureCLIP-1.3.1-linux64-static/util/compute_CLmotif_scores.sh
reffasta=/home/greenblattlab/shuyepu/GRCH37_gencode/GRCh37.p13.genome.fa

bedprefix=$1  ## SP1.Input.merged_crosslinksites
inputbam=$2  ##/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/Input_bam/SP1.Input.merged.thUni.bam
wd=$3  ##/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
tmp=$HOME/tmp/$bedprefix
mkdir -p $wd
mkdir -p $tmp

dremed=$wd/dreme_$bedprefix
cd $wd
if [ 1 -eq 1 ]; then
        ## make positive
        bedtools slop -i ${bedprefix}.bed -g $refsize -b 5 | bedtools getfasta -bed stdin -s -name -fi $reffasta -fo ${bedprefix}_slop5b.bed.fa

        ## make negative
        bedtools slop -i ${bedprefix}.bed -g $refsize -b 20 | bedtools flank -i stdin -g $refsize -b 10 | bedtools getfasta -bed stdin -s -name -fi $reffasta -fo ${bedprefix}_slop20b_flank10b.bed.fa
fi

if [ 1 -eq 1 ]; then
        dreme -p ${bedprefix}_slop5b.bed.fa -n ${bedprefix}_slop20b_flank10b.bed.fa -norc -k 6 -m 4 -oc $dremed
fi

if [ 1 -eq 1 ]; then
        export WINEXTRACT=$HOME/bin/winextract
        $cmd $reffasta $inputbam $dremed/dreme.xml $dremed/dreme.txt ${bedprefix}_fimo_clmotif_occurences.bed $tmp
	gzip ${bedprefix}_fimo_clmotif_occurences.bed
fi

