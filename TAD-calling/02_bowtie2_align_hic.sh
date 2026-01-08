# Align Hi-C reads (single-end, HiCExplorer-compatible)

INDEX=Gi-margarita
THREADS=10

bowtie2 \
  --local \
  -x ${INDEX} \
  -U hic-data/gmarg-bmin_1274593_1532815_R1.fastq.gz \
  -S gmarg-bmin_1274593_1532815_R1.sam \
  --reorder \
  -p ${THREADS}

bowtie2 \
  --local \
  -x ${INDEX} \
  -U hic-data/gmarg-bmin_1274593_1532815_R2.fastq.gz \
  -S gmarg-bmin_1274593_1532815_R2.sam \
  --reorder \
  -p ${THREADS}
