# https://fivethirtyeight.com/features/can-you-snatch-defeat-from-the-jaws-of-victory/

calcPOfWinning <- function(n, h, N){
  # n is the number of throws so far
  # h is the number of heads so far
  # N is the total number of throws
  # H is the heads needed to win
  H <- ceiling((N + 1) / 2)

  # R is the heads needed left to win
  R <- H - h
  # r is the remaining throws
  r <- N - n
  q <- 0
  if(h > n){
    q <- 0
  } else if(R > r){
    q <- 0
  } else {
    for(i in R:r){
      q <- q + (choose(r, i) / 2 ^ r)
    }
  }
  q
}

calcPOfState <- function(n, h){
  # n is the number of throws so far
  # h is the number of heads so far
  if(h < n){
    q <- 0
  } else {
    q <- choose(n, h) / 2 ^ n
  }
}

fillPWinMatrix <- function(N){
  pMat <- matrix(NA, ncol = N, nrow = N)
  for(i in 1:N){
    for(j in 1:N){
      pMat[i,j] <- calcPOfWinning(i-1, j-1, N)
    }
  }
  pMat
}

transformPWinMatrix <- function(m, p = .99){
  for(i in dim(m)[1]){
    for(j in dim(m)[2]){
      if(m[i,j] < p | m[i,j] == 1){
        m[i,j] <- 0
      } else {
        m[i,j] <- 1 - m[i,j]
      }
    }
  }
  m
}

fillPStateMatrix <- function(N){
  pMat <- matrix(NA, ncol = N, nrow = N)
  for(i in 1:N){
    for(j in 1:N){
      pMat[i,j] <- calcPOfState(i-1, j-1)
    }
  }
  pMat
}


playGame <- function(N){
  H <- ceiling((N + 1) / 2)
  flips <- sample(c(0,1), N, replace = T)
  n <- 0
  h <- 0
  p <- 0
  for(f in flips){
    q <- calcPOfWinning(n, h, N)
    if(q > p){
      p <- q
    }
    h <- h + f
    n <- n + 1
  }
  r <- p > .99 & h < H
  r
}

playGameRepeatedly <- function(N){
  x <- replicate(10000, playGame(N))
  y <- mean(x)
  y
}

playGameRepeatedly(1001)
