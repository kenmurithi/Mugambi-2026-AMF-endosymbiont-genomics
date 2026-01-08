## Step 1: Hi-C read alignment

#The *G. margarita* scaffolds were indexed using Bowtie2, and Hi-C reads were aligned independently for read 1 and read 2 using local alignment.

bowtie2-build Gi-margarita-scaffolds.fasta Gi-margarita --threads 15

bowtie2 --local -x Gi-margarita -U HiC_R1.fastq.gz -S R1.sam --reorder -p 15

bowtie2 --local -x Gi-margarita -U HiC_R2.fastq.gz -S R2.sam --reorder -p 15
