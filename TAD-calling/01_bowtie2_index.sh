# Build Bowtie2 index for reference

REF=Gi-margarita-unmasked-FINAL-scaffolds.fasta
PREFIX=Gi-margarita
THREADS=15

bowtie2-build \
  ${REF} \
  ${PREFIX} \
  --threads ${THREADS}
