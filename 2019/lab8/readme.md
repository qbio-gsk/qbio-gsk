# Lab 8: Practical ChIP-seq analysis

### Thursday April 4, 2019, 12:45-2:45pm


Many aspects of molecular cell biology are measured using experimental technologies based on high-throughput [DNA sequencing](http://www.cs.jhu.edu/~langmea/resources/lecture_notes/dna_sequencing.pdf). Research areas that deal with these data are sometimes called [Genomics and Computational Genomics](http://www.cs.jhu.edu/~langmea/resources/lecture_notes/genomics_comp_genomics.pdf). [ChIP-seq](https://en.wikipedia.org/wiki/ChIP-sequencing) is one such technology for detecting protein binding to DNA. We will go over practical steps of the ChIP-seq data analysis. Many of these steps and corresponding tools are representative of what could be applied to other sequencing-based data as well.

As an example, we will use Foxp3 ChIP-seq data generated from mouse Treg cells and published in [Arvey et al. Nat Immunology 2014](https://www.nature.com/articles/ni.2868) ([PMID: 24728351](https://www.ncbi.nlm.nih.gov/pubmed/24728351)), data publicly available at [GSE55773](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE55773). We will not use all of the data, but a representative subset of samples. The data and scripts are available in several subfolders along with this readme document. (Large data files are represented only by their names, or symlinks, as placeholders.)


## Steps in analysis


### Get FASTQ files with sequenced reads

See folder `data/chipseq-fastq`.

Typically you will get the data for analysis in the FASTQ format. It may be your own data generated for you by the genomics core. There is also a lot of previously published data publicly available for analysis at data repositories. [NCBI GEO](https://www.ncbi.nlm.nih.gov/geo/) is one such repository. Large consortia, such as [ENCODE](https://www.encodeproject.org/) or [Roadmap Epigenomics](http://www.roadmapepigenomics.org/), also sometimes make the data available on their websites, in the FASTQ format and more processed formats.

Our Foxp3 data is available from GEO at [GSE55773](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE55773). For sequencing-based data, GEO contains primarily metadata of the experiments and some processed data files submitted by authors. For actual FASTQ data you need to download it from [SRA](https://www.ncbi.nlm.nih.gov/sra), linked to from the GEO entry. In our example, the data is summarized [here](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP039938). These data can be obtained and manipulated using [SRA toolkit](https://www.ncbi.nlm.nih.gov/books/NBK158900/). After installing the toolkit, you can use one command from this toolkit, `fastq-dump`, to donwload the data directly from SRA in FASTQ format.

You can run a command such as this:

```
fastq-dump -I --gzip -A SRR1186971
```

which downloads a file `SRR1186971.fastq.gz`.

The script `dump-files.sh` downloads the four samples, three ChIP-seq replicates and one input DNA control.


### Align reads to genome

See folders `align` and `data/chipseq-bam`.

The first step in analysis is to align reads to genome, in order to associate each read with the most probable place of the genome where it originated. [Sequence alignment](https://en.wikipedia.org/wiki/Sequence_alignment) is a classical problem in bioinformatics, with many formulations. 

One tool perfectly suitable for quick alignment of millions of the short sequencing reads to the genome is [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2). After installing the tool, you also need to obtain the index for the mouse genome, which is the sequence of the entire mouse genome compacted and processed into an appropriate format for running `bowtie2`. Then you can run in a command line a command such as this:

```
bowtie2 -p 10 -t --no-unal -X 500 -x mm10-bowtie2index/mm10 -U SRR1186971.fastq.gz >SRR1186971.sam 2>.bowtie2.SRR1186971
```

(This command assumes that mm10 index for bowtie2 is in folder `mm10-bowtie2index`, where files forming the index start with `mm10`.)

This produces the alignment files in the [SAM format](https://samtools.github.io/hts-specs/SAMv1.pdf). They can be manipulated using [SAMtools](http://samtools.sourceforge.net/). You need to install the tools, and then they can be used from the command line. For example, in order to extract reads of high sequencing quality that are uniquely aligned to the genome, you can use the command `samtools view`. This produces the alignments in the BAM format. BAM is a binary version of SAM. Then the command `samtools sort` is used to sort the aligned reads by coordinate, to produce a sorted BAM file. Then the command `samtools index` produces an index file (extension `.bam.bai`) that allows for a convenient by-coordinate access to aligned reads, given the BAM file and its index.

Often the BAM files of interest are also publicly available or produced for you by the genomics core, and your analysis can start directly from BAM files.

The tool [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) can be used to obtain summarized statistics and quality metrics for the sequencing reads, both in the aligned format (SAM or BAM), or the raw unaligned reads (FASTQ).

The script `run-alignment.sh` aligns the four our samples to the mouse genome and filters for the uniquely aligned reads with high sequencing and mapping quality, and then produces sorted and indexed BAMs. It also runs the quality check with FastQC.

This results in the four BAM files for our samples, along with their index files. The script `rename-samples.sh` creates symlinks with meaningful names `foxp3_input`, `foxp3_rep1`, `foxp3_rep2`, and `foxp3_rep3`.


### Call peaks for each replicate

See folder `peakcalling`.

Now we need to identify genomic regions enriched for the ChIP-seq signal, or peaks of the signal. These are the regions where we expect Foxp3 is bound to the genome. [MACS2](https://github.com/taoliu/MACS) is a popular tool that is used for that purpose. You need to install the tool, and then you can run it it from a command line like this:

```
macs2 callpeak -t foxp3_rep1.bam -c foxp3_input.bam -f BAM -n foxp3_rep1 -B --SPMR --outdir peaks-macs2/foxp3_rep1/ -g mm -p 0.1 --keep-dup 'auto' --call-summits 2>.macs
```

This command produces a number of files in the folder `peaks-macs2/foxp3_rep1/` that are useful for further analysis and visualization. File `peaks-macs2/foxp3_rep1/foxp3_rep1_peaks.narrowPeak` contains the peaks in a [narrowPeak format](https://genome.ucsc.edu/FAQ/FAQformat.html#format12) that is an extended version of [BED format](https://genome.ucsc.edu/FAQ/FAQformat.html#format1). File `peaks-macs2/foxp3_rep1/foxp3_rep1_model.r` is an R script that can produce a PDF file with diagnostics plots. To produce this file, run `Rscript --vanilla foxp3_rep1_model.r` in the folder that contains the file.

The folder `peakcaling` contains the script `peak-calling.sh` that runs MACS2 for each of our three ChIP-seq replicates against control, with all the results in folder `peakcalling/peaks-macs2`.


### Identify reproducible peaks

See folder `peakcalling`.

Now we need to identify peaks that are reproducible between replicates. This is especially important for ChIP-seq data, for it is known to be quite noisy. For this, we should apply Irreproducible Discovery Rate (IDR), implemented as a [command line tool](https://github.com/nboley/idr). After installing the tool, you can run a command such as this:

```
idr --verbose --samples foxp3_rep1_peaks.narrowPeak foxp3_rep1_peaks.narrowPeak -o foxp3_rep1_foxp3_rep2.narrowPeak --log-output-file $idrdir/$prefix.log.txt --plot
```

The folder `peakcalling` contains the script `idr-analysis.sh` that runs IDR for each pair of replicates, using IDR threshold 0.1, with results in folder `peakcalling/idr-results`, and then consolidates the reproducible peaks between any pair of replicates in file `peakcalling/idr-results/foxp3_peaks.narrowPeak`. The consolidation step requires [BEDtools](http://bedtools.readthedocs.io/en/latest/), a highly efficient set of command line utilities for manipulation with BED and other genomic files. Another more recent utility with the same and complimentary functionality is [deepTools](https://deeptools.readthedocs.io/).


### Find binding specificity motifs

See folder `motifs`.

Proteins bind to DNA with a certain sequence specificity. The simplest model to represent such specificities is positional weight matrices. It important to remember that the limitation of this model is that it assumes independent nucleotide preference in each position. It has been shown that this is not entirely true biologically, but is a very useful and accurate approximation. This allows us to represent DNA binding specificities as sequence motifs.

[HOMER](http://homer.ucsd.edu/homer/motif/) is a very popular software to run motif analysis for genomic regions of interest, for example, for ChIP-seq peaks.

A script `run-homer.sh` runs a perl script wrapper `findMotifsGenome.pl` of HOMER for our Foxp3 peaks. The results are stored in `motifs/homer-output`. 

The HTML document with *de novo* discovered motifs and their best matches to the database motifs is in `motifs/homer-output/homerResults.html`, can be opened in your browser. Interestingly, the top three most significant motifs for our Foxp3 data are ETS family motif, RUNX family motif, and Forkhead family motif, as expected and previously reported from Foxp3 ChIP-seq.

The HTML document with the known motifs from the database searched over the input genomic regions is in file `motifs/homer-output/knownResults.html`.



### Explore in IGV or UCSC genome browser

Use [IGV](http://software.broadinstitute.org/software/igv/) locally on your desktop or laptop or [UCSC Genome Browser](https://genome.ucsc.edu/) online to explore the data.



### Assign peaks to genes, overlap with ATAC-seq or histone ChIP-seq peaks, compare with RNA-seq expression, etc.

Use R and Bioconductor to write your own code for exploratory and integrative analysis of the data. Technics and tools for such analysis were discussed in our [Lab 6](../lab6/schedule.md).
