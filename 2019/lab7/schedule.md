# Lab 7

Monday Mar 25, 2019, 1-3pm

### Material
We will learn about some of the fundamental data structures in Bioconductor for genomic data. After a brief overview, we will cover some basic data structures and functionality of packages [GenomicRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html), [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html), [Biostrings](https://bioconductor.org/packages/release/bioc/html/Biostrings.html), [BSGenome](https://bioconductor.org/packages/release/bioc/html/BSgenome.html), [AnnotationDbi](https://bioconductor.org/packages/release/bioc/html/AnnotationDbi.html).

Webpages for these packages contain nice vignettes on their usage. In class, the plan is that we will go over [these slides](https://bioconductor.org/packages/release/bioc/vignettes/GenomicRanges/inst/doc/GRanges_and_GRangesList_slides.pdf), cover an introductory example from [this vignette](https://bioconductor.org/packages/release/bioc/vignettes/BSgenome/inst/doc/GenomeSearching.pdf) and an example 2.14 from [this vignette](https://bioconductor.org/packages/release/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesHOWTOs.pdf).
	
Please try to install these packages before class. Some you may already have from previous classes. You can try running these commands on the console within Rstudio:

```R
source("https://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")
biocLite("GenomicFeatures")
biocLite("Biostrings")
biocLite("BSgenome")
biocLite("AnnotationDbi")
```

Please also install packages with annotation and sequence data (may take some time to download):

```R
source("https://bioconductor.org/biocLite.R")
biocLite("BSgenome.Celegans.UCSC.ce2")
biocLite("KEGG.db")
biocLite("KEGGgraph")
biocLite("TxDb.Hsapiens.UCSC.hg19.knownGene")
biocLite("BSgenome.Hsapiens.UCSC.hg19")
```

Check that these packages are properly installed. These commands should be executed without errors:

```R
library("GenomicRanges")
library("GenomicFeatures")
library("Biostrings")
library("BSgenome")
library("AnnotationDbi")
library("BSgenome.Celegans.UCSC.ce2")
library("KEGG.db")
library("KEGGgraph")
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
library("BSgenome.Hsapiens.UCSC.hg19")
```

### ChIP-seq and beyond
In the second half of the class and in next class, we will learn some introductory steps of how to analyze ChIP-seq and some similar improved assays (ChIP-exo, Cut&Run) and other related assays (ATAC-seq, DNase-seq). In preparation to that, please see [materials from last year's class](https://github.com/qbio-gsk/qbio-gsk/tree/master/2018/lab8).

### Update: slides

[Slides](ChIPseq-bioconductor.html) used in this class, along with the materials above.


##### Additional useful materials

- [R cheat sheet](https://cran.r-project.org/doc/contrib/Short-refcard.pdf)
- [Cheat sheets from Rstudio](https://www.rstudio.com/resources/cheatsheets/)
- [Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard)
- BioStarBook 1st Edition: Chapters: Interval Datatypes (pages 523-527), ChiP-seq Analysis (pages 560-615); we will not necessarily follow these materials in class.
- [ChIP–seq and beyond: new and improved methodologies to detect and characterize protein–DNA interactions](https://www.nature.com/articles/nrg3306)
- Cut&Run: [An efficient targeted nuclease strategy for high-resolution mapping of DNA binding sites](https://elifesciences.org/articles/21856)
- [ATAC‐seq: A Method for Assaying Chromatin Accessibility Genome‐Wide](https://currentprotocols.onlinelibrary.wiley.com/doi/abs/10.1002/0471142727.mb2129s109)
