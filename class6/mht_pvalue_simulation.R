require(ggplot2)
require(data.table)
require(gridExtra)

# install qvalue
source("https://bioconductor.org/biocLite.R")
biocLite("qvalue")

# Sample different p-values in relation to scenarios
# of http://varianceexplained.org/statistics/interpreting-pvalue-histogram/

generate_data <- function(N, n_sig, effect_size){
  n_null = N - n_sig
  null_p <-data.frame(data = runif(n_null, 0,1), origin="null")
  sig_p <- data.frame(data = rexp(n_sig, effect_size), origin="alternative")
  df <- data.frame(rbind(null_p,sig_p))
  dt <- data.table(df)
  qvals <- qvalue(dt[,data])$qvalues
  dt[, bon_corrected := p.adjust(data, method = "bonferroni")]
  dt[, fdr_corrected := p.adjust(data, method = "fdr")]
  dt[, qval_corrected := qvals]
  return(dt)
}

generate_hists <- function(simulated_data){
  no_correction <- ggplot(simulated_data) + geom_histogram(aes(x = data), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Uncorrected Pvalues")
  bonf <- ggplot(simulated_data) + geom_histogram(aes(x = bon_corrected), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Bonferroni corrected Pvalues")
  fdr <- ggplot(simulated_data) + geom_histogram(aes(x = fdr_corrected), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("FDR corrected Pvalues")
  qval <- ggplot(simulated_data) + geom_histogram(aes(x = qval_corrected), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Qvalue corrected Pvalues")  
  plt_list <- list()
  plt_list[[1]] <- no_correction
  plt_list[[2]] <- bonf
  plt_list[[3]] <- fdr
  plt_list[[4]] <- qval
  return(plt_list)
}

generate_fills <- function(simulated_data){
  null_fill <- ggplot(simulated_data, aes(fill = origin)) + geom_bar(aes(x = data), stat = "bin") + geom_vline(xintercept = 0.05, lty = "dashed") + xlab("observed p-values") + ylab("count") + ggtitle("Uncorrected Pvalues")
  bonf_fill <- ggplot(simulated_data, aes(fill = origin)) + geom_bar(aes(x = bon_corrected), stat = "bin") + geom_vline(xintercept = 0.05, lty = "dashed") + xlab("observed p-values") + ylab("count") + ggtitle("Bonferroni corrected Pvalues")
  fdr_fill <- ggplot(simulated_data, aes(fill = origin)) + geom_bar(aes(x = fdr_corrected), stat = "bin") + geom_vline(xintercept = 0.05, lty = "dashed") + xlab("observed p-values") + ylab("count") + ggtitle("FDR corrected Pvalues")
  qval_fill <- ggplot(simulated_data, aes(fill = origin)) + geom_bar(aes(x = qval_corrected), stat = "bin") + geom_vline(xintercept = 0.05, lty = "dashed") + xlab("observed p-values") + ylab("count") + ggtitle("Qvalue corrected Pvalues")
  plt_list <- list()
  plt_list[[1]] <- null_fill
  plt_list[[2]] <- bonf_fill
  plt_list[[3]] <- fdr_fill
  plt_list[[4]] <- qval_fill
  return(plt_list)
}

generate_null <- function(N){
  null_p <-data.frame(data = runif(N, 0,1), origin="null")
  df <- data.frame(rbind(null_p))
  h <- ggplot(df) + geom_histogram(aes(x = data)) + xlab("observed p-values") + ylab("count") + ggtitle("Histogram of observed Pvalues")
  return(list(histogram = h))
}

### Try the different simulations to better understand what p-values mean when an experiment is running as expected.

# Let's do 20000 tests
N = 20000

# Ideal: Strong effect, mixture of lots of significant, some not significant
n_sig = 5000
effect_size = 15
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
fills <- generate_fills(sim_data)
do.call(grid.arrange, hists)
do.call(grid.arrange, fills)

# Less ideal: fewer strong significant, more not significant
n_sig = 1000
effect_size = 15
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
fills <- generate_fills(sim_data)
do.call(grid.arrange, hists)


# Mixture of few strong significant, most not significant
n_sig = 500
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

# Mixture of very few strong significant, almost all not significant
n_sig = 100
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

# Let's weaken the effect size of the treatment, making the data more ambiguous
effect_size = 8

# Mixture of many weak significant, few not significant
n_sig = 5000
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

# Mixture of many weak significant, few not significant
n_sig = 1000
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

# Mixture of fewer weak significant, more not significant
n_sig = 500
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

# Mixture of very few weak significant, almost all not significant
n_sig = 100
sim_data <- generate_data(N, n_sig, effect_size)
hists <- generate_hists(sim_data)
do.call(grid.arrange, hists)

