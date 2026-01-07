# Step 1: Build Bowtie2 index
bowtie2-build Gi-margarita-scaffolds.fasta  Gi-margarita --threads 15

# Step 2: Digest genome 
python digest_genome.py -r  A^AGCTT A^GATCT ^GATC ^GATC -o Gi-margarita-unmasked-FINAL-fragments.bed Gi-margarita-unmasked-FINAL-scaffolds.fasta

# Step 3: Generate chr sizes
samtools faidx Gi-margarita-unmasked-FINAL-scaffolds.fasta
cut -f1,2 Gi-margarita-unmasked-FINAL-scaffolds.fasta.fai > Gi-margarita-unmasked-FINAL-scaffolds.sizes

# Step 4: Run Hic Pro using Docker (## see config.txt)
docker run --rm -v "$(pwd)":"$(pwd)" -w "$(pwd)" nservant/hicpro:latest  /HiC-Pro_3.0.0/bin/HiC-Pro -c config.txt -i rawdata -o pro-output

# Step 5: Convert Hi-C pro output to hic for visualization in juicerbox
./HiC-Pro/bin/utils/hicpro2juicebox.sh -i ./pro-output/hic_results/data/sample1/sample1.allValidPairs -g ./Gi-margarita-unmasked-FINAL-scaffolds.sizes -r ./Gi-margarita-unmasked-FINAL-fragments.bed -j ./juicer_tools.jar -o /media/WD3/ken/New-Gigaspora 
