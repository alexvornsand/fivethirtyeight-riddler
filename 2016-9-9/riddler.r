# https://fivethirtyeight.com/features/who-keeps-the-money-you-found-on-the-floor/

library(markovchain)
library(ggplot2)

findProbOfWinning <- function(n){
  gameStates <- c()
  for(i in 1:n){
    thisProf <- paste(letters[i %/% 26], letters[i %% 26], sep = '')
    gameStates <- c(gameStates, thisProf, paste('w_', thisProf, sep = ''))
  }
  tMatrixVals <- c()
  for(i in 1:(2*n)){
    matRow <- rep(0, 2*n)
    if(i %% 2 == 0){ # even rows
      matRow[i] <- 1
    }
    else { # odd rows
      if(i == 1){
        matRow[c(i + 1, i + 2, 2*n - 1)] <- 1/3
      }
      else if(i == (2*n - 1)){
        matRow[c(1, i - 2, i + 1)] <- 1/3
      }
      else {
        matRow[c(i - 2, i + 1, i + 2)] <- 1/3
      }
    }
    tMatrixVals <- c(tMatrixVals, matRow)
  }
  tMatrix <- matrix(tMatrixVals, nrow = (2*n), byrow = T)
  markovChain <- new("markovchain", states = gameStates, byrow = T, transitionMatrix = tMatrix, name = "StatsGambling")
  absProbs <- absorptionProbabilities(markovChain)
  return(absProbs[1,1])
}

chanceOfWinning <- unlist(lapply(4:10, findProbOfWinning))

ggplot() +
  geom_smooth(
    aes(
      x = 4:10,
      y = chanceOfWinning
    ),
    colour = '#007acc',
    se = F
  ) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(colour = '#1a1a1a'),
    plot.title = element_text(colour = "#1a1a1a"),
    axis.title.x = element_text(colour = "#1a1a1a"),
    axis.title.y = element_text(colour = "#1a1a1a"),
  ) +
  labs(
    title = 'Probability of Winning by Number of Professors',
    x = 'Number of Professors',
    y = 'Probability of Winning'
  )

ggsave(
  'riddler.png',
  width = 4,
  units = 'in',
  dpi = 'retina'
)
