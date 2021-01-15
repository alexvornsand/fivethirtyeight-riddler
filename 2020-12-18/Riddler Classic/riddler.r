# https://fivethirtyeight.com/features/can-you-not-flip-your-lid/

library(pbapply)
library(ggplot2)
library(showtext)

gameOfAttrition <- function(n, m){
  turn <- 1
  steps <- 0
  while(n > 0 & m > 0){
    if(turn == 1){
      m <- m - n
      steps <- steps + 1
      turn <- turn * -1
    } else {
      n <- n - m
      steps <- steps + 1
      turn <- turn * -1
    }
  }
  return(which(c(n, m) == max(c(n, m))))
}

findMaxVal <- function(k){
  return(max(which(unlist(sapply(1:(2*k), gameOfAttrition, n = k)) == 1)))
}

buildGraphData <- function(n){
  graphData <- data.frame(
    x = integer(),
    maxVal = integer(),
    against = integer(),
    winner = integer(),
    alphaVal = numeric(),
    fibonacci = numeric()
  )
  m <- 2 * n
  for(i in 1:n){
    maxVal <- findMaxVal(i)
    minInd <- max(1, maxVal - 25)
    maxInd <- maxVal + 25
    k <- maxInd - minInd + 1
    against <- minInd:maxInd
    winner <- unlist(sapply(minInd:maxInd, gameOfAttrition, n = i))
    alphaVal <- 10 / abs(minInd:maxInd - maxVal)
    alphaVal[which(alphaVal == Inf)] <- 10
    fibonacci <- i * ((1 + sqrt(5)) / 2)
    nData <- data.frame(
      x = rep(i, k),
      maxVal = rep(maxVal, k),
      against = against,
      winner = winner,
      alphaVal = alphaVal,
      fibonacci = fibonacci
    )
    graphData <- rbind(graphData, nData)
  }  
  return(graphData)
}

graphData <- buildGraphData(25)

font_add_google(name = 'Montserrat', family = 'Montserrat')
font_add_google(name = 'Merriweather', family = 'Merriweather')
showtext_auto()

ggplot(data = graphData) + 
  geom_point(
    aes(
      x = x,
      y = against,
      alpha = alphaVal,
      color = factor(winner),
      fill = factor(winner)
    )
  ) + 
  geom_line(
    aes(
      x = x,
      y = fibonacci
    ),
    color = '#1a1a1a'
  ) + 
  scale_fill_manual(values = c('1' = '#007acc', '2' = '#686868')) +
  scale_color_manual(values = c('1' = '#007acc', '2' = '#686868')) +
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
    legend.position = 'none'
  ) +
  xlim(0, 25) +
  ylim(0, 50) +
  labs(
    title = 'Game of Attrition',
    x = "Player A's Power Points",
    y = "Player B's Power Points"
  )

ggsave(
  'riddler.png',
  width = 8,
  height = 5,
  units = 'in',
  dpi = 'retina'
)

