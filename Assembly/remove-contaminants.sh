





grep -A 5 "Query=" gigaspora_canu_blastx.out | head
seqkit grep -v -f ./BlastOut/conataminants2remove.txt ./Hifiasm/Gi_marg_hifiasm_contigs.fa > Gi_marg_hifiasm_cleaned_contigs.fa
