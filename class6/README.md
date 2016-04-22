Grab the latest version of the repository: 

First, we will cover the theory of multiple hypothesis testing
	- `git pull` the latest repo 
 	- Multiple hypothesis testing will continue from [here](https://github.com/jtleek/advdatasci/blob/gh-pages/lecture_notes/multipletesting/index.Rmd)


Next, we will learn about some of the fundamental data structures in Bioconductor for genomic data:
	- Instructions for how to install the package, though likely it will already be installed., link to genomic ranges bioconductor page, along with vignette
	- We will cover [GenomicRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html), [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html), [BSGenome](https://bioconductor.org/packages/release/bioc/html/BSgenome.html), [AnnotationDbi](https://bioconductor.org/packages/release/bioc/html/AnnotationDbi.html)
	
Please try to install these packages before class.  Some you may already have from previous classes.  You can try running these commands on the console within Rstudio:

```R
source("https://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")
biocLite("GenomicFeatures")
biocLite("BSgenome")
bioCLite("AnnotationDbi")

```
 	
For the third hour, we will cover Principal Component Analysis:
	- examples from the vignette
	- assumptions that PCA makes.
	- limitations of the approach.

The last hour of class time will be devoted to project consultation time:
	- you can bounce ideas off of us, or ask us for suggestions about project topics and data sources.
	- we will present potential sample project ideas and data sources (ReCount, ENCODE):
		- pick a question to ask
		- pick a data set
		- download the data
		- load it into R

