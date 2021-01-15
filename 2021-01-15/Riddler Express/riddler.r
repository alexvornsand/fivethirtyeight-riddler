# https://fivethirtyeight.com/features/can-you-hunt-for-the-mysterious-numbers/

library(pbapply)
library(ggplot2)
library(showtext)

simOneGuess <- function(guess){
  result <- runif(1, min = 0, max = 100)
  if(result > guess){
    return(guess)
  } else {
    return(0)
  }
}

simSeveralGuessses <- function(guess){
  return(mean(replicate(1000, simOneGuess(guess))))
}

guesses <- runif(10000, min = 0, max = 100)
guessData <- pbsapply(guesses, simSeveralGuessses)

font_add_google(name = 'Montserrat', family = 'Montserrat')
font_add_google(name = 'Merriweather', family = 'Merriweather')
showtext_auto()

ggplot() + 
  geom_point(
    aes(
      x = guesses,
      y = guessData
    ),
    color = '#007acc',
    alpha = 0.1
  ) + 
  geom_line(
    aes(
      x = sort(guesses),
      y = sort(guesses) * (100 - sort(guesses)) / 100
    ),
    color = '#1a1a1a'
  ) +
  theme_bw() +
    ggtitle('You Bet Your Fife') +
    xlab('Guess') +
    ylab('Expected Winnings') +
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
    legend.position = 'none'
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)