#!/bin/bash

# Align PacBio HiFi reads to reference

REF_MMI=Gi-margarita-unmasked-FINAL-scaffolds.fasta.mmi
THREADS=15

pbmm2 align \
  -J ${THREADS} \
  --preset CCS \
  --sort \
  ${REF_MMI} \
  Kin_Chan_m84134_240705_202127_s1.hifi_reads.bc2026.bam \
  gigaspora_aligned_bc2026.bam

pbmm2 align \
  -J ${THREADS} \
  --preset CCS \
  --sort \
  ${REF_MMI} \
  Kin_Chan_m84134_240705_202127_s1.hifi_reads.bc2025.bam \
  gigaspora_aligned_bc2025.bam
