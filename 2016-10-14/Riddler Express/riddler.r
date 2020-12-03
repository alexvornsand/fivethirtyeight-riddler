# https://fivethirtyeight.com/features/can-you-survive-this-deadly-board-game/

library(ggplot2)
library(gganimate)

coins <- rep(1, 100)

for(i in 1:100){
  coins[which(1:100 %% i == 0)] <- coins[which(1:100 %% i == 0)] * -1
}

which(coins == -1)

gifData <- data.frame(
  period = rep(0, 100),
  coin = 1:100,
  heads = rep(1, 100)
)

state <- rep(1, 100)
period <- 0
for(i in 1:100){
  period <- period + 1
  state[which(1:100 %% i == 0)] <- state[which(1:100 %% i == 0)] * -1
  turnData <- data.frame(
    period = rep(period, 100),
    coin = 1:100,
    heads = state
  )
  gifData <- rbind(gifData, turnData)
}

gifData$y <- floor((gifData$coin - 1) / 25)
gifData$x <- (gifData$coin - (gifData$y * 25))
gifData$y <- floor((gifData$coin - 1) / 25) / 4
gifData$heads <- as.factor(gifData$heads)

g <- ggplot(
  gifData,
  aes(
    x,
    y
  )
) +
  geom_point(
    aes(
      fill = heads,
      group = seq_along(period)
    ),
    pch = 21,
    size = 10,
    color = "#1a1a1a"
  ) +
  scale_fill_manual(values = c('1' = '#007acc', '-1' = '#686868')) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = 'none'
  ) +
  transition_manual(period)

animate(
  plot = g,
  nframes = length(unique(gifData$period)),
  duration = 10,
  start_pause = 10,
  end_pause = 10
)

anim_save(
  'riddler.gif',
  width = 4,
  units = 'in',
  dpi = 'retina'
)
