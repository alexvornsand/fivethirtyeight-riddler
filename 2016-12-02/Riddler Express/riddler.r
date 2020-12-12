# https://fivethirtyeight.com/features/can-you-unmask-the-secret-santas/

library(ggplot2)

droughts <- rep(0, 30)

droughtBroken <- c()
playSeason <- function(){
  longestDrought <- max(droughts)
  droughtHolder <- which(droughts == max(droughts))
  winner <- sample(1:30, 1)
  if(winner %in% droughtHolder){
    droughtBroken <<- c(droughtBroken, longestDrought)
  } else {
    droughtBroken <<- c(droughtBroken, NA)
  }
  droughts[-winner] <<- droughts[-winner] + 1
  droughts[winner] <<- 0
}

replicate(10000000, playSeason())

ggplot() +
  geom_point(
    aes(
      x = 100:length(droughtBroken),
      y = droughtBroken[100:length(droughtBroken)]
    ),
    color = '#686868'
  ) +
  geom_smooth(
    aes(
      x = 100:length(droughtBroken),
      y = droughtBroken[100:length(droughtBroken)]
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
    title = 'Average Longest Streak Ended by Season',
    x = 'Seasons Since Beginning',
    y = 'Drought Length in Seasons'
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)
