base_dir = '~' # Set your base directory here
f = function(in_dir, out_dir,name){
  files = list.files(paste0(base_dir,in_dir))
  nobs = length(files)
  ncomp = ncol(temp) -1
  setwd(paste0(base_dir,in_dir))
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
  write.csv(X[1,,],paste0('../',name,'_1.csv'))
  write.csv(X[2,,],paste0('../',name,'_2.csv'))
  write.csv(X[3,,],paste0('../',name,'_3.csv'))
  write.csv(X[4,,],paste0('../',name,'_4.csv'))
  
  write.csv(age,paste0('../',name,'_age.csv'))
}
in_dir = '/comp20/weights_20_all'
out_dir = '/comp20'
name = 'comp20_all'
f(in_dir,out_dir ,name = name)
