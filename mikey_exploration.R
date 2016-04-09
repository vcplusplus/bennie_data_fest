setwd("~/datafest2016/bennie_data_fest")
data <- read.csv("data/approved_data_purchase-v5.csv",
                 na.strings=c("NULL","NA",""))
vars.of.interest <- c(1,10,13:15,17:22,27:29,32:35,38,45)
purchase.sample <- data[sample(nrow(data), 2500),vars.of.interest]

install.packages("LPCM")
library(LPCM)
install.packages("cluster")
library(cluster)

# do this stuff, the following link was partially followed
# http://inseaddataanalytics.github.io/INSEADAnalytics/Report_s45.html
d <- daisy(purchase.sample[,segment.vars])
hist(d,xlim=c(0.4,0.8),breaks=500,ylim=c(0,50000))
segment.vars <- c(3,4,5,12,14)
d <- daisy(purchase.sample[sample(nrow(purchase.sample),15),segment.vars])
hc <- hclust(d)
a <- agnes(d, method = "ward")
plot(a)
cut <- cutree(as.hclust(a), k=5) # pick num of clusters based on histogram
summary(cut)
rect.hclust(as.hclust(a), k=max(cut), border="red") # puts boxes
purchase.sample$clusterID <- cut

# use to see counts of cluster ID by var
table(purchase.sample$tickets_purchased_qty, purchase.sample$clusterID)
