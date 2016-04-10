setwd("~/datafest2016/bennie_data_fest")
data <- read.csv("data/approved_data_purchase-v5.csv",
                 na.strings=c("NULL","NA",""))
vars.of.interest <- c(1,10,13:15,17,19,21:22,27:29)
data$la_valid_tkt_event_flg <- as.character(data$la_valid_tkt_event_flg)
data <- data[data$la_valid_tkt_event_flg == 'Y ',vars.of.interest]
data$event_dt <- as.Date(data$event_dt)
data$sales_ord_tran_dt <- as.Date(data$sales_ord_tran_dt)
data$print_dt <- as.Date(data$print_dt)
data$onsale_dt <- as.Date(data$onsale_dt)
data$days_purch_bef_event <- data$event_dt - data$sales_ord_tran_dt
data$days_purch_bef_print <- data$print_dt - data$sales_ord_tran_dt
data$days_onsale_bef_purch <- data$sales_ord_tran_dt - data$onsale_dt # not working
data <- data[,c(1:5,10,11,13:15)] #lose dates, at valid tkt event flg

install.packages("LPCM")
library(LPCM)
install.packages("cluster")
library(cluster)

# do this stuff, the following link was partially followed
# http://inseaddataanalytics.github.io/INSEADAnalytics/Report_s45.html
segment.vars <- 1:7 #timediffs don't work
seed(666)
sample.data <- data[sample(nrow(data), 25000),]
d <- daisy(sample.data[,segment.vars])
a <- agnes(d, method = "ward")
hist(d,xlim=c(0.15,0.75),breaks=300,ylim=c(0,600))
plot(a)
cut <- cutree(as.hclust(a), k=5) # pick num of clusters based on histogram
rect.hclust(as.hclust(a), k=max(cut), border="red") # puts boxes
purchase.sample$clusterID <- cut

# use to see counts of cluster ID by var
table(purchase.sample$delivery_type_cd, purchase.sample$clusterID)


with(purchase.sample, plot(tickets_purchased_qty, dist_to_ven, col = clusterID))
with(purchase.sample, boxplot(dist_to_ven ~ clusterID))
