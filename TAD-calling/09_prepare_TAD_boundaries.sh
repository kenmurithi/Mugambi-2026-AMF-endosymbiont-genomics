# Expand TAD boundaries for downstream analysis

bedtools slop \
  -i gmarg-bmin-bplus_all_bonferroni_30kb_boundaries.bed \
  -g Gi-margarita-unmasked-FINAL-scaffolds.sizes \
  -b 50000 \
> TAD_boundaries_50kb.bed
