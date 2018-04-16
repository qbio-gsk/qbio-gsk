#!/bin/bash

nthreads=12


fastqdir="../data/chipseq-fastq/"
bamdir="../data/chipseq-bam/"
bowtieoutput="$bamdir/bowtie-output"
fastqcdir="$bamdir/fastqc-output"

# the code below assumes that "mm10-bowtie2index/mm10" contains
# the bowtie2 mouse genome index


for fileid in SRR1186971 SRR1186973 SRR1186974 SRR1186976
do
    echo "process sample $fileid"

    fastqfile="$fastqdir/$fileid.fastq.gz"
    samfile="$bowtieoutput/$fileid.sam"
    unsortedbamfile="$bowtieoutput/$fileid.unsorted.bam"
    bamfile="$bamdir/$fileid.bam"

    echo "run bowtie2..."
    bowtie2 -p $nthreads -t --no-unal -X 500 -x mm10-bowtie2index/mm10 -U "$fastqfile" >"$samfile" 2>"$bowtieoutput"/.bowtie2."$fileid"
    echo "bowtie2 done"

    echo "run samtools view to produce unsorted BAM..."
    samtools view -h -bS -F 4 -q 20 "$samfile" >"$unsortedbamfile"
    echo "samtools view done"
    echo "delete SAM file to save disk space"
    rm -rf "$samfile"

    echo "run samtools sort to produce sorted BAM..."
    samtools sort "$unsortedbamfile" >"$bamfile"
    echo "samtools sort done"
    echo "delete unsorted BAM to save disk space"
    rm -rf "$unsortedbamfile"

    echo "run samtools index to produce BAM index"
    samtools index "$bamfile"
    echo "samtools index done"

    echo "run FastQC for quality check"
    nice -n 10 fastqc -q -t $nthreads -o "$fastqcdir" "$bamfile"
    echo "FastQC done"

    echo "processing of $fileid done"
done
