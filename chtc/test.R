rm(list=ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 1){
  input = args[1]
} else {
  cat('usage: Rscript hw5.R <template spectrum> <data directory>\n', file=stderr())
  stop()
}
install.packages('fastICA_1.2-2.tar.gz',repos=NULL, type="source")
require('fastICA')
install.packages('stringi_1.5.3.tar.gz',repos=NULL, type="source")
require('stringi')
install.packages('glue_1.4.2.tar.gz',repos=NULL, type="source")
require('glue')
install.packages('magrittr_2.0.1.tar.gz',repos=NULL, type="source")
require('magrittr')
install.packages('stringr_1.4.0.tgz',repos=NULL, type="source")
require('stringr')
if (require("fastICA")) { # require() is like library(), but returns TRUE or FALSE
  print("Loaded package fastICA.")
} else {
  print("Failed to load package fastICA.")  
}

x = read.csv(input, skip = 1)
if((nrow(x)<300000) |( ncol(x) < 24)){
  cat("nrow = ",nrow(x),'ncol = ',ncol(x),'\n')
}
x = x[1:300000,1:24]
ica = fastICA(x, n.comp = 4)
weight = ica$A
weight = t(weight)
print('finished ICA')
file = readLines(input)
y = str_extract_all(file[1],'[0-9]')
y = unlist(y)
y = paste(y,collapse = '') 
y = as.numeric(y)
y = c(y,rep(0,ncol(weight)-1))
weight = rbind(y,weight)
write.csv(weight,file = paste0('out_',input))
