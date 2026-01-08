
#!/usr/bin/env bash

# Funannotate gene prediction

docker run --rm -it   -v $(pwd):$(pwd)   -w $(pwd)   nextgenusfs/funannotate:latest funannotate predict   
			-i Gi-margarita-unmasked-FINAL-scaffolds.fasta.masked  
			-o funannotate   -s "Gigaspora margarita"   --strain BEG   --cpus 30   
			--ploidy 1   --repeats2evm   --optimize_augustus   
			--transcript_evidence Gi_margarita_GeneCatalog_transcripts_venice.aa.fasta Gi_margarita_GeneCatalog_CDS_venice.aa.fasta 
									Gigaspora_margarita-cds-transcripts.fa   
			--rna_bam funannotate/training/funannotate_train.coordSorted.bam   
			--pasa_gff funannotate/training/funannotate_train.pasa.gff3   
			--stringtie funannotate/training/funannotate_train.stringtie.gtf   
			--protein_evidence uniprot_sprot.fasta Gi_margarita_GeneCatalog_proteins_venice.aa.fasta Gigaspora_margarita-proteins.fa   
			--weights augustus:4 hiq:6 genemark:1 pasa:10 codingquarry:0 snap:1 glimmerhmm:1 proteins:6 transcripts:6   
			--GENEMARK_PATH /media/eniac/WD1/ken/gigaspora/RNASeq/Stefano/gmes_linux_64_4
