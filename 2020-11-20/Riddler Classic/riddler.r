# https://fivethirtyeight.com/features/can-you-pass-the-cranberry-sauce/

findLastToSauce <- function(k){
  seats <- 0:(k-1)
  wantsSauce <- 1:(k-1)
  hasSauce <- 0
  while(length(wantsSauce) > 1){
    passTo <- sample(c(-1,1), 1)
    hasSauce <- (hasSauce + passTo) %% k
    if(hasSauce %in% wantsSauce){
      wantsSauce <- wantsSauce[wantsSauce != hasSauce]
    }
  }
  return(wantsSauce)
}

findLastToSauceRepeatedly <- function(n, k){
  x <- replicate(n, findLastToSauce(k))
  return(table(x) / n)
}

findLastToSauceRepeatedly(100000, 20)
