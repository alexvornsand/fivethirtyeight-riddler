# https://fivethirtyeight.com/features/can-you-pass-the-cranberry-sauce/

library(ggplot2)
library(gganimate)

findLastToSauce <- function(k){
  seats <- 0:(k-1)
  wantsSauce <- 1:(k-1)
  hasSauce <- 0
  while(length(wantsSauce) > 1){
    passTo <- sample(c(-1,1), 1)
    hasSauce <- (hasSauce + passTo) %% k
    if(hasSauce %in% wantsSauce){
      wantsSauce <- wantsSauce[wantsSauce != hasSauce]
    }
  }
  return(wantsSauce)
}

findLastToSauceRepeatedly <- function(n, k){
  return(replicate(n, findLastToSauce(k)))
}

buildGifData <- function(k){
  k <- 20
  cranData <- data.frame(
    turn = rep(0, k),
    seat = 0:(k-1),
    cranSauce = c(2, rep(0, (k-1)))
  )
  seats <- 0:(k-1)
  wantsSauce <- 1:(k-1)
  hasSauce <- 0
  period <- 0
  while(length(wantsSauce) > 1){
    passTo <- sample(c(-1,1), 1)
    hasSauce <- (hasSauce + passTo) %% k
    if(hasSauce %in% wantsSauce){
      wantsSauce <- wantsSauce[wantsSauce != hasSauce]
    }
    period <- period + 1
    newState <- data.frame(
      turn = rep(period, k),
      seat = 0:(k-1),
      cranSauce = rep(1, k)
    )
    newState$cranSauce[which(newState$seat == hasSauce)] <- 2
    newState$cranSauce[which(newState$seat %in% wantsSauce)] <- 0
    cranData <- rbind(cranData, newState)
  }
  finalState <- data.frame(
    turn = rep(period + 1, k),
    seat = 0:(k-1),
    cranSauce = rep(1, k)
  )
  finalState$cranSauce[which(finalState$seat == wantsSauce)] <- 2
  cranData <- rbind(cranData, finalState)
  cranData$x <- cos(cranData$seat * 2 * pi / k)
  cranData$y <- sin(cranData$seat * 2 * pi / k)
  cranData$cranSauce <- as.factor(cranData$cranSauce)
  return(cranData)
}

gifData <- buildGifData(20)

g <- ggplot(
  gifData,
  aes(
    x,
    y
  )
) +
  geom_point(
    aes(
      fill = cranSauce,
      group = seq_along(turn)
    ),
    pch = 21,
    size = 10,
    color = "#1a1a1a"
  ) +
  scale_fill_manual(values = c('0' = '#ffffff', '1' = '#686868', '2' = '#007acc')) +
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
  transition_manual(turn)

animate(
  plot = g,
  nframes = length(unique(gifData$turn)),
  duration = 10,
  end_pause = 10
)

anim_save(
  'riddler.gif',
  width = 4,
  units = 'in',
  dpi = 'retina'
)

winners <- findLastToSauceRepeatedly(1000,20)

gifData <- data.frame(
  period = integer(),
  seat = integer(),
  count = integer()
)
period <- 0
for(i in 1:(length(winners) / 10)){
  period <- period + 1
  thisTurn <- data.frame(
    period = rep(period, 20),
    seat = 0:19,
    count = 0
  )
  countsToDate <- table(winners[1:(10 * i)])
  for(j in as.integer(names(countsToDate))){
    thisTurn$count[j + 1] <- countsToDate[as.character(j)] / max(as.vector(countsToDate))
  }
  gifData <- rbind(gifData, thisTurn)
}

gifData$x <- cos(gifData$seat * 2 * pi / 20)
gifData$y <- sin(gifData$seat * 2 * pi / 20)

g <- ggplot(
  gifData,
  aes(
    x,
    y
  )
) +
  geom_point(
    aes(
      alpha = count,
      group = seq_along(period)
    ),
    pch = 21,
    size = 10,
    color = '#1a1a1a',
    fill = '#007acc'
  ) +
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
  duration = 10,
)

anim_save(
  'riddler2.gif',
  width = 4,
  units = 'in',
  dpi = 'retina'
)

