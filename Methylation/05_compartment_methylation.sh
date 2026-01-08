
## Integrate CpG methylation with Hi-C compartments (50 kb bins)

BINS=Gi_marg_50kb.bed
CPG=Gi_margarita_total-met-CpG.bed

# ---- Average methylation per 50 kb bin ----
bedtools map \
  -a ${BINS} \
  -b ${CPG} \
  -c 9 \
  -o mean | \
awk 'BEGIN {OFS="\t"} {if ($4 == ".") $4 = 0; print}' \
> Gi_marg_50kb_methylation.bed

# ---- bmin compartments ----
bedtools intersect \
  -a Gi_marg_50kb_methylation.bed \
  -b Gi_margarita-bmin-all-compartments.bed \
  -wa -wb | \
awk '{print $1,$2,$3,$4,$8}' OFS="\t" \
> Gi_marg_bmincomp_50kb_methylation.bed

awk '{sum[$5]+=$4; count[$5]++} END {for (c in sum) print c, sum[c]/count[c]}' \
Gi_marg_bmincomp_50kb_methylation.bed

# ---- bplus compartments ----
bedtools intersect \
  -a Gi_marg_50kb_methylation.bed \
  -b Gi_margarita-bplus-all-compartments.bed \
  -wa -wb | \
awk '{print $1,$2,$3,$4,$8}' OFS="\t" \
> Gi_marg_bpluscomp_50kb_methylation.bed

awk '{sum[$5]+=$4; count[$5]++} END {for (c in sum) print c, sum[c]/count[c]}' \
Gi_marg_bpluscomp_50kb_methylation.bed
