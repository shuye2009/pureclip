#!/bin/bash

reffasta=/home/greenblattlab/shuyepu/GRCH37_gencode/GRCh37.p13.genome.fa

#########################
##    for SP1_2021     ##
#########################
function SP1(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/Input_bam/SP1.Input.merged.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
mkdir -p $outd

## only run for obtaining CLmotif
#submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/SP1.Input.merged_crosslinksites.bed -or ${outd}/SP1.Input.merged_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0

cd $wd
for f in *SP1*.bam; do
	echo $f
	basef=$(basename $f .thUni.bam)
	submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/fimo_clmotif_occurences.bed
	
	submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_woInputwCL.bed -or ${outd}/${basef}_crosslinkregions_woInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/fimo_clmotif_occurences.bed
done
}

#######################
## for CPSF
#######################
function CPSF(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/mergeInput/Input.NUDT21_CPA_merged.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
mkdir -p $outd

if [ 1 -eq 0 ]; then
## only run for obtaining CLmotif
submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/Input.NUDT21_CPA_merged_crosslinksites.bed -or ${outd}/Input.NUDT21_CPA_merged_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0
fi

if [ 1 -eq 0 ];then
cd $wd
for f in CPSF7.A*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 200 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/Input.NUDT21_CPA_merged_crosslinkregions_fimo_clmotif_occurences.bed

        #submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_woInputwCL.bed -or ${outd}/${basef}_crosslinkregions_woInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/fimo_clmotif_occurences.bed
done

fi
}

#############################
## for CPSF7_siSP1
#############################
function CPSF7(){
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CPSF7_siSP1
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CPSF7_siSP1/pureclip_peaks
mkdir -p $outd
cd $wd

if [ 1 -eq 0 ]; then
## only run for obtaining CLmotif
for inputbam in Input_siNT.A.thUni.bam Input_siSP1.A.thUni.bam; do
	basef=$(basename $inputbam .A.theUni.bam)
	submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites.bed -or ${outd}/${basef}_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0
done
fi

if [ 1 -eq 0 ];then
inputbam=Input_siNT.A.thUni.bam
for f in CPSF7_siNT*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/Input_siNT.A.thUni.bam_crosslinkregions_fimo_clmotif_occurences.bed

done

inputbam=Input_siSP1.A.thUni.bam
for f in CPSF7_siSP1*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/Input_siSP1.A.thUni.bam_crosslinkregions_fimo_clmotif_occurences.bed

done

fi
}

#########################
##    for ZNFs     ##
#########################
function ZNFs(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/Input_bam/SP1.Input.merged.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
clmotifd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
mkdir -p $outd

cd $wd
for f in ZNF121*.bam ZNF281*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $clmotifd/fimo_clmotif_occurences.bed

done
}

function ZNF121Gio(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/Gio/CLIP_bam/Input_ZNF121.A.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/Gio/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/Gio/pureclip_peaks
clmotifd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
mkdir -p $outd

cd $wd
for f in ZNF121.D.thUni.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $clmotifd/Input_ZNF121.A_crosslinkregions_fimo_clmotif_occurences.bed

done
}

#######################
##### for YTHDF2 ######
#######################
function YTHDF2(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/Input_bam/Input.YTHDF2.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
mkdir -p $outd

if [ 1 -eq 0 ]; then
## only run for obtaining CLmotif
submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/Input_YTHDF2_crosslinksites.bed -or ${outd}/Input_YTHDF2_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0
fi

# run_make_custom_CLmotif.sh
if [ 1 -eq 0 ];then
cd $wd
for f in YTHDF2*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 200 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $outd/Input_YTHDF2_crosslinkregions_fimo_clmotif_occurences.bed

done

fi
}

#######################
##### for CLIP2021 Input ######
#######################
function Input(){

wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/Input_bam
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
mkdir -p $outd
cd $wd
for input in Input.CPA.A Input.KLF14.A Input.NUDT21.A Input.PPIB.A Input.PRPF31.A Input.SP1.A Input.YY1.A Input.ZFP64.A; do
	## only run for obtaining CLmotif
	inputbam=${input}.thUni.bam
	submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/${input}_crosslinksites.bed -or ${outd}/${input}_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0
done

# run_make_custom_CLmotif.sh
}

#########################
##    for NAT10_2021     ##
#########################
function NAT10(){
inputbam=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/Input_bam/Input.SP1.A.thUni.bam
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/CLIP_bam
cld=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
mkdir -p $outd

## only run for obtaining CLmotif
#submitjob 100 -m 80 pureclip -i $inputbam -bai ${inputbam}.bai -g $reffasta -o ${outd}/SP1.Input.merged_crosslinksites.bed -or ${outd}/SP1.Input.merged_crosslinkregions.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0

cd $wd
for f in NAT10*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -ibam $inputbam -ibai ${inputbam}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_wInputwCL.bed -or ${outd}/${basef}_crosslinkregions_wInputwCL.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4 -fis $cld/fimo_clmotif_occurences.bed

done
}

######################################
### for TDP43     Nov 17, 2021     ###
######################################
function TDP43(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/CLIP_bam
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
cd $wd
for f in TDP43*.bam; do
        echo $f
        basef=$(basename $f .thUni.bam)
	#echo $(wc -l "$reffasta")
	wc -l $reffasta | echo -
#        submitjob 100 -m 80 pureclip -i $f -bai ${f}.bai -g $reffasta -o ${outd}/${basef}_crosslinksites_woInputw.bed -or ${outd}/${basef}_crosslinkregions_woInputw.bed -nt 10 -iv "'chr1;chr2;chr3'" -bc 0 -nim 4

done
}

function select_function(){

	local eval_param=""
	while [[ $# -gt 0 ]]; do
		key="$1"
		case $key in
			-eval | -e)
			eval_param="${@:2}"
			break
			;;
			
			* | -help | -h)
			echo "help message here"
			exit 1
			;;
		esac
		shift  ## move to next argument
	done

	if [[ "${eval_param}" != "" ]]; then
		eval "${eval_param}"
		exit $?
	fi
	return 0
}

function main(){
	select_function "$@"
}

main "$@"


