# https://fivethirtyeight.com/features/can-you-unmask-the-secret-santas/

library(ggplot2)
library(showtext)

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

font_add_google(name = 'Montserrat', family = 'Montserrat')
font_add_google(name = 'Merriweather', family = 'Merriweather')
showtext_auto()

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
    axis.text.x = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    axis.text.y = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    plot.title = element_text(colour = '#1a1a1a', family = 'Montserrat', face = 'bold'),
    axis.title.x = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    axis.title.y = element_text(colour = '#1a1a1a', family = 'Merriweather'),
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
