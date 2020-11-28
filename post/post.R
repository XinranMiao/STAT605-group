f = function(in_dir, out_dir,ncomp,nobs){
  files = list.files(paste0('~',in_dir))
  setwd(paste0('~',in_dir))
  age = c()
  X = array(rep(NA,nobs*ncomp*24),dim = c(ncomp,24,nobs))
  for(i in 1:length(files)){
    temp = read.csv(files[i])
    age = c(age,as.numeric(temp[1,2]))
    temp = temp[-1,-1]
    temp = as.matrix(temp)
    temp = t(temp)
    cat('temp=',dim(temp),'X[,,i]=',dim(X[,,i]),'\n')
    X[,,i] = temp
  }
  write.csv(X[1,,],'../comp20_1.csv')
  write.csv(X[2,,],'../comp20_2.csv')
  write.csv(X[3,,],'../comp20_3.csv')
  write.csv(X[4,,],'../comp20_4.csv')
  
  write.csv(age,'../comp20__age.csv')
}
