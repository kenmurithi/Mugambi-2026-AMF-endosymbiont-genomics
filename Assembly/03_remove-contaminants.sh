
# Step 1: Manually inspect BLAST hits (from diamond-blast.sh)
grep -A 5 "Query="  Gi_marg_hifiasm_contigs.fa_blastx.out | head

# Step 2: Remove contaminant contigs
### The file contaminants2remove.txt contains contig IDs
### identified as non-AMF based on BLASTX results 
seqkit grep -v -f ./BlastOut/conataminants2remove.txt ./Hifiasm/Gi_marg_hifiasm_contigs.fa > Gi_marg_hifiasm_cleaned_contigs.fa
