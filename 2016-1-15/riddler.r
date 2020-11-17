# https://fivethirtyeight.com/features/will-the-neurotic-basketball-player-make-his-next-free-throw/

library(pbapply)

shootFreethrows <- function(){
  shots <- c(1, 0)
  for(i in 3:100){
    p <- mean(shots)
    shot <- sample(x = c(1, 0), size = 1, prob = c(p, 1 - p))
    shots <- c(shots, shot)
  }
  if(shots[99] == 1){
    return(shots[100])
  }
}

shootFreethrowsRepeatedly <- function(){
  results <- unlist(pbreplicate(10000000, shootFreethrows()))
  return(mean(results))
}
