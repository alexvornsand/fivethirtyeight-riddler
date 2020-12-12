# https://fivethirtyeight.com/features/how-high-can-you-count-with-menorah-math/

library(arrangements)

arrangements <- permutations(x = c('r', 'b', 'g'), k = 5, replace = T)

chooseHat <- function(pos, state){
  if(pos %in% 1:3){ # if in the group of three
    if('r' %in% state[4:5]){ # if you can see red
      return('r') # choose red
    } else if('b' %in% state[4:5]){ # if you can see blue
      return('b') # choose blue
    } else { # otherwise
      return('g') # choose green
    }
  } else { # if in the group of two
    if(length(unique(state[1:3])) == 3){ # if there are three different colors you can see
      return('r') # return red (highest priority)
    } else if(length(unique(state[1:3])) == 2){ # if there are two different colors you see
      return(setdiff(c('r', 'b', 'g'), unique(state[1:3]))) # return the one you don't see
    } else { # if there's only one color
      if('r' %in% state[1:3]){ # and it's red
        return('g') # choose green
      } else if('b' %in% state[1:3]){ # and it's blue
        return('r') # choose red
      } else { # and it's green
        return('b') # choose blue
      }
    }
  }
}

allGuess <- function(state){
  guesses <- c()
  for(i in 1:5){
    guesses <- c(guesses, chooseHat(i, state))
  }
  if(any(guesses == state)){
    result = 'Win'
  } else {
    result = 'Lose'
  }
  return(c(state, guesses, result, as.character(sum(guesses == state)), as.character(guesses == state)))
}

x <- matrix(unlist(apply(arrangements, 1, allGuess)), ncol = 17, byrow = T)
x[x[,11] == 'Lose', c(1:5,11)]
View(x[x[,12] != '1',])
