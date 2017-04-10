### Lab 9: multiple hypothesis testing, with application to peak calling via H3K27ac ChIP

# load the necessary packages

source("https://bioconductor.org/biocLite.R")

# the package didn't install via biocLite for me (R 3.3.1) so I installed via package
install.packages("~/teaching/CSAMA2015/packages/EpigeneticsCSAMA2015.tar.gz", repos = NULL, type = "source")
biocLite("chipseq")

library("EpigeneticsCSAMA2015")
library("GenomicRanges")
library(rtracklayer)
library(IRanges)
library(chipseq)
library(Gviz)


# establish data dir, load bed files
system.file("bedfiles", package="EpigeneticsCSAMA2015")
data_directory = system.file("bedfiles", package="EpigeneticsCSAMA2015")

input = import.bed(file.path(data_directory, "ES_input_filtered_ucsc_chr6.bed"))
rep1 = import.bed(file.path(data_directory, "H3K27ac_rep1_filtered_ucsc_chr6.bed"))
rep2 = import.bed(file.path(data_directory, "H3K27ac_rep2_filtered_ucsc_chr6.bed"))

# check number of records in each
length(input)
length(rep1)
length(rep2)

# The reads correspond to sequences at the end of each IP-ed fragment (single-end sequencing data). As
# discussed in the lecture, we need to extend them to represent each IP-ed DNA fragment.
# We estimate the mean read length using the estimate.mean.fraglen function from chipseq packege. Next,
# we extend the reads to the inferred read length using the resize function. We remove any reads for which
# the coordinates, after the extension, exceed chromosome length. These three analysis steps are wrapped
# in a single function prepareChIPseq function which we define below.

prepareChIPseq = function(reads){
  frag.len = median( estimate.mean.fraglen(reads) )
  cat( paste0( 'Median fragment size for this library is ', round(frag.len)))
  reads.extended = resize(reads, width = frag.len)
  return( trim(reads.extended) )
}

# normalize read lengths for input, rep1, rep2:
input = prepareChIPseq(input)
rep1 = prepareChIPseq(rep1)
rep2 = prepareChIPseq(rep2)

### Next: count how many reads map to each pre-established genomic intervals

# We first generate the bins. We will tile the genome into non-overlapping bins of size 200 bp.
binsize = 200
bins = tileGenome(si['chr6'], tilewidth=binsize, cut.last.tile.in.chrom = TRUE)

# Now map the reads to the bins
BinChIPseq = function(reads, bins){
  mcols(bins)$score = countOverlaps(bins,reads)
  return(bins)
}

# Now we apply it to the objects input, rep1 and rep2. We obtain input.200bins, rep1.200bins and rep2.200bins,
# which are GRanges objects that contain the binned read coverage of the input and ChIP-seq experiments.

input.200bins = BinChIPseq(input, bins)
rep1.200bins = BinChIPseq(rep1, bins)
rep2.200bins = BinChIPseq(rep2, bins)

# Having computed coverage track-like info, we can now visualize our acetylation data.

# We start with loading the gene models for chromosome 6 starting at position
# 122,530,000 and ending at position 122,900,000. We focus on this region as it harbors the Nanog gene, which
# is stongly expressed in ES cells.

# get gene annotations via biomaRt package.  We'll use pre-packaged results from a query, but the appendix to this lesson shows
# how to get gene models for protein coding genes for mm9
data(bm)

AT = GenomeAxisTrack()
plotTracks(c(bm, AT),
           from=122530000, to=122900000,
           transcriptAnnotation="symbol", window="auto",
           cex.title=1, fontsize=10)

# Add the data tracks we made above:

# 1) generate DataTrack object with the DataTrack function, then annotate each with labels and colours
input.track = DataTrack(input.200bins,
                        strand="*", genome="mm9", col.histogram="gray",
                        fill.histogram="black", name="Input", col.axis="black",
                        cex.axis=0.4, ylim=c(0,150))

rep1.track = DataTrack(rep1.200bins,
                       strand="*", genome="mm9", col.histogram="steelblue",
                       fill.histogram="black", name="Rep-1", col.axis="steelblue",
                       cex.axis=0.4, ylim=c(0,150))

rep2.track = DataTrack(rep2.200bins,
                       strand="*", genome="mm9", col.histogram="steelblue",
                       fill.histogram="black", name="Rep-2", col.axis="steelblue",
                       cex.axis=0.4, ylim=c(0,150))

# 2) Plot the tracks alongside the gene models, so we start to get an idea of what's going on.
#    N.B this just displays (for rep1,2) the raw read counts in each 200bp bin in window we're examining
plotTracks(c(input.track, rep1.track, rep2.track, bm, AT),
           from=122530000, to=122900000,
           transcriptAnnotation="symbol", window="auto",
           type="histogram", cex.title=1, fontsize=10)

