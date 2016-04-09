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
#subset variables
purchases.variables <- c(1,10,13,14,15,17:22,27:29,32:35,38,45)
purchases.sample.subset <- subset(purchases.sample, select = purchases.variables)

#compute number of days difference between transaction date and event date
purchases.sample.subset$event_date <- as.Date(purchases.sample.subset$event_dt)
purchases.sample.subset$purchase_date <- as.Date(purchases.sample.subset$sales_ord_tran_dt)
purchases.sample.subset$event_purchase_difference <- purchases.sample.subset$event_date - purchases.sample.subset$purchase_date

#trim junk events
purchases.sample.subset.good <- purchases.sample.subset[purchases.sample.subset$la_valid_tkt_event_flg == 2,]
str(purchases.sample.subset)
