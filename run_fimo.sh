#!/bin/bash

wd=/home/greenblattlab/shuyepu/Nabeel/clip_analysis/data_input/SP1_2021/pureclip_peaks
cd $wd

#submitjob -m 20 fimo --thresh 0.001 --text --norc --parse-genomic-coord --motif DGGDRG dreme_SP1_S2S3Ecombined_crosslinkregions_wInputwCL/dreme.txt SP1_S2S3Ecombined_crosslinkregions_wInputwCL_slop5b.bed.fa \> fimo_SP1_S2S3Ecombined_self.tsv

#submitjob -m 50 fimo --thresh 0.001 --text --norc --parse-genomic-coord --motif DGGDRG --max-stored-scores 500000000 dreme_SP1_S2S3Ecombined_crosslinkregions_wInputwCL/dreme.txt $HOME/GRCH37_gencode/GRCh37.p13.genome.fa \> fimo_SP1_S2S3Ecombined_genome.tsv

#awk 'BEGIN{FS=OFS="\t"}{print $3,$4,$5,$10,$8,$6}' fimo_SP1_S2S3Ecombined_self.tsv | sort -T ./ -k1,1 -k2,2n > fimo_SP1_S2S3Ecombined_self.bed
#awk 'BEGIN{FS=OFS="\t"}{print $3,$4,$5,$10,$8,$6}' fimo_SP1_S2S3Ecombined_genome.tsv | sort -T ./ -k1,1 -k2,2n > fimo_SP1_S2S3Ecombined_genome.bed

bedtools intersect -a SP1_S2S3Ecombined_crosslinkregions_wInputwCL.bed -b fimo_SP1_S2S3Ecombined_self.bed -s -c | awk 'BEGIN{FS=OFS="\t"}{if($7 > 0){print $0}}' > SP1_S2S3Ecombined_crosslinkregions_wInputwCL_DGGDRG.bed
