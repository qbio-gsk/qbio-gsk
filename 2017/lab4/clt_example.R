### CLT simulator
library(ggplot2)
library(dplyr)

### C/O Mohammed K. Barakat (https://rstudio-pubs-static.s3.amazonaws.com/90686_fed08479eb2840268063304254e7d52d.html)

# Establish that sum or average of IID RVs converge to the standard normal as N -> \infty
# Will demonstrate with exponentioal dist'n 

nosim <- 1000
n <- 40

lambda = 0.2
mn = 1/lambda
stdev = 1/lambda

set.seed(1)

# Generate the data

expdata <- data.frame(x=rexp(n*nosim, rate=lambda))
a <- ggplot(expdata, aes(x=x)) + 
  geom_histogram(alpha = 0.2, binwidth = 0.5, colour="black") + 
  labs(x="Random exp(x)", y="Frequency") + 
  ggtitle("Histogram representing the Exponential Distribution Simulated using 40,000 random exp values")

a          

### Now, we will apply the CLT to the exponential distribution by calculating the average of 40 exponentials simulated over 1000 times.
### Then, we will plot the 1000 averages of 40 exponentials and see how the new distribution looks like.

# Histogram of sample means

set.seed(1)
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(rexp(40,rate=lambda)))
expdatamns = data.frame(xmns = mns)
datamn = mean(expdatamns$xmns)

b <- ggplot(expdatamns, aes(x = xmns)) + 
  geom_histogram(alpha = 0.2, binwidth = 0.3, colour = "black") + 
  scale_x_continuous(breaks=2:8) + 
  labs(x = "Sample mean", y = "Frequency") + 
  ggtitle("Histogram of Exp Sample Means Sample size (n) = 40, simulations (nosim) = 1000")
b

# Compare sample mean versus theoretical mean

datamn = round(mean(expdatamns$xmns),2)  # average of 1000 means, one per subset
theomean = round(1/lambda,2)             # theoretical mean 1 / lambda

c <- b + geom_vline(xintercept=datamn,size=1.5,linetype=1) +
  geom_vline(xintercept=mn,size=1.5,linetype=2,colour="red") +
  annotate("text",x=7,y=125,label= "solid black: sample mean = 4.99\ndashed red: theoretical mean = 5.00",size=3,color="blue")

c

# Subtract the estimated mean, divide by the estimated std; do we recover a standard normal dist'n?

expdatamns<-mutate(expdatamns,nval=sqrt(n)*(expdatamns$xmns-mn)/stdev)

e <- ggplot(expdatamns, aes(x = nval)) + geom_histogram(alpha = .20, binwidth=.3, colour = "black", aes(y = ..density..)) +
  stat_function(fun = dnorm, size = 2)+
  geom_vline(xintercept=mean(expdatamns$nval),size=1)+
  labs(x="Normalized sample mean",y="Frequency")+
  theme(plot.title = element_text(size = 14, face = "bold", colour = "black", vjust = +1))+        
  ggtitle("Standard Normal Distribution of Exp Sample Means. Sample size (n) = 40, simulations (nosim) = 1000")
e

# Looks good, but a better test is to look at the quantile-quantile plots

qqnorm(expdatamns$xmns)
qqline(expdatamns$xmns)
