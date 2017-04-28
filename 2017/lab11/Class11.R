rm(list=ls())
set.seed(100)
options(stringsAsFactors = FALSE)

# source("https://bioconductor.org/biocLite.R")
# biocLite("DESeq2")

require(DESeq2)
counts = read.csv("/Users/osmanbeh/Documents/Courses/gsk-qbio/class11/Count_Table_Project_5384_J.csv", row.names = 1, check.names = F )
colnames(counts) <- c("DPEneg1_Faki","DPEneg2_Faki","DPEneg2_Untx","DPEneg3_Faki","DPEneg3_Untx","DPEpos1_Faki","DPEpos1_Untx","DPEpos2_Faki","DPEpos3_Faki","DPEpos3_Untx","ItgB4single1_Faki",
                      "ItgB4single2_Faki","ItgB4single3_Faki","ItgB4single1_Untx","ItgB4single3_Untx" )
countTable = counts[,c("DPEneg1_Faki","DPEneg2_Faki","DPEneg2_Untx","DPEneg3_Faki","DPEneg3_Untx","DPEpos1_Faki","DPEpos1_Untx","DPEpos2_Faki","DPEpos3_Faki","DPEpos3_Untx")]

head(countTable)
dim(countTable)

colData <- data.frame(SampleName = colnames(countTable), 
                      cell = as.factor(substring(colnames(countTable),1,6)), 
                      condition = as.factor(substring(colnames(countTable),9,12)))
rownames(colData) = colnames(countTable)

head(colData)
############
dds <- DESeqDataSetFromMatrix(countData = countTable,
                              colData = colData,
                              design = ~ cell + condition)
dds
####Exploratory analysis and visualization
summary(rowSums(counts(dds)))
summary(colSums(counts(dds)))
summary(rowMeans(counts(dds)))
summary(colMeans(counts(dds)))

?boxplot
boxplot(counts(dds))
boxplot(log2(counts(dds)+1), las = 2, cex.axis=0.5)

hist(log2(counts(dds)[,1]+1))
hist(log2(counts(dds)[,1]+1), breaks=10)
hist(log2(counts(dds)[,1]+1), breaks=100)
#########
dds <- dds[ rowSums(counts(dds)) > 1, ]
nrow(dds)
########
barplot(colSums(counts(dds)), las=2)
dds <- estimateSizeFactors(dds)

nt <- log2(counts(dds, normalized=TRUE) + 1)
colnames(nt) = colnames(countTable)

rld <- rlog(dds, blind = FALSE)
head(assay(rld), 3)

vsd <- vst(dds, blind = FALSE)
head(assay(vsd), 3)
###PCA plot - relationship between samples
plotPCA(rld, intgroup = c("cell", "condition"))
plotPCA(vsd, intgroup = c("cell", "condition"))

pcaData <- plotPCA(rld, intgroup = c("cell", "condition"), returnData = TRUE)
pcaData

percentVar <- round(100 * attr(pcaData, "percentVar"))
require(ggplot2)
ggplot(pcaData, aes(x = PC1, y = PC2, color = dex, shape = cell)) +
  geom_point(size =3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  coord_fixed()
####
pca = princomp(as.matrix((nt)))$loadings[,1:2]
###t-SNE
#install.packages("Rtsne")
require(Rtsne)
rtsne_out <- Rtsne(as.matrix((nt)))
plot(rtsne_out$Y, main="", pch = 20,xlab = "x-tsne", ylab = "y-tsne")

###Clustering
# By default calculates the distance between rows
dist1 = dist(t(assay(rld)))

## Look at distance matrix
pheatmap(as.matrix(dist1),Colv=NA,Rowv=NA)

##Now cluster the samples
hclust1 = hclust(dist1)
plot(hclust1)

##We can also force all of the leaves to terminate at the same spot
plot(hclust1,hang=-1)

library("genefilter")
topVarGenes <- head(order(rowVars(assay(rld)), decreasing = TRUE), 20)
mat  <- assay(rld)[ topVarGenes, ]
mat  <- mat - rowMeans(mat)
anno <- as.data.frame(colData(rld)[, c("cell", "condition")])

#install.packages("pheatmap")
require(pheatmap)
# pheatmap(mat, color = colorRampPalette(rev(brewer.pal(n = 7, name =
#                                                         "RdYlBu")))(100), kmeans_k = NA, breaks = NA, border_color = "grey60",
#          cellwidth = NA, cellheight = NA, scale = "none", cluster_rows = TRUE,
#          cluster_cols = TRUE, clustering_distance_rows = "euclidean",
#          clustering_distance_cols = "euclidean", clustering_method = "complete",
#          clustering_callback = identity2, cutree_rows = NA, cutree_cols = NA,
#          treeheight_row = ifelse((class(cluster_rows) == "hclust") || cluster_rows,
#                                  50, 0), treeheight_col = ifelse((class(cluster_cols) == "hclust") ||
#                                                                    cluster_cols, 50, 0), legend = TRUE, legend_breaks = NA,
#          legend_labels = NA, annotation_row = NA, annotation_col = NA,
#          annotation = NA, annotation_colors = NA, annotation_legend = TRUE,
#          annotation_names_row = TRUE, annotation_names_col = TRUE,
#          drop_levels = TRUE, show_rownames = T, show_colnames = T, main = NA,
#          fontsize = 10, fontsize_row = fontsize, fontsize_col = fontsize,
#          display_numbers = F, number_format = "%.2f", number_color = "grey30",
#          fontsize_number = 0.8 * fontsize, gaps_row = NULL, gaps_col = NULL,
#          labels_row = NULL, labels_col = NULL, filename = NA, width = NA,
#          height = NA, silent = FALSE, ...)

pheatmap(mat, annotation_col = anno)
?pheatmap


