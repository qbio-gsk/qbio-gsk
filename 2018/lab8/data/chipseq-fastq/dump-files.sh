#!/bin/bash

for fileid in SRR1186971 SRR1186973 SRR1186974 SRR1186976
do
    fastq-dump -I --gzip -A $fileid
done
