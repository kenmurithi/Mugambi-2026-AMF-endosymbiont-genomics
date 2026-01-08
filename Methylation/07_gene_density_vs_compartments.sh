#!/bin/bash

# Gene density per Hi-C compartment (50 kb bins)

BINS=Gi_marg_50kb.bed
GENES=Gi_marg_genes.bed

# ---- Count genes per bin ----
bedtools intersect \
  -a ${BINS} \
  -b ${GENES} \
  -c \
> Gi_marg_50kbgenes.bed

# ---- bmin compartments ----
bedtools intersect \
  -a Gi_marg_50kbgenes.bed \
  -b Gi_margarita-bmin-all-compartments.bed \
  -wa -wb | \
awk '{print $1,$2,$3,$4,$8}' OFS="\t" \
> Gi_marg_bmincomp_50kbgenes.bed

awk '{sum[$5]+=$4; count[$5]++} END {for (c in sum) print c, sum[c]/count[c]}' \
Gi_marg_bmincomp_50kbgenes.bed

