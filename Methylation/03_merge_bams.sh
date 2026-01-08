# Merge aligned BAM files

THREADS=30

samtools merge \
  -@ ${THREADS} \
  gigaspora_aligned_merged_bc2025_bc2026.bam \
  gigaspora_aligned_bc2025.bam \
  gigaspora_aligned_bc2026.bam
