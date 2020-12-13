# https://fivethirtyeight.com/features/how-high-can-you-count-with-menorah-math/

library(arrangements)

colors <- c('r', 'b', 'g', 'r')
arrangements <- permutations(x = colors[1:3], k = 5, replace = T) # matrix of values

chooseHat <- function(pos, state){
  if(pos == 1){
    if(length(unique(state[4:5])) == 2){
      return(colors[min(which(colors %in% state[4:5]))])
    } else {
      return(state[4])
    }
  } else if(pos == 2){
    if(length(unique(state[4:5])) == 2){
      return(colors[min(which(colors %in% state[4:5]))])
    } else {
      return(state[4])
    }
  } else if(pos == 3){
    if(length(unique(state[4:5])) == 2){
      return(colors[min(which(colors %in% state[4:5]))])
    } else {
      return(state[4])
    }
  } else if(pos == 4){
    if(length(unique(state[1:3])) == 3){
      return('r')
    } else if(length(unique(state[1:3])) == 2){
      return(setdiff(c('r', 'b', 'g'), unique(state[1:3])))
    } else {
      return(colors[min(which(!(colors %in% state[1:3])))])
    }
  } else {
    if(length(unique(state[1:3])) == 3){
      return('r')
    } else if(length(unique(state[1:3])) == 2){
      return(setdiff(c('r', 'b', 'g'), unique(state[1:3])))
    } else {
      return(colors[min(which(!(colors %in% state[1:3])))])
    }
  }
}

allGuess <- function(state){
  guesses <- c()
  for(i in 1:5){
    # for each individual within the state, act according to defined function
    guesses <- c(guesses, chooseHat(i, state))
  }
  if(any(guesses == state)){
    result = 'Win'
  } else {
    result = 'Lose'
  }
  return(c(state, guesses, result, as.character(sum(guesses == state)), as.character(guesses == state)))
}

x <- matrix(unlist(apply(arrangements, 1, allGuess)), ncol = 17, byrow = T) # apply the group behavior to each row of matrix

View(x[x[,11] == 'Lose', c(1:5,11)])

View(x[x[,12] != '1',])
