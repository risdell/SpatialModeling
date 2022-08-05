reff.mat <- function(x, sparse = FALSE){
  xf = factor(x)
  n = length(x)
  tm = matrix(
    model.matrix((1:n)~xf), 
    ncol = length(unique(xf)),
    nrow = n
  )
  tm[,1] = ifelse(rowSums(tm[,-1])==0, 1, 0)
  if(sparse == TRUE){
    tm[tm==0] <- NA
  }
  return(tm)
}