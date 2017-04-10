# Schedule of Lab 8

Monday Apr 9, 2017, 3-5pm, with one break for 10-15 min

## Overview of multiple hypothesis testing

We will revisit the meaning of Pvalues, examine possible outcomes of high-throughput experiments by simulation, and introduce some concepts for multiple-hypothesis correction:
 - `git pull` the latest repo 
 - P-value notes will come from [here](https://github.com/jtleek/advdatasci/blob/gh-pages/lecture_notes/multipletesting/index.Rmd)
 - Simulation of p-values is in the repo (pvalue_simulation.R)
 - Sanity-check p-value histograms exercise is [here](http://varianceexplained.org/statistics/interpreting-pvalue-histogram/) 


## Example of multiple hypothesis correction in practice

We will look at an experiment assaying acetylated regions in mouse (via H3K27ac ChIP), and apply multiple hypothesis correction to the P-values produced by MACS2, to eliminate spurious peaks.
- The script used in class is in the repo (H3K27ac_chip_study.R)
- The source material, including some downstream analysis is [here](https://www.bioconductor.org/help/course-materials/2015/CSAMA2015/lab/Epigenetics_and_Chip_seqLab.pdf)

## Caveats
- Make sure you can load each of the packages in the script. 
- In particular, EpigeneticsCSAMA2015 (provided in the repo) must be loaded either by `R CMD INSTALl` or using the Rstudio GUI.
- Also make sure you change the script so that you can load the data (in the macs2 folder) on your own machine.





