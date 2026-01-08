# Build Hi-C contact matrix

hicBuildMatrix \
  --samFiles \
    gmarg-bmin_1274593_1532815_R1.sam \
    gmarg-bmin_1274593_1532815_R2.sam \
  --outFileName gmarg-bmin_1274593_1532815.h5 \
  --QCfolder gmarg-bmin_1274593_1532815-qc_reports \
  --minMappingQuality 10 \
  --restrictionCutFile combined_rest_sites.bed \
  --restrictionSequence \
    GATC GAATC GAGTC GATTC GACTC CTAAG CTGAG CTTAG CTCAG TTAA \
  --danglingSequence \
    GATC AAT AGT ATT ACT TAA TGA TTA TCA TA \
  --binSize 10000 15000 20000 25000 30000 40000 \
  --threads 20
