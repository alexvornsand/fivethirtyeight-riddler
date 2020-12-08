# https://fivethirtyeight.com/features/can-you-solve-these-colorful-puzzles/

library(markovchain)
library(ggplot2)

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

playColorGame <- function(n){
  balls <- 1:n
  colors <- 1:n
  turns <- 0
  while(length(unique(colors)) > 1){
    modelBall <- sample(balls, 1)
    paintedBall <- sample(balls[-modelBall], 1)
    colors[paintedBall] <- colors[modelBall]
    turns <- turns + 1
  }
  return(turns)
}

fourBallAvg <- mean(replicate(1000000, playColorGame(4)))

manyBallGames <- data.frame(n = integer(), turns = integer())
for(i in 3:100){
  for(j in 1:25){
    manyBallGames <- rbind(manyBallGames, data.frame(n = i, turns = playColorGame(i)))
  }
}
  
ggplot(data = manyBallGames) + 
  geom_point(
    aes(
      x = n,
      y = turns
    ),
    color = '#686868',
    alpha = 0.1
  ) +
  geom_smooth(
    aes(
      x = n,
      y = turns
    ),
    se = F,
    color = '#007acc'
  ) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(colour = '#1a1a1a'),
    plot.title = element_text(colour = '#1a1a1a'),
    axis.title.x = element_text(colour = '#1a1a1a'),
    axis.title.y = element_text(colour = '#1a1a1a'),
  ) +
  labs(
    title = 'Turns to Homogeneity',
    x = 'Number of Balls to Start With',
    y = 'Number of Turns Until All One Color'
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)
