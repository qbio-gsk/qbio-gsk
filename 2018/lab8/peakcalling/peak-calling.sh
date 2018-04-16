#!/bin/bash

echo "produce peaks using MACS2"
echo

echo "macs2 version:"
macs2 --version
echo

bamdir="../data/chipseq-bam/"
peaksdir="peaks-macs2"


for prefix in foxp3_rep1 foxp3_rep2 foxp3_rep3
do
    macsdir="$peaksdir/$prefix/"
    mkdir -p $macsdir
    echo "run macs2 callpeak for $prefix"
    macs2 callpeak -t "$bamdir"/"$prefix".bam -c "$bamdir"/foxp3_input.bam -f BAM -n $prefix -B --SPMR --outdir $macsdir -g mm -p 0.1 --keep-dup 'auto' --call-summits 2>$macsdir/.macs
    echo "done"
    echo
done
