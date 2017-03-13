# Schedule of Lab 5

Monday Mar 13, 2017, 3pm-5pm, with one break for 10-15 min

1. We will learn about some of the fundamental data structures in Bioconductor for genomic data. We will cover some of [GenomicRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html), [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html), [Biostrings](https://bioconductor.org/packages/release/bioc/html/Biostrings.html), [BSGenome](https://bioconductor.org/packages/release/bioc/html/BSgenome.html), [AnnotationDbi](https://bioconductor.org/packages/release/bioc/html/AnnotationDbi.html).
	
Please try to install these packages before class.  Some you may already have from previous classes. You can try running these commands on the console within Rstudio:

```R
source("https://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")
biocLite("GenomicFeatures")
biocLite("Biostrings")
biocLite("BSgenome")
bioCLite("AnnotationDbi")
```

Please also install packages with annotation and sequence data for human (may take some time to download):

```R
source("https://bioconductor.org/biocLite.R")
biocLite("TxDb.Hsapiens.UCSC.hg19.knownGene")
biocLite("BSgenome.Hsapiens.UCSC.hg19")
```
 	

2. Please start thinking about the project on biological data analysis that you could do later in this course. You can do it alone or in groups. It can be based on data from your own project, or on publicly available data. We will help you to search for and work with public high-throughput biological data.

In the end of class, there will be a quick poll, including a question about your potential project ideas. Happy to discuss these ideas after class or during the break.


##### Additional materials

- [R cheat sheet](https://cran.r-project.org/doc/contrib/Short-refcard.pdf)
- [Cheat sheets from Rstudio](https://www.rstudio.com/resources/cheatsheets/)
- [Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard)
