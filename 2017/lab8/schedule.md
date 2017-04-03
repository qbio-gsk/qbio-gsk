# Schedule of Lab 8

Monday Apr 2, 2017, 3-5pm, with one break for 10-15 min

## Accessing data from public repositories and discuss project ideas.

- Review ways we have already imported data: make your own, download with URL inside R using readr or read.csv, using the ggplot2 example dataset, subset another dataset, use bioconductor to import, ftp.
- Review pre-processing pipeline if using raw fastq files as in the appendix here: https://www.bioconductor.org/help/course-materials/2015/CSAMA2015/lab/Epigenetics_and_Chip_seqLab.pdf
- Resources for sequencing data: [ENCODE](https://www.encodeproject.org/), [cBioPortal](http://www.cbioportal.org/), [GEO](https://www.ncbi.nlm.nih.gov/geo/), [SRA](https://www.ncbi.nlm.nih.gov/sra/?term=h3k27ac+histone+chip), [ENA](http://www.ebi.ac.uk/ena/data/search?query=h3k27ac+histone+chip), etc.
- Examples for accessing uniprot and PDB (below) through R.
- Examples of projects from last class.
- Resources for other types of data: [Figshare](https://figshare.com/browse), [538](https://github.com/fivethirtyeight), etc.

## Chemoinformatics examples.

Example question #1: Can we find out the Molecular Weights of our protein of interest from Uniprot?

Using TogoWS REST example:
For example, using Proline synthase co-transcribed bacterial homolog protein from mouse (PROSC_MOUSE is the ID, Q9Z2Y8 is the accession) as described in this example
https://www.biostars.org/p/109706/:

```
install.packages('rjson')
install.packages('RCurl')
library(rjson)
library(RCurl)
u <- getURL("http://togows.dbcls.jp/entry/uniprot/PROSC_MOUSE.json")
j <- fromJSON(u)
j[[1]]$sq$MW
```

Example question #2: How many PDBs are there of my protein of interest (here human ABL1) from Uniprot?

Bioconductor example:
For example using uniprot ID P00519 (human ABL1), this is a combination of examples here https://support.bioconductor.org/p/56824/ and here https://www.bioconductor.org/packages/3.3/bioc/manuals/UniProt.ws/man/UniProt.ws.pdf

```
source("https://bioconductor.org/biocLite.R")
biocLite("UniProt.ws")
library("UniProt.ws")
up <- UniProt.ws(taxId=9606)
kt <- "UNIPROTKB"
keys <- c("P00519") #Human ABL1
columns <- c("UNIPROTKB", "PDB")
res <- select(up, keys, columns, kt)
res
summary(res)
```

Example Question #3: Can we find all drugs that target HER2 kinase from ChemBL?

For the future? (Or maybe you can figure it out on your own...)

Here is a resource for this: https://github.com/rajarshi/chemblr
This rcdk package also seems nice: https://cran.r-project.org/web/packages/rcdk/vignettes/rcdk.pdf
https://cran.r-project.org/web/packages/rcdk/index.html
Another good tutorial: http://www.cureffi.org/2013/09/23/a-quick-intro-to-chemical-informatics-in-r/

```
install.packages("rcdk")
library(rcdk)
anle138b = parse.smiles("C1OC2=C(O1)C=C(C=C2)C3=CC(=NN3)C4=CC(=CC=C4)Br")[[1]]
rcdkplot = function(molecule,width=500,height=500) {
    par(mar=c(0,0,0,0)) # set margins to zero since this isn't a real plot
    temp1 = view.image.2d(molecule,width,height) # get Java representation into an image matrix. set number of pixels you want horiz and vertical
    plot(NA,NA,xlim=c(1,10),ylim=c(1,10),xaxt='n',yaxt='n',xlab='',ylab='') # create an empty plot
    rasterImage(temp1,1,1,10,10) # boundaries of raster: xmin, ymin, xmax, ymax. here i set them equal to plot boundaries
}
rcdkplot(anle138b)
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



