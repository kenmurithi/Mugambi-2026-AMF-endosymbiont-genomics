BAM=gigaspora_aligned_merged_bc2025_bc2026.bam
PREFIX=Gi_margarita
THREADS=30

pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores \
  --bam ${BAM} \
  --output-prefix ${PREFIX} \
  --model pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite \
  --threads ${THREADS} \
  --min-mapq 0 \
  --min-coverage 10

# Keep methylated CpG sites only
awk '$9 > 0.0' ${PREFIX}-total-CpG.bed \
  > ${PREFIX}_total-met-CpG.bed
