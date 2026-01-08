hicTransform \
  --method pearson \
  -m Gi-margarita_corr_50kb.h5 \
  --outFileName Gi-margarita_pearson_50kb.h5

hicTransform \
  --method obs_exp \
  -m Gi-margarita_corr_50kb.h5 \
  --outFileName Gi-margarita_OE_50kb.h5

hicPCA \
  --matrix Gi-margarita_corr_50kb.h5 \
  --outputFileName \
    Gi-margarita_PC1.bw \
    Gi-margarita_PC2.bw \
    Gi-margarita_PC3.bw \
  --format bigwig \
  --whichEigenvectors 1 2 3 \
  --obsexpMatrix Gi-margarita_OE_50kb.h5 \
  --pearsonMatrix Gi-margarita_pearson_50kb.h5
