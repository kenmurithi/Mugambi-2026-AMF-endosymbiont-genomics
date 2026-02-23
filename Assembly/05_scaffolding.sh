#!/usr/bin/env bash
# Step 1: Run *arima-pipeline.sh* to obtain the BED file needed for YAHS.

#s Step 2: Scaffolding
yahs -e GATC,GANTC,CTNAG,TTAA  Gi_marg_hifiasm_cleaned_contigs.fa ./deduplicated/files/gigaspora_Canu_bmin_HiC_rep1.bed
