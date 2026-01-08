
# Find restriction enzyme cut sites

GENOME=Gi-margarita-unmasked-FINAL-scaffolds.fasta
ENZYMES=("AAGCTT" "GATC" "GGATCC" "CCATGG")

for enzyme in "${ENZYMES[@]}"; do
  hicFindRestSite \
    --fasta ${GENOME} \
    --searchPattern ${enzyme} \
    -o rest_site_positions_${enzyme}.bed
done

cat rest_site_positions_*.bed | \
  sort -k1,1 -k2,2n \
> combined_rest_sites.bed
