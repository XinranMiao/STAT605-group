# ===== read data =====
setwd("/Users/hrl/Desktop/605Proj")
load("comp20.RData")
load("age.RData")
dat20 <- X_20
age20 <- age_20

dim(dat20) # 20  24 674

train_set <- dat20[,,1:450]
age_train <- age20[1:450]

valid_set <- dat20[,,451:550]
age_valid <- age20[451:550]

test_set  <- dat20[,,551:674]
age_test <- age20[551:674]
# ===== Functions =====

MyAbsCor <- function(v1, v2) # input two 1d vectors
{
  if(var(v1)*var(v2) == 0)
    out <- 0
  else
    out <- cor(v1, v2)
  
  return(out)
}

Aligned_Similarity <- function(m1, m2, top_n=3) # Aligned by row
{
  # --- settings ---
  dim_m1 <- dim(m1)
  nrow_m1 <- dim_m1[1]
  ncol_m1 <- dim_m1[2]
  
  zero_vec <- rep(0,ncol_m1)
  new_m1 <- array(0, dim = c(top_n, ncol_m1))
  new_m2 <- array(0, dim = c(top_n, ncol_m1))
  
  # --- align ---
  
  for(top_new in 1:top_n)
  {
    cor_matrix <- matrix(0, nrow = nrow_m1, ncol = nrow_m1)
    for(i in 1:nrow_m1)
    {
      for(j in 1:nrow_m1)
      {
        cor_matrix[i,j] <- MyAbsCor(m1[i,],m2[j,])
      }
    }
    
    max_ind <- which(cor_matrix==max(cor_matrix), arr.ind = T)
    
    new_m1[top_new,] <- m1[max_ind[1],]
    new_m2[top_new,] <- m2[max_ind[2],]
    m1[max_ind[1],]  <- zero_vec
    m2[max_ind[2],]  <- zero_vec
  }
  # --- compute similarity ---
  
  cor_vec <- rep(0,top_n)
  
  for(top_new in 1:top_n)
  {
    cor_vec[top_new] <- MyAbsCor(new_m1[top_new,], new_m2[top_new,])
  }
  
  Similarity <- sum(cor_vec)
  
  return(Similarity)
}
# debug
# Aligned_Similarity(test_set[,,1],test_set[,,2])


#
Find_Nearest <- function(data, person, agedat = age_train, k = 5) #  kNN with k=1
{
  dim_data <- dim(data) # 20 24 500
  n_comp <- dim_data[1] # 20
  n_sample <- dim_data[3] # 500
  
  dim_person <- dim(person) # 20 24
  
  cor_set <- rep(0, n_sample)
  
  for(index_sample in 1: n_sample)
  {
    M1 <- person
    M2 <- data[,,index_sample]
    cor_set[index_sample] <- Aligned_Similarity(M1,M2)
  }
  
  # out_index <- which(cor_set==max(cor_set))
  out_index <- order(cor_set, decreasing = T)[1:k]
  out_value <- mean(agedat[out_index])
  return(out_value)
}

# ===== run =====
# Find_Nearest(train_set,valid_set[,,1])
# age_valid[1]
# age20[]

#----- Validation set 
pred_age <- rep(0, length(age_valid))
cat("Total:")
cat(length(age_valid))
for(i in 1:length(age_valid))
{
  pred_age[i] <- Find_Nearest(train_set,valid_set[,,i],age_train) # running about 5 seconds
  cat(i)
  cat(",")
}

absE <- sum(abs(pred_age - age_valid)) / length(age_valid)
cat(absE)

#----- test set 
pred_age <- rep(0, length(age_test))
cat("Total:")
cat(length(age_test))
for(i in 1:length(age_test))
{
  pred_age[i] <- Find_Nearest(train_set,test_set[,,i],age_train) # running about 5 seconds
  cat(i)
  cat(",")
}

absE <- sum(abs(pred_age - age_test)) / length(age_test)
cat(absE)

#==== debug
# pred_age <- rep(0, length(age_train))
# cat("Total:")
# cat(length(age_train))
# for(i in 1:length(age_train))
# {
#   pred_age[i] <- Find_Nearest(train_set,train_set[,,i],age_train) # running about 5 seconds
#   cat(i)
#   cat(",")
# }
# 
# absE <- sum(abs(pred_age[1:50] - age_valid[1:50])) / length(age_valid)
# cat(absE)

# #
# pre_age <- rep(0, length(age_valid))
# cat("Total:")
# cat(length(age_valid))
# for(i in 1:length(age_valid))
# {
#   pre_age[i] <- Find_Nearest(train_set,train_set[,,i],age_train) # running about 5 seconds
#   cat(i)
#   cat(",")
# }
# pred_age <- age_train[pre_age]
# absE <- sum(abs(pred_age - age_valid)) / length(age_valid)
# cat(absE)
# 
# absE <- sum(abs(age_valid[1:50] - mean(age_valid))) / 50
# cat(absE)


