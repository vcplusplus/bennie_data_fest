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
purchases.all$la_valid_tkt_event_flg <- as.character(purchases.all$la_valid_tkt_event_flg)
purchases.all.good <- purchases.all[purchases.all$la_valid_tkt_event_flg == 'Y ',]
purchases.all.bad <- purchases.all[purchases.all$la_valid_tkt_event_flg != 'Y ',]

purchases.all.good <- subset(purchases.all.good, select = c(1:31,45))

set.seed(666)
purchases.sample.good <- purchases.all.good[sample(nrow(purchases.all.good), sample.size),]
#subset variables
purchases.variables.good <- c(1,5,10,13,14,15,17:22,27:28,32)
purchases.sample.subset.good <- subset(purchases.sample.good, select = purchases.variables.good)

#compute number of days difference between transaction date and event date
purchases.sample.subset.good$event_date <- as.Date(purchases.sample.subset.good$event_dt)
purchases.sample.subset.good$purchase_date <- as.Date(purchases.sample.subset.good$sales_ord_tran_dt)
purchases.sample.subset.good$onsale_date <- as.Date(purchases.sample.subset.good$onsale_dt)
purchases.sample.subset.good$order_created_date <- as.Date(purchases.sample.subset.good$sales_ord_create_dttm)
purchases.sample.subset.good$print_date <- as.Date(purchases.sample.subset.good$print_dt)

purchases.sample.subset.good$event_purchase_time_difference <- purchases.sample.subset.good$event_date - purchases.sample.subset.good$purchase_date
purchases.sample.subset.good$purchase_print_time_difference <- purchases.sample.subset.good$print_date - purchases.sample.subset.good$purchase_date
purchases.sample.subset.good$onsale_purchase_time_difference <- purchases.sample.subset.good$purchase_date - purchases.sample.subset.good$onsale_date
purchases.sample.subset.good$order_purchase_time_difference <- purchases.sample.subset.good$purchase_date - purchases.sample.subset.good$order_created_date

purchases.sample.subset.good <- subset(purchases.sample.subset.good, select = c(1:6,13:15, 21:24)) 

#trim junk events
# str(purchases.sample.subset)
