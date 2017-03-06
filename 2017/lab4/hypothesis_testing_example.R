library(dplyr)
library(ggplot2)

install.packages("downloader")
library(downloader)

# Get some data to play with: weights of mice fed regular vs high-fat diet.
short_url <- "http://bit.ly/2mx6KIR"
# url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(short_url, destfile=filename)
dat <- read.csv("femaleMiceWeights.csv")

library(dplyr)
control <- filter(dat,Diet=="chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(dat,Diet=="hf") %>% select(Bodyweight) %>% unlist
print( mean(treatment) )


# We'd like to determine: is there a statistically significant effect of diet on the weights of these mice?
# We can't change the design of the experiment, but we can recognize the elements involved and validate  
# whether or not the conclusion is meaningful or not.
#
# First let's pick a leve of significance (alpha): 0.05

# Next, let's decide on a test statistic: the difference between the mean(treatment) and mean(control)
obsdiff <- mean(treatment) - mean(control)

# The control group in the above comparison was sampled (uniformly at random without replacement, AFAIK) from a 
# larger control population, provided below here.  Let's get it, and us it to construct an empirical null distribution of
# our test statistic

shorter_URL <- "http://bit.ly/2mu5Z2Z"
# url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- "femaleControlsPopulation.csv"
if (!file.exists(filename)){
  download(shorter_URL,destfile=filename)
  population <- read.csv(filename)
} 

# we take samples from control pop'n like so:
control <- sample(population$Bodyweight,12)

# Now we're ready to establish an empirical estimate of our distribution of our test statistic.
# Under the null distribution: there is no difference between the average weights in the high-fat diet mice and regular diet mice groups.
# So, if we randomly sample 24 mice from the control group, splitting them between 'treatment' and 'control', and take the mean(treatment) - mean(control),
# we can get an estimate of the distribution of our test statistic under the null hypothesis.

n <- 10000
null <- vector("numeric",n)
for (i in 1:n) {
  treatment <- sample(population$Bodyweight,12)
  control <- sample(population$Bodyweight,12)
  null[i] <- mean(treatment) - mean(control)
}

# put our observations into a data.frame
null_df <- as.data.frame(null)

# Now we can compute: what is the likelihood of observing a difference between the treatment and control groups 
# which is as large or larger than obsdiff?
mean(null >= obsdiff)


# let's plot the empirical null distribution, with a rejection region corresponding to alpha = 0.05
ggplot(null_df, aes(x = null)) + 
  geom_histogram() + 
  geom_vline(xintercept=1.96, linetype='dotted', color="red") + 
  geom_vline(xintercept=-1.96, linetype='dotted', colour="red") +
  geom_vline(xintercept = obsdiff) + 
  annotate("text",x=-obsdiff + 0.05, y=800,label="rejection region corresponding to alpha = 0.05",size=3, color="red") + 
  annotate("text",x=obsdiff + 1.05, y=800,label="<- observed difference",size=3, color="black") + 
  ggtitle("Empirical distribution of the differences between mean(treatment) - mean(control)")

# So, it looks as if we have good reason to reject the null hypothesis at this significance level alpha, at least if we model 
# the null distribution as a standard normal.  Is it a good fit?
qqnorm(null_df$null)
qqline(null_df$null)

# yeah, it's a good fit :)

# This test we did, where we construct an empirical null by repeated random sampling, is only one possible way to perform the test.  
# Another common way is to model the null distribution as a student-T, and do what's called a T-test.
# Read about that test here: http://genomicsclass.github.io/book/pages/t-tests_in_practice.html



###
# For posterity: here's the differences between the mean of the treatment group and control group 
# which I mistakenly calcuated.
# N.B: this is just to establish that the estimate of each group mean is precise, 
# it will not build the empirical null distribution of the test statistic

n <- 10000  # number of simulations to run
null <- vector("numeric",n)
for (i in 1:n) {
  control <- sample(population$Bodyweight,12) # sample 12 control mice
  null[i] <- mean(treatment) - mean(control)  # take the difference between the treatment mice and those control mice
}

# we should see a value of ~ 0.5 for mean(null >= obsdata)
mean(null >= obsdiff)