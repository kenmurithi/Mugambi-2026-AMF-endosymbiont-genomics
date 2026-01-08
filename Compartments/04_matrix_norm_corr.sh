hicNormalize \
  --matrices Gi-margarita_50kb.h5 \
  --normalize norm_range \
  -o Gi-margarita_norm_50kb.h5

hicCorrectMatrix diagnostic_plot \
  --matrix Gi-margarita_norm_50kb.h5 \
  -o diagnostic_50kb.png

hicCorrectMatrix correct \
  --matrix Gi-margarita_norm_50kb.h5 \
  --correctionMethod ICE \
  --filterThreshold -2.5 3.5 \
  --outFileName Gi-margarita_corr_50kb.h5
