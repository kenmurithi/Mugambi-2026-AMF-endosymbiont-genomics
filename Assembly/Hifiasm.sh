```bash
hifiasm -o gigaspora_hifiasm.asm -t25 --n-hap 1 --hg-size 773m \
        --h1 ../gigaspora_reads/gigaspora_hic/results/gmarg-bmin_1274592/HiC/gmarg-bmin_1274593_S3HiC_R1.fastq.gz \
        --h2 ../gigaspora_reads/gigaspora_hic/results/gmarg-bmin_1274592/Hi-C/gmarg-bmin_1274593_S3HiC_R2.fastq.gz \
        ../gigaspora_reads/gigaspora_hifi.fastq.gz
        
awk '$1 == "S" {print ">"$2"\n"$3}' gigaspora_hifiasm.asm.hic.p_ctg.gfa > gigaspora_p_ctg.fasta
mv gigaspora_p_ctg.fasta Gi_marg_hifiasm_contigs.fa
```
