#!/usr/bin/env bash

# Funannotate training for Gigaspora genome

docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) nextgenusfs/funannotate:latest funannotate train 
-i Gi-margarita-unmasked-FINAL-scaffolds.fasta.masked 
-o fun 
--left Bmin-MYC4_N_R1.fastq Bmin-MYC5_N_R1.fastq Bmin-MYC7_N_R1.fastq Bpos-BUNYW_R1.fastq Bpos-BUNYX_R1.fastq Bpos-BUNYY_R1.fastq 
       Bpos-BUOAC_R1.fastq Bpos-BUOAG_R1.fastq Bpos-BUOAH_R1.fastq Bpos-MYC5_P_R1.fastq Bpos-MYC7_P_R1.fastq Bpos_MYC1-P_R1.fastq 
--right Bmin-MYC4_N_R2.fastq Bmin-MYC5_N_R2.fastq Bmin-MYC7_N_R2.fastq Bpos-BUNYW_R2.fastq Bpos-BUNYX_R2.fastq Bpos-BUNYY_R2.fastq 
        Bpos-BUOAC_R2.fastq Bpos-BUOAG_R2.fastq Bpos-BUOAH_R2.fastq Bpos-MYC5_P_R2.fastq Bpos-MYC7_P_R2.fastq Bpos_MYC1-P_R2.fastq 
--stranded RF 
--jaccard_clip 
--species "Gigaspora margarita" 
--strain BEG 
--cpus 20 
--no_trimmomatic 
--memory 100G 
