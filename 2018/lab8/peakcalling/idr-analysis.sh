#!/bin/bash


echo "run IDR analysis for peaks"
echo
idr --version
echo

peaksdir="peaks-macs2"
idrdir="idr-results"

# idrthreshold=540  # IDR threshold 0.05
idrthreshold=415  # IDR threshold 0.1


mkdir -p $idrdir


samples="foxp3_rep1 foxp3_rep2 foxp3_rep3"
for sample1 in $samples
do
    for sample2 in $samples
    do
        if [[ "$sample1" < "$sample2" ]]
        then
            echo "do IDR for $sample1 and $sample2"
            prefix="$sample1"_"$sample2"
            idr --verbose --samples $peaksdir/"$sample1"/"$sample1"_peaks.narrowPeak $peaksdir/"$sample2"/"$sample2"_peaks.narrowPeak -o $idrdir/$prefix.narrowPeak --log-output-file $idrdir/$prefix.log.txt --plot
            awk -v v="$idrthreshold" '$5 > v' $idrdir/$prefix.narrowPeak >$idrdir/$prefix.idr.narrowPeak
        fi
    done
done


cat $idrdir/foxp3_rep1_foxp3_rep2.idr.narrowPeak $idrdir/foxp3_rep1_foxp3_rep3.idr.narrowPeak $idrdir/foxp3_rep2_foxp3_rep3.idr.narrowPeak | bedtools sort -i - | bedtools merge -i - >$idrdir/foxp3_peaks.narrowPeak


echo "IDR done"
