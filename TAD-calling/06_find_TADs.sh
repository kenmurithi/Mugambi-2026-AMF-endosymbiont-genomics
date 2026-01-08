# Identify TADs using HiCExplorer

hicFindTADs \
  --matrix gmarg-bmin_1274593_1532815_30kb.h5 \
  --outPrefix TADS_gmarg-bmin_1274593_1532815_30kb \
  --correctForMultipleTesting bonferroni \
  --thresholdComparisons 0.01 \
  --numberOfProcessors 10 \
