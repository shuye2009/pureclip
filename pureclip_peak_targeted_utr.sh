#!/bin/bash

#working directory: /home/greenblattlab/shuyepu/Nabeel/clip_analysis
treat=$1
DIR=/home/greenblattlab/shuyepu/Nabeel/clip_analysis

outdu=${DIR}/results_output/piranha_crosslink_sites_overlap_${treat}_up_dutr
mkdir -p ${outdu}
outdd=${DIR}/results_output/piranha_crosslink_sites_overlap_${treat}_down_dutr
mkdir -p ${outdd}
outdn=${DIR}/results_output/piranha_crosslink_sites_overlap_${treat}_noChange_dutr
mkdir -p ${outdn}

uregionp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_up_list_putr.bed
uregiond=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_up_list_dutr.bed
uregiondminusp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_up_list_dutrminusputr.bed

dregiond=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_down_list_dutr.bed
dregionp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_down_list_putr.bed
dregiondminusp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_down_list_dutrminusputr.bed

nregiond=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_noChange_list_dutr.bed
nregionp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_noChange_list_putr.bed
nregiondminusp=${DIR}/results_output/GO_results_25_75/PAU_analysis_${treat}_noChange_list_dutrminusputr.bed

perl_command_minus=~/perl_script/subtract_oneBed_from_anotherBed_by_start.pl

if [ ! -e "${uregiondminusp}" ]; then
	${perl_command_minus} ${uregionp} ${uregiond} ${uregiondminusp} # <shortBed> <longBed> <outBed>
fi

if [ ! -e "${dregiondminusp}" ]; then
	${perl_command_minus} ${dregionp} ${dregiond} ${dregiondminusp}
fi

if [ ! -e "${nregiondminusp}" ]; then
	${perl_command_minus} ${nregionp} ${nregiond} ${nregiondminusp}
fi

perl_command=~/perl_script/overlap_oneBed_with_anotherBed_pvalue.pl
subdirs=( "piranha_crosslink_sites_mergedInput" )


for ((i=0; i<${#subdirs[*]}; i++)); do
	wd=${DIR}/data_input/${subdirs[i]}
	cd ${wd}

	for f in *.merge.crosslink_sites_mergedInput.bed; do
		
		echo "processing ${f}"	
		$perl_command ${f} ${uregiond} 0 0 ${outdu} 0.5 # <inputBed> <regionBed> <rExt> <lExt> <outDir> <fractionOverlap>
		$perl_command ${f} ${uregionp} 0 0 ${outdu} 0.5
		$perl_command ${f} ${uregiondminusp} 0 0 ${outdu} 0.5

		$perl_command ${f} ${dregiond} 0 0 ${outdd} 0.5
		$perl_command ${f} ${dregionp} 0 0 ${outdd} 0.5
		$perl_command ${f} ${dregiondminusp} 0 0 ${outdd} 0.5

		$perl_command ${f} ${nregiond} 0 0 ${outdn} 0.5
		$perl_command ${f} ${nregionp} 0 0 ${outdn} 0.5
		$perl_command ${f} ${nregiondminusp} 0 0 ${outdn} 0.5
	
	done
done

