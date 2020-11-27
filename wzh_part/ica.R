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
weight = ica$K

write.csv(weight,file = paste0('out_',input))

