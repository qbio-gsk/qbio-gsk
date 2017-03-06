library(dplyr)
library(ggplot2)

install.packages("downloader")
library(downloader)

# Get some data to play w.
short_url <- "http://bit.ly/2mx6KIR"
#url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(short_url, destfile=filename)
dat <- read.csv("femaleMiceWeights.csv")

library(dplyr)
control <- filter(dat,Diet=="chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(dat,Diet=="hf") %>% select(Bodyweight) %>% unlist
print( mean(treatment) )

# calculate the difference in the mean(control), mean(treatment)
obsdiff <- mean(treatment) - mean(control)


# # Control pop'n
shorter_URL <- "http://bit.ly/2mu5Z2Z"
# url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- "femaleControlsPopulation.csv"
if (!file.exists(filename)) download(url,destfile=filename)
population <- read.csv(filename)
population <- unlist(population) # turn it into a numeric
View(population)

# take samples from control pop'n
control <- sample(population$Bodyweight[13:24],8)

# establish an empirical null distribution of the
# mean of the weights of control mice
n <- 10000
null <- vector("numeric",n)
for (i in 1:n) {
  control <- sample(population$Bodyweight[1:12],8)
  treatment <- sample(population$Bodyweight[13:24],8)
  null[i] <- mean(treatment) - mean(control)
}


# establish an empirical null distribution of the mean of the weights of control mice
n <- 10000
null <- vector("numeric",n)
for (i in 1:n) {
  treatment <- sample(population$Bodyweight,12)
  control <- sample(population$Bodyweight,12)
  null[i] <- mean(treatment) - mean(control)
}

# what is the mean difference in treatment vs control from our simulation?
mean(null >= obsdiff)


# plot the distribution, with our rejection region
ggplot(null_df, aes(x = null)) + 
  geom_histogram() + 
  geom_vline(xintercept=1.96, linetype='dotted', color="red") + 
  geom_vline(xintercept=-1.96, linetype='dotted', colour="red") +
  geom_vline(xintercept = obsdiff) + 
  ggtitle("Empirical distribution of the differences between mean(treatment) - mean(control)")

