# ggplot plotting library 
library(ggplot2) 
# defined values for the simulation
simulations <- 1000; lambda <- 0.2; observations <- 40;
# set the seed so alway are generated the same randome values
set.seed(108)
# random Simulation
sample = rep(0,simulations)
for (i in 1:simulations) sample[i] = mean(rexp(observations,rate=lambda))
# sample plot with histogram chart, bandwidth set between 0.1 - 0.5 show the
# distribution correctly.
ggp <- ggplot() + aes(sample) + 
  geom_histogram(binwidth=0.25, colour="black", fill="lightblue") + theme_bw() +
  labs(x = "mean", y = expression("Density")) + 
  labs(title=expression("Exponential distribution")) 
print(ggp)
## Sample mean and the theoretical mean of the distribution
# mean for the sample data
sample_mean <- mean(sample)
# theoretical mean
theoretical_mean <- 1/lambda
## Variability, sample variance compared to the theoretical variance of the distribution
# variance for the sample data 
sample_variance <- var(sample)
# theorical_variance
theoretical_variance <- (1/lambda)^2/observations
ggp <- ggplot() + aes(sample) + 
  geom_histogram(binwidth=0.25, colour="black", fill="lightblue") + theme_bw() + 
  # vertical lines for Sample and Theoretical Mean and Variance
  geom_vline(xintercept = sample_mean, colour="green", linetype = "dashed", size = 1.5) +
  geom_vline(xintercept = theoretical_mean, colour="red", linetype = "dashed", size = 1.5) +
  geom_vline(xintercept = sample_mean+sample_variance, colour="green", linetype = "dotted", size = 1.5) +
  geom_vline(xintercept = sample_mean-sample_variance, colour="green", linetype = "dotted", size = 1.5) +
  geom_vline(xintercept = theoretical_mean+theoretical_variance, colour="red", linetype = "dotted", size = 1.5) +
  geom_vline(xintercept = theoretical_mean-theoretical_variance, colour="red", linetype = "dotted", size = 1.5) +
  labs(title=expression("Exponential distribution"), x = "mean", y = expression("Density"))
print(ggp)
## Distribution approximately normalplotdata
# plot the normal distributed and the sample data
plotdata <- data.frame(sample)
ggp <- ggplot(plotdata, aes(x =sample)) + theme_bw() +
  geom_histogram(aes(y=..density..), binwidth=0.25, colour="black", fill = "lightblue") +
  geom_vline(xintercept=theoretical_mean,size=1.0, color="red",linetype ="longdash") +
  geom_vline(xintercept=sample_mean,size=1.0, color="green",linetype = "longdash") +
  stat_function(fun=dnorm,args=list( mean=theoretical_mean, sd=sqrt(theoretical_variance)),color = "red", size = 1.0) +
  stat_function(fun=dnorm,args=list( mean=sample_mean, sd=sqrt(sample_variance)),color = "green", size = 1.0) +
  labs(title=expression("Exponential distribution"), x = "mean", y = expression("Density"))
print(ggp)
# confidence interval
sample_ci <- round (mean(sample) + c(-1,1)*1.96*sd(sample)/sqrt(observations),3)
theoretical_ci <- theoretical_mean + c(-1,1)*1.96*sqrt(theoretical_variance)/sqrt(observations)
# Normal Q-Q Plot
qqnorm(sample) 
qqline(sample)

