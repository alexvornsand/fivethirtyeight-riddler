# https://fivethirtyeight.com/features/can-you-skillfully-ski-the-slopes/

library(pbapply)
library(ggplot2)
library(showtext)

race <- function(n){
  while(T){
    firstTrial <- rnorm(n)
    if(which.min(firstTrial) == n){
      secondTrial <- rnorm(n)
      times <- firstTrial + secondTrial
      return(which.min(times) == n)
    }
  }
}

mean(pbreplicate(1000000, race(30)))

x <- 4

plotData <- pbsapply(2:100, function(x){return(data.frame('x' = rep(x, 1000), 'p' = replicate(1000, mean(replicate(100, race(x))))))})
x <- c()
for(i in 1:99){
  x <- c(x, plotData[[2 * i - 1]])
}
p <- c()
for(i in 1:99){
  p <- c(p, plotData[[2 * i]])
}
plotDf <- data.frame(
  'x' = x,
  'p' = p
)

font_add_google(name = 'Montserrat', family = 'Montserrat')
font_add_google(name = 'Merriweather', family = 'Merriweather')
showtext_auto()

ggplot() + 
  geom_jitter(
    data = plotDf,
    aes(
      x = x,
      y = p
    ),
    color = '#007acc',
    alpha = 0.1
  ) + 
  geom_line(
    data = aggregate(p ~ x, data = plotDf, mean),
    aes(
      x = x,
      y = p
    ),
    color = '#1a1a1a'
  ) +
  theme_bw() +
  ggtitle('Probability of Winning Downhill Race') +
  xlab('Number of Competitors') +
  ylab('Probability of Victory') +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(colour = '#1a1a1a'),
    axis.text.x = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    axis.text.y = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    plot.title = element_text(colour = '#1a1a1a', family = 'Montserrat', face = 'bold'),
    axis.title.x = element_text(colour = '#1a1a1a', family = 'Merriweather'),
    axis.title.y = element_text(colour = '#1a1a1a', family = 'Merriweather')
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)
