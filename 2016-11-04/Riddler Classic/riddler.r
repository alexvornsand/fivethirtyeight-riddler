# https://fivethirtyeight.com/features/a-puzzle-will-you-yes-you-decide-the-election/

library(ggplot2)

probOfPivotalVote <- function(n){
  x <- 2 * n
  return(choose(x, x / 2) / 2 ^ x)
}

probsOfPV <- unlist(lapply(4:250, probOfPivotalVote))

simOneVote <- function(n){
  x <- 2 * n
  return(sum(sample(c(1,0), size = x, replace = T)) == x / 2)
}

simOneBatchOfVotes <- function(n){
  return(mean(replicate(40, simOneVote(n))))
}

simSeveralBatchesOfVotes <- function(n){
  return(replicate(20, simOneBatchOfVotes(n)))
}

estProbsOfPV <- lapply(4:250, simSeveralBatchesOfVotes)
estAvgProbOfPV <- c()
for(i in 1:length(estProbsOfPV)){
  estAvgProbOfPV <- c(estAvgProbOfPV, mean(estProbsOfPV[[i]]))
}

ggplot() +
  geom_point(
    aes(
      x = rep(2 * 4:250, each = 20),
      y = unlist(estProbsOfPV)
    ),
    color = '#686868',
    alpha = 0.1
  ) +
  geom_line(
    aes(
      x = rep(2 * 4:250),
      y = estAvgProbOfPV
    ),
    color = '#686868',
    linetype = 'dashed'
  ) +
  geom_line(
    aes(
      x = 2 * 4:250,
      y = probsOfPV
    ),
    colour = '#007acc'
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
    title = 'Probability of Casting the Deciding Vote by Number of Other Voters',
    x = 'Number of Other Voters',
    y = 'Probability of Casting the Deciding Vote'
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)
