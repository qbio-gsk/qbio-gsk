# Schedule of Lab 12

Monday May 1, 2017, 3-5pm, with one break for 10-15 min

## Sequence Alignment and Chemoinformatics/PDB tools

- Review of Bowtie. Following this tutorial: https://www.ebi.ac.uk/training/online/course/ebi-next-generation-sequencing-practical-course/chip-seq-analysis/chip-seq-practical
- Download Jalview (http://www.jalview.org/Download), PyMOL (https://pymol.org/edu/?q=educational/), and [primates](https://github.com/KlausVigo/phangorn/blob/master/vignettes/primates.dna) and [kinases](http://kinase.com/kinbase/FastaFiles/Human_kinase_domain.fasta) data for use later.
- Demo of [Blast](https://blast.ncbi.nlm.nih.gov/Blast.cgi).
- Demo of building a phylogenetic tree using R. Following [this tutorial.](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwi1kau4987TAhUL2IMKHTlxD7EQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fphangorn%2Fvignettes%2FTrees.pdf&usg=AFQjCNGVglaTOm5FcHtaKpDpc-ApDth3Sw&sig2=igwoOk3Cy7tTBpqWE8rX8Q) tutorial.
- Demo of using [Clustal Omega](http://www.ebi.ac.uk/Tools/msa/clustalo/) and Jalview.
- If time go through demo below on Accessing info on PDB files through R, including downloading all PDB files for a specific sequence in the uniprot database. 
- Exercise using cBioPortal (http://www.cbioportal.org) and PyMOL (https://pymol.org/edu/?q=educational/) to look at ABL1 and KRAS mutants.
- Start list of student projects.


## Example question #2: How many PDBs are there of my protein of interest (here human ABL1) from Uniprot?

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

## Other resources

- ChipSeq lab: https://www.bioconductor.org/help/course-materials/2015/CSAMA2015/lab/Epigenetics_and_Chip_seqLab.pdf
- Blast in bioconductor: https://support.bioconductor.org/p/39768/
- More kinase data here: http://kinase.com/kinbase/FastaFiles/
- Muscle alignment with bioconductor: https://www.bioconductor.org/packages/release/bioc/vignettes/muscle/inst/doc/muscle-vignette.pdf
