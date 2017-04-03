# Schedule of Lab 8

Monday Apr 2, 2017, 3-5pm, with one break for 10-15 min

## Accessing data from public repositories and discuss project ideas.

- Review ways we have already imported data: make your own, download with URL inside R using readr or read.csv, using the ggplot2 example dataset, subset another dataset, use bioconductor to import, ftp.
- Resources for sequencing data: [ENCODE](https://www.encodeproject.org/), [cBioPortal](http://www.cbioportal.org/), [GEO](https://www.ncbi.nlm.nih.gov/geo/), [SRA](https://www.ncbi.nlm.nih.gov/sra/?term=h3k27ac+histone+chip), [ENA](http://www.ebi.ac.uk/ena/data/search?query=h3k27ac+histone+chip), etc.
- Review pre-processing pipeline if using raw fastq files as in the appendix here: https://www.bioconductor.org/help/course-materials/2015/CSAMA2015/lab/Epigenetics_and_Chip_seqLab.pdf
- Examples for accessing other types of data like xml and json through uniprot example. So far, mostly imported csv or sequencing files.
- Resources for other types of data: [Figshare](https://figshare.com/browse), [538](https://github.com/fivethirtyeight), etc.
- Examples of projects from last class.


## Uniprot and json files example.

```
install.packages('rjson')
install.packages('RCurl')
library(rjson)
library(RCurl)
u <- getURL("http://togows.dbcls.jp/entry/uniprot/PROSC_MOUSE.json")
j <- fromJSON(u)
j[[1]]$sq$MW
```

## Other resources

- There are tons of data repositories: http://www.nature.com/sdata/policies/repositories
- Figshare resources: 
  - rfigshare: https://cran.r-project.org/web/packages/rfigshare/README.html
  - acetylation and ubiquitination dataset: https://figshare.com/articles/Additional_file_3_of_Frequent_mutations_in_acetylation_and_ubiquitination_sites_suggest_novel_driver_mechanisms_of_cancer/4474967
  - RNA-seq: https://figshare.com/articles/MOUtbhR_RNA-seq_functions_analysis/4811077
- Other analysis resources besides those we've used:
  - DADA2: http://benjjneb.github.io/dada2/tutorial.html
  - Mothur 



