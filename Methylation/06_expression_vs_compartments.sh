## Integrate ERM expression with Hi-C compartments (50 kb bins)

BINS=Gi_marg_50kb.bed
EXPR=ERM_logTpm.bed

# ---- Average expression per 50 kb bin ----
bedtools map \
  -a ${BINS} \
  -b ${EXPR} \
  -c 5 \
  -o mean | \
awk 'BEGIN {OFS="\t"} {if ($4 == ".") $4 = 0; print}' \
> Gi_marg_50kbErmTPM.bed

# ---- bmin compartments ----
bedtools intersect \
  -a Gi_marg_50kbErmTPM.bed \
  -b Gi_margarita-bmin-all-compartments.bed \
  -wa -wb | \
awk '{print $1,$2,$3,$4,$8}' OFS="\t" \
> Gi_marg_bmincomp_50kbTPM.bed

awk '{sum[$5]+=$4; count[$5]++} END {for (c in sum) print c, sum[c]/count[c]}' \
Gi_marg_bmincomp_50kbTPM.bed
