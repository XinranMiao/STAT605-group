
install.packages('stringr_1.4.0.tgz',repos=NULL, type="source")
require('stringr')
print("Load package stringr.")
files = read.table('files.txt')
age = c()
# 1000 *10 * 24 -> 1000 * 4 * 24 -> 1000 * 1 * 
X = array(rep(NA,2*4*24),dim = c(4,24,2))
for(i in 1:nrow(files)){
  file = readLines(files[i,])
  y = str_extract_all(file[1],'[0-9]') 
  y = unlist(y)
  y = paste(y,collapse = '')
  y = as.numeric(y)
  age = c(age,y)
  
  temp = read.csv(paste0('out_',files[i,]))
  
  temp = temp[,-1]
  temp = as.matrix(temp)
  temp = t(temp)
  cat('temp=',dim(temp),'X[,,i]=',dim(X[,,i]),'\n')
  X[,,i] = temp
}

f = function(X){
  return(X[1:2,24,2])
}

flatten = function(X){
  n1 = dim(X)[1]
  if(n1>1){
    mat = X[1,,]
    for (i in 2:n1) {
      mat = rbind(mat,X[i,,])
    }
  }
  return(mat)
}

mat = t(mat)
dat = cbind(y,mat)
dat = as.data.frame(dat)
mod = lm(y~.,dat)
save(mod,file = 'mod.RData')
