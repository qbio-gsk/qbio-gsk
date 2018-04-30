# Lab 10: Exploratory data analysis

### Monday April 30, 2018, 1-3pm


We will go over some tools to do exploratory analysis of your data in R. We will use these materials:
- [The vignette on exploratory analysis in R](http://jtleek.com/genstats/inst/doc/01_10_exploratory-analysis.html).
- [Lecture notes on clustering](https://docs.google.com/presentation/d/1YoXbjiRoowu0jhHFAu7U2g5Q21k6SNJyLNFAtJ8ZGtM/edit?usp=sharing).
- [The vignette on clustering in R](http://jtleek.com/genstats/inst/doc/01_13_clustering.html).
- [Lecture notes on dimensionality reduction](https://docs.google.com/presentation/d/1Tbxy5VvtB2o1_xouI8-wZE9rXVYU3VVOmC7YgHwU7DQ/edit?usp=sharing).
- [The vignette on dimensionality reduction in R](http://jtleek.com/genstats/inst/doc/02_03_dimension-reduction.html).
- [DESeq2 vignette](https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html).
- [How to use t-SNE effectively](https://distill.pub/2016/misread-tsne/).
- [MAGIC for scRNA-seq data imputation](https://github.com/KrishnaswamyLab/MAGIC) and [a Jupyter notebook with an example for bone marrow data](http://nbviewer.jupyter.org/github/KrishnaswamyLab/magic/blob/develop/python/tutorial_notebooks/Magic_single_cell_RNAseq_bone_marrow_data.ipynb).



Please prepare in advance by installing the following packages:

```R
install.packages(c("devtools", "gplots", "dendextend", "readr", "pheatmap",
                   "RColorBrewer"))
source("https://www.bioconductor.org/biocLite.R")
biocLite(c("Biobase", "org.Hs.eg.db", "AnnotationDbi", "pasilla", "vsn"))
biocLite("alyssafrazee/RSkittleBrewer")
```


## Additional materials

- [Last year's class on exploratory data analysis](../../2017/lab11).
- [Online book on genomics data analysis](http://genomicsclass.github.io/book/) including sections covering the same material as above: [Exploratory data analysis](http://genomicsclass.github.io/book/pages/exploratory_data_analysis.html), [Dimension reduction](http://genomicsclass.github.io/book/pages/pca_motivation.html), [SVD](http://genomicsclass.github.io/book/pages/svd.html), [PCA](http://genomicsclass.github.io/book/pages/PCA.html), [Clustering and heatmaps](http://genomicsclass.github.io/book/pages/clustering_and_heatmaps.html).
- [Tools for data visualization](http://selection.datavisualization.ch/).
- [More of interactive publications on data analysis](https://distill.pub/).
