#! /bin/bash

##############################################
# ARIMA GENOMICS MAPPING PIPELINE 07/26/2025 #
##############################################


##########################################
# Commands #
##########################################

SRA='gmarg-1274593-1274591-1532815_1530194'
LABEL='gmarg-1274593-1274591-1532815_1530194'
BWA='/home/eniac/miniconda3/bin/bwa'
SAMTOOLS='/home/eniac/miniconda3/bin/samtools'
IN_DIR='/media/eniac/WD2/gigaspora_reads/gigaspora_hic/results'
REF='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/Gi_marg_hifiasm_contigs.fa'
FAIDX='$REF.fai'
PREFIX='Gi_marg_hifiasm_contigs.fa'
RAW_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline'
FILT_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/filt_dir'
FILTER='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/filter_five_end.pl'
COMBINER='/media/eniac/Storage1/catrina/arima_pipeline/arima_combiner.pl'
STATS='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/get_stats.pl'
PICARD='/home/eniac/picard/build/libs/picard.jar'
TMP_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/temp'
PAIR_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/paired'
REP_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/dedup'
REP_LABEL=${LABEL}_rep1
MERGE_DIR='/media/eniac/WD2/gigaspora_hifiasm2/Arima-pipeline/merged'
MAPQ_FILTER=10
CPU=15

echo "### Step 0: Check output directories' existence & create them as needed"
[ -d $RAW_DIR ] || mkdir -p $RAW_DIR
[ -d $FILT_DIR ] || mkdir -p $FILT_DIR
[ -d $TMP_DIR ] || mkdir -p $TMP_DIR
[ -d $PAIR_DIR ] || mkdir -p $PAIR_DIR
[ -d $REP_DIR ] || mkdir -p $REP_DIR
[ -d $MERGE_DIR ] || mkdir -p $MERGE_DIR

echo "### Step 0: Index reference - DONE" # Run only once! Skip this step if you have already generated BWA index files
$BWA index -a bwtsw -p $PREFIX $REF

echo "### Step 1.A: FASTQ to BAM (1st)"
$BWA mem -t $CPU $REF $IN_DIR/${SRA}_R1.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/${SRA}_1.bam

echo "### Step 1.B: FASTQ to BAM (2nd)"
$BWA mem -t $CPU $REF $IN_DIR/${SRA}_R2.fastq.gz | $SAMTOOLS view -@ $CPU -Sb - > $RAW_DIR/${SRA}_2.bam

echo "### Step 2.A: Filter 5' end (1st)"
$SAMTOOLS view -h $RAW_DIR/${SRA}_1.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/${SRA}_1.bam

echo "### Step 2.B: Filter 5' end (2nd)"
$SAMTOOLS view -h $RAW_DIR/${SRA}_2.bam | perl $FILTER | $SAMTOOLS view -Sb - > $FILT_DIR/${SRA}_2.bam

echo "### Step 3A: Pair reads & mapping quality filter"
perl $COMBINER $FILT_DIR/${SRA}_1.bam $FILT_DIR/${SRA}_2.bam $SAMTOOLS $MAPQ_FILTER | $SAMTOOLS view -bS -t $FAIDX - | $SAMTOOLS sort -@ $CPU -o $TMP_DIR/$SRA.bam -

echo "### Step 3.B: Add read group"
java -Xmx4G -Djava.io.tmpdir=temp/ -jar $PICARD AddOrReplaceReadGroups INPUT=$TMP_DIR/$SRA.bam OUTPUT=$PAIR_DIR/$SRA.bam ID=$SRA LB=$SRA SM=$LABEL PL=ILLUMINA PU=none

###############################################################################################################################################################
###                                           How to Accommodate Technical Replicates                                                                       ###
### This pipeline is currently built for processing a single sample with one read1 and read2 FASTQ file.                                                    ###
### Technical replicates (eg. one library split across multiple lanes) should be merged before running the MarkDuplicates command.                          ###
### If this step is run, the names and locations of input files to subsequent steps will need to be modified in order for subsequent steps to run correctly.###
### The code below is an example of how to merge technical replicates.                                                                                      ###
###############################################################################################################################################################
#       REP_NUM=X # number of the technical replicate set e.g. 1
#       REP_LABEL=${LABEL}_rep$REP_NUM
#       INPUTS_TECH_REPS=('bash' 'array' 'of' 'bams' 'from' 'replicates') # BAM files you want combined as technical replicates
#   example bash array - INPUTS_TECH_REPS=('INPUT=A.L1.bam' 'INPUT=A.L2.bam' 'INPUT=A.L3.bam')
#       java -Xmx8G -Djava.io.tmpdir=temp/ -jar $PICARD MergeSamFiles $INPUTS_TECH_REPS OUTPUT=$TMP_DIR/$REP_LABEL.bam USE_THREADING=TRUE ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT

echo "### Step 4: Mark duplicates"
java -Xmx30G -XX:-UseGCOverheadLimit -Djava.io.tmpdir=temp/ -jar $PICARD MarkDuplicates INPUT=$PAIR_DIR/$SRA.bam OUTPUT=$REP_DIR/$REP_LABEL.bam METRICS_FILE=$REP_DIR/metrics.$REP_LABEL.txt TMP_DIR=$TMP_DIR ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE

$SAMTOOLS index $REP_DIR/$REP_LABEL.bam

perl $STATS $REP_DIR/$REP_LABEL.bam > $REP_DIR/$REP_LABEL.bam.stats

echo "Finished Mapping Pipeline through Duplicate Removal"


