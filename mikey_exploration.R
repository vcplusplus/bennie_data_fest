setwd("~/datafest2016/bennie_data_fest")
purchase.data <- read.csv("data/approved_data_purchase-v5.csv",
                          na.strings=c("NULL","NA",""))
purchase.sample <- purchase.data[sample(nrow(purchase.data), 15000),]
purchase.sample <- subset(purchase.sample, select = c(1,10,13,14,15,17:22,27:29,32:35,38,45))
install.packages("LPCM")
library(LPCM)
install.packages("cluster")
library(cluster)

complete.purchase.sample <- purchase.sample[complete.cases(purchase.sample),]
d <- daisy(complete.purchase.sample[sample(nrow(complete.purchase.sample),500),c(3,4)])
mean.shift <- ms(complete.purchase.sample[sample(nrow(complete.purchase.sample),500),c(3,4)], iter = 10)
