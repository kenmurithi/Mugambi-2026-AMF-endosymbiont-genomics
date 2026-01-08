
enzymes=("GATC" "GANTC" "CTNAG" "TTAA")
genome_fasta="Gi-margarita-scaffolds.fasta"

for enzyme in "${enzymes[@]}"; do
    hicFindRestSite \
      --fasta ${genome_fasta} \
      --searchPattern ${enzyme} \
      -o rest_sites_${enzyme}.bed
done

cat rest_sites_*.bed | sort -k1,1 -k2,2n > combined_rest_sites.bed
