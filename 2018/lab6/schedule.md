# Lab 6

Monday Mar 26, 2018, 1-3pm

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


##### Additional useful materials

- [R cheat sheet](https://cran.r-project.org/doc/contrib/Short-refcard.pdf)
- [Cheat sheets from Rstudio](https://www.rstudio.com/resources/cheatsheets/)
- [Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard)