### Finally, you can make a track which visualizes those peaks identified by MACS
peaks.rep1 = import.bed(file.path(data_directory, "Rep1_peaks_ucsc_chr6.bed"))
peaks.rep2 = import.bed(file.path(data_directory, "Rep2_peaks_ucsc_chr6.bed"))

# peak track files are added to a plot with the AnnotatioTrack function in GViz.  Let's add them:
peaks1.track= AnnotationTrack(peaks.rep1,
                              genome="mm9", name="Peaks Rep 1",
                              chromosome="chr6",
                              shape="box", fill="blue3", size=2)
peaks2.track = AnnotationTrack(peaks.rep2,
                               genome="mm9", name="Peaks Rep 2",
                               chromosome="chr6",
                               shape="box", fill="blue3", size=2)

# zoom in on the Nanog locus:
plotTracks(c(input.track, rep1.track, peaks1.track, rep2.track, peaks2.track, bm, AT),
           from=122630000, to=122700000,
           transcriptAnnotation="symbol", window="auto",
           type="histogram", cex.title=1, fontsize=10)


### But wait: there are a few (marginal) peaks on each track which don't agree with the other replicate.  Are these peaks 
### or are they not?
library(data.table)

### I often forget the format of the .narrowPeak output file.  It's like a BED file, but here's what the 7 - 10 columns display
# 5th: integer score for display
# 7th: fold-change
# 8th: -log10pvalue             <--- this is what we want to examine
# 9th: -log10qvalue
# 10th: relative summit position to peak start

# load MACS2 narrowPeak files
peaks_macs2_rep1_df = read.delim(file.path(data_directory, "macs2", "Rep1_peaks.narrowPeak"), header=FALSE)
colnames(peaks_macs2_rep1_df) = c("chr", "start", "end", "name", "score", "strand", "foldchange", "neg_log10pvalue", "-log10qvalue", "summitRelativeToStart")
peaks_macs2_rep1_dt = data.table(peaks_macs2_rep1_df)
peaks_macs2_rep2_df = read.delim(file.path(data_directory, "macs2", "Rep2_peaks.narrowPeak"), header=FALSE)
colnames(peaks_macs2_rep2_df) = c("chr", "start", "end", "name", "score", "strand", "foldchange", "neg_log10pvalue", "-log10qvalue", "summitRelativeToStart")
peaks_macs2_rep2_dt = data.table(peaks_macs2_rep2_df)

# what do the negative log10 P-value histograms look like?
library(ggplot2)
hist_rep1 <- ggplot(peaks_macs2_rep1_dt) + geom_histogram(aes(x = neg_log10pvalue), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Histogram of observed -log10(Pvalues) for rep1")
hist_rep2 <- ggplot(peaks_macs2_rep2_dt) + geom_histogram(aes(x = neg_log10pvalue), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Histogram of observed -log10(Pvalues) for rep2")

# peaks that pass the Bonfferoni correction treshold on transformed P-value
alpha = 0.05
rep1_bonf_thresh = -log10(alpha / nrow(peaks_macs2_rep1_df))
rep2_bonf_thresh = -log10(alpha / nrow(peaks_macs2_rep2_df))

peaks_rep1_bonf <- peaks_macs2_rep1_dt[neg_log10pvalue > rep1_bonf_thresh,]
peaks_rep2_bonf <- peaks_macs2_rep2_dt[neg_log10pvalue > rep2_bonf_thresh,]

### Plot the Bonfferoni corrected peaks

# convert to GRanges
peaks_rep1_bonf_gr <- GRanges(peaks_rep1_bonf)
peaks_rep2_bonf_gr <- GRanges(peaks_rep2_bonf)

# make tracks
peaks1_bonf.track= AnnotationTrack(peaks_rep1_bonf_gr,
                              genome="mm9", name="Corrected Peaks Rep 1",
                              chromosome="chr6",
                              shape="box", fill="blue3", size=2)

peaks2_bonf.track = AnnotationTrack(peaks_rep2_bonf_gr,
                               genome="mm9", name="Corrected Peaks Rep 2",
                               chromosome="chr6",
                               shape="box", fill="blue3", size=2)

# Plot the corrected peaks
plotTracks(c(input.track, rep1.track, peaks1_bonf.track, rep2.track, peaks2_bonf.track, bm, AT),
           from=122630000, to=122700000,
           transcriptAnnotation="symbol", window="auto",
           type="histogram", cex.title=1, fontsize=10)

# Plot the B-H corrected peaks: left as an exercise!



