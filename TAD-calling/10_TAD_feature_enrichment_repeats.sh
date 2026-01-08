# Repeat enrichment around TAD boundaries

bedtools intersect \
  -a gmarg_genome_windows.bed \
  -b gmarg_repeats.bed \
  -c \
> gmarg_repeat_density_per_window.bed

LC_COLLATE=C sort \
  -k1,1 -k2,2n \
  gmarg_repeat_density_per_window.bed \
> gmarg_repeat_density_per_window.sorted.bed

awk 'BEGIN{OFS="\t"}{mid=int(($2+$3)/2); print $1,mid-1,mid,$4}' \
  gmarg_all_30kb_boundaries.bed \
> boundary_centers.bed

computeMatrix reference-point \
  -S TE_coverage.bw \
  -R boundary_centers.bed \
  --referencePoint center \
  -b 50000 -a 50000 \
  --missingDataAsZero \
  --sortRegions keep \
  -o TE_boundary_matrix.gz

plotProfile \
  -m TE_boundary_matrix.gz \
  -out TE_boundary_profile.png \
  --perGroup \
  --refPointLabel Boundary \
  --startLabel Upstream \
  --endLabel Downstream \
  --plotWidth 7 \
  --plotHeight 6 \
  --legendLocation upper-right
