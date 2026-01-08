hicBuildMatrix \
  --samFiles R1.sam R2.sam \
  --outFileName Gi-margarita.h5 \
  --QCfolder qc_reports \
  --binSize 10000 15000 20000 25000 30000 40000 \
  --minMappingQuality 10 \
  --restrictionCutFile combined_rest_sites.bed \
  --restrictionSequence GATC GAATC GAGTC GATTC GACTC CTAAG CTGAG CTTAG CTCAG TTAA \
  --danglingSequence GATC AAT AGT ATT ACT TAA TGA TTA TCA TA \
  --threads 30
