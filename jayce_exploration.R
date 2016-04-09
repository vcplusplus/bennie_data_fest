setwd('/Users/jayce/Desktop/bennie_data_fest/')
###CONSTANTS###
#data file paths
purchases.path <- 'data/approved_data_purchase-v5.csv'
adwords.path <- 'data/approved_adwords_v3.csv'
ga.path <- 'data/approved_ga_data_v2.csv'
#Others
sample.size <- 10000
#load purchases
purchases.all <- read.csv(purchases.path, na.strings = c("NULL","NA",""))
set.seed(666)
purchases.sample <- purchases.all[sample(nrow(purchases.all), sample.size),]
purchases.sample.subset <- subset(purchases.sample, select = c(1,10,13,14,15,17:22,27:29,32:35,38,45))
purchases.sample.subset$event_date <- as.Date(purchases.sample.subset$event_dt)
