#!/bin/bash


bamdir="../data/chipseq-bam/"


ln -s SRR1186976.bam $bamdir/foxp3_input.bam
ln -s SRR1186976.bam.bai $bamdir/foxp3_input.bam.bai

ln -s SRR1186971.bam $bamdir/foxp3_rep1.bam
ln -s SRR1186971.bam.bai $bamdir/foxp3_rep1.bam.bai

ln -s SRR1186973.bam $bamdir/foxp3_rep2.bam
ln -s SRR1186973.bam.bai $bamdir/foxp3_rep2.bam.bai

ln -s SRR1186974.bam $bamdir/foxp3_rep3.bam
ln -s SRR1186974.bam.bai $bamdir/foxp3_rep3.bam.bai
