Here we are some quick examples if chemoinformatics type things we can do with R!!

Example question #1: Can we find out the Molecular Weights of our protein of interest from Uniprot?

Using TogoWS REST example:
For example, using Proline synthase co-transcribed bacterial homolog protein from mouse (PROSC_MOUSE is the ID, Q9Z2Y8 is the accession) as described in this example
https://www.biostars.org/p/109706/:


> install.packages('rjson')
> install.packages('RCurl')

> library(rjson)
> library(RCurl)

> u <- getURL("http://togows.dbcls.jp/entry/uniprot/PROSC_MOUSE.json")
> j <- fromJSON(u)

> j[[1]]$sq$MW


Example question #2: How many PDBs are there of my protein of interest (here human ABL1) from Uniprot?

Bioconductor example:
For example using uniprot ID P00519 (human ABL1), this is a combination of examples here https://support.bioconductor.org/p/56824/ and here https://www.bioconductor.org/packages/3.3/bioc/manuals/UniProt.ws/man/UniProt.ws.pdf

> source("https://bioconductor.org/biocLite.R")
> biocLite("UniProt.ws")
> library("UniProt.ws")

> up <- UniProt.ws(taxId=9606)

> kt <- "UNIPROTKB"
> keys <- c("P00519") #Human ABL1
> columns <- c("UNIPROTKB", "PDB")
> res <- select(up, keys, columns, kt)
> res
> summary(res)

Example Question #3: Can we find all drugs that target HER2 kinase from ChemBL?

Here is a resource for this: https://github.com/rajarshi/chemblr

More details in the future!
