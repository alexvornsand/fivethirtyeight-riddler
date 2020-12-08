# https://fivethirtyeight.com/features/can-you-solve-these-colorful-puzzles/

library(markovchain)

tMatrix <- matrix(
  c(
    0,1,0,0,0,
    0,1/2,1/6,1/3,0,
    0,0,1/3,2/3,0,
    0,0,1/4,1/2,1/4,
    0,0,0,0,1
  ),
  nrow = 5,
  byrow = T
)
markovChain <- new(
  "markovchain",
  states = c('i', 'j', 'k', 'l', 'm'),
  byrow = T,
  transitionMatrix = tMatrix,
  name = "colorDistribution"
)
meanAbsorptionTime(markovChain)
