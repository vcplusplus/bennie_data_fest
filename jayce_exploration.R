setwd('/Users/jayce/Desktop/bennie_data_fest/')
###CONSTANTS###
#data file paths
purchases.path <- 'data/approved_data_purchase-v5.csv'
adwords.path <- 'data/approved_adwords_v3.csv'
ga.path <- 'data/approved_ga_data_v2.csv'
#Others
sample.size <- 10000
#load purchases
purchases.all <- read.csv(purchase_path)
set.seed(666)
sample.purchases <- purchases_all[sample(nrow(purchases_all), sample.size),]
