# https://fivethirtyeight.com/features/can-you-not-flip-your-lid/

library(pbapply)
library(ggplot2)

gameOfAttrition <- function(n, m){
  turn <- 1
  while(n > 0 & m > 0){
    if(turn == 1){
      m <- m - n
      turn <- turn * -1
    } else {
      n <- n - m
      turn <- turn * -1
    }
  }
  return(which(c(n, m) == max(c(n, m))))
}

findMaxVal <- function(k){
  return(max(which(unlist(sapply(1:(2*k), gameOfAttrition, n = k)) == 1)))
}

testRange <- function(n){
  maxVals <<- pbsapply(1:n, findMaxVal)
  maxValsRelToN <<- maxVals - 1:n
  maxValsRelToPrev <<- maxValsRelToN - c(0, maxValsRelToN[1:length(maxValsRelToN) - 1])
  
  ggplot() + 
    geom_point(
      aes(
        x = 1:n,
        y = maxValsRelToPrev
      )
    )
}

testRange(10000)

