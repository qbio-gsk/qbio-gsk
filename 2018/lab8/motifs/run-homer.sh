#!/bin/bash

peaks="../peakcalling/idr-results/foxp3_peaks.narrowPeak"
homerdir="homer-output"

findMotifsGenome.pl $peaks mm10 $homerdir