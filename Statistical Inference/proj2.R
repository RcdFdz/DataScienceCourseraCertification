library(ggplot2)
library(datasets)
data(ToothGrowth)

# Check the first 5 lines of the data
head(ToothGrowth, n = 5)
# Check the last 5 lines of the data
tail(ToothGrowth, n = 5)
# Check the basic structure.
str(ToothGrowth)

#Plot the data
ggp <- ggplot(aes(x = dose, y = len), data = ToothGrowth) +
  geom_point(aes(color=supp, shape = supp)) +
  labs(title=expression("Tooth Growth Data Analysis"), 
     x = "Dose (mg)", y = expression("Length of Teeth (mm)"))
print(ggp)

# Provide a basic summary of the data.
summary(ToothGrowth)

table(ToothGrowth$supp, ToothGrowth$dose)

by(ToothGrowth$len, INDICES = list(ToothGrowth$supp, ToothGrowth$dose), summary)

ggpsupp <- ggplot(aes(x = dose, y = len), data = ToothGrowth) + 
  geom_boxplot(aes(fill = factor(dose))) + facet_grid(.~supp) + theme_bw() + 
  guides(fill=guide_legend(title="Dose (mg)")) +
  labs(title=expression("Tooth Growth Data Analysis"), 
       x = "Dose (mg)", y = expression("Length of Teeth (mm)"))
print(ggpsupp)

# Confidence intervals and hypothesis tests to compare tooth growth by 
# supp and dose.

suppT1 <- t.test(len~supp, paired=F, var.equal=T, data=ToothGrowth)
suppT2 <- t.test(len~supp, paired=F, var.equal=F, data=ToothGrowth)
suppRes <- data.frame("ConfLow"=c(suppT1$conf[1],suppT2$conf[1]),
                      "ConfHigh"=c(suppT1$conf[2],suppT2$conf[2]), 
                      "PValue"=c(suppT1$p.value, suppT2$p.value),
                      row.names=c("Eq. Var.","Uneq. Var."))
suppRes

# T-Test by supplemant
t.test(len ~ supp, data = ToothGrowth)

# T-test by dose  
tgDose0.5_1 <- subset(ToothGrowth, dose %in% c(0.5, 1.0))
t.test(len ~ dose, data = tgDose0.5_1)

tgDose1_2 <- subset(ToothGrowth, dose %in% c(1.0, 2.0))
t.test(len ~ dose, data = tgDose1_2)

# T test for supplement by dose
tgDose0.5 <- subset(ToothGrowth, dose == 0.5)
t.test(len ~ supp, data = tgDose0.5)

tgDose1 <- subset(ToothGrowth, dose == 1.0)
t.test(len ~ supp, data = tgDose1)

tgDose2 <- subset(ToothGrowth, dose == 2.0)
t.test(len ~ supp, data = tgDose2)
