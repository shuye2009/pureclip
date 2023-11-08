#!/bin/bash

cmd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/scripts_program/pureclip/peak_processing_pipeline.sh

function YTHDF2(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
peaks=YTHDF2.A_crosslinkregions_wInputwCL.bed,YTHDF2.B_crosslinkregions_wInputwCL.bed
dataName=YTHDF2_AB
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/plots
input=Input_YTHDF2_crosslinkregions.bed
percent=20
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd $input $percent
}

function ZNF121Gio(){
wd=/home/greenblattlab/shuyepu/Nabeel/Gio/pureclip_peaks
peaks=ZNF121.A_crosslinkregions_wInputwCL.bed,ZNF121.B_crosslinkregions_wInputwCL.bed,ZNF121.C_crosslinkregions_wInputwCL.bed,ZNF121.D_crosslinkregions_wInputwCL.bed,ZNF121.E_crosslinkregions_wInputwCL.bed
dataName=ZNF121_ABCDE
outd=/home/greenblattlab/shuyepu/Nabeel/Gio/plots
input=Input_ZNF121.A_crosslinkregions.bed
percent=20
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd $input $percent
}

function ZNF121(){
wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/pureclip_peaks
peaks=ZNF121.A_crosslinkregions_wInputwCL.bed,ZNF121.B_crosslinkregions_wInputwCL.bed,ZNF121.C_crosslinkregions_wInputwCL.bed
dataName=ZNF121_ABC
outd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/plots
input=SP1.Input.merged_crosslinkregions.bed
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd $input
}

function NAT10(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
peaks=NAT10.A_crosslinkregions_wInputwCL.bed,NAT10_crosslinkregions_wInputwCL.bed
dataName=NAT10_AB
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/plots
input=SP1.Input.merged_crosslinkregions.bed
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd $input
}

function TDP43(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/pureclip_peaks
peaks=TDP43.A_crosslinkregions_woInputw.bed,TDP43.B_crosslinkregions_woInputw.bed
dataName=TDP43_AB
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/plots
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd
}

function TDP43_ChIP(){
wd=/home/greenblattlab/shuyepu/Nabeel/ChIPseq/TDP43_download
peaks=GSE92026_ENCFF599JWP_conservative_idr_thresholded_peaks_hg19.bed
dataName=TDP43_ChIP_conservative
outd=/home/greenblattlab/shuyepu/Nabeel/ChIPseq/TDP43_download/plots
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd
}

function m6A_ZBTB48(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/CLIP_cits/CITS_m6A_ZBTB48
peaks=m6A_ZBTB48_S1.thUni.tag.CITS.0.05.bed,m6A_ZBTB48_S2.thUni.tag.CITS.0.05.bed
dataName=m6A_ZBTB48_S12
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/plots
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd
}

function ZBTB48m6A(){
wd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/CLIP_cits/CITS_ZBTB48m6A
peaks=ZBTB48m6A.S1.thUni.tag.CITS.0.05.bed,ZBTB48m6A.S2.thUni.tag.CITS.0.05.bed
dataName=ZBTB48m6A_S12
outd=/home/greenblattlab/shuyepu/Nabeel/CLIP2021/plots
mkdir -p $outd

submitjob -m 20 $cmd $peaks $dataName $wd $outd
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

