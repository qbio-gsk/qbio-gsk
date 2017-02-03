require(ggplot2)

# Sample different p-values in relation to scenarios
# of http://varianceexplained.org/statistics/interpreting-pvalue-histogram/

generate_plots <- function(N, n_sig, effect_size){
  n_null = N - n_sig
  null_p <-data.frame(data = runif(n_null, 0,1), origin="null")
  sig_p <- data.frame(data = rexp(n_sig, effect_size), origin="alternative")
  df <- data.frame(rbind(null_p,sig_p))
  
  h <- ggplot(df) + geom_histogram(aes(x = data), bins = 50) + xlab("observed p-values") + ylab("count") + ggtitle("Histogram of observed Pvalues")
  h_fill <- ggplot(df, aes(fill = origin)) + geom_bar(aes(x = data), stat = "bin") + xlab("observed p-values") + ylab("count") + ggtitle("Histogram of observed Pvalues")
  return(list(histogram = h, mixture = h_fill))
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
figures <- generate_plots(N, n_sig, effect_size)

# Less ideal: fewer strong significant, more not significant
n_sig = 1000
effect_size = 15
figures <- generate_plots(N, n_sig, effect_size)

# Mixture of few strong significant, most not significant
n_sig = 500
figures <- generate_plots(N, n_sig, effect_size)

# Mixture of very few strong significant, almost all not significant
n_sig = 100
figures <- generate_plots(N, n_sig, effect_size)

# Let's weaken the effect size of the treatment, making the data more ambiguous
effect_size = 8

# Mixture of many weak significant, few not significant
n_sig = 5000
figures <- generate_plots(N, n_sig, effect_size)

# Mixture of many weak significant, few not significant
n_sig = 1000
figures <- generate_plots(N, n_sig, effect_size)

# Mixture of fewer weak significant, more not significant
n_sig = 500
figures <- generate_plots(N, n_sig, effect_size)

# Mixture of very few weak significant, almost all not significant
n_sig = 100
figures <- generate_plots(N, n_sig, effect_size)


# Just null
n_sig = 0
null_figures <- generate_null(N)
