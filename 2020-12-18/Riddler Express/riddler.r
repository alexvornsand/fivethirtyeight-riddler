# https://fivethirtyeight.com/features/can-you-not-flip-your-lid/

library(ggplot2)
library(gganimate)
library(ggforce)

placeDisk <- function(){
  x <- runif(1, min = -2, max = 2)
  y <- runif(1, min = -2, max = 2)
  if(x ^ 2 + y ^ 2 <= 4){
    if(x ^ 2 + y ^ 2 >= (sqrt(3)) ^ 2){
      return(1)
    } else {
      return(0)
    }
  } else {
    return(NA)
  }
}

mean(replicate(1000000, placeDisk()), na.rm = T)

buildGifData <- function(n){
  diskData <- data.frame(
    period = integer(),
    x = numeric(),
    y = numeric(),
    radius = numeric(),
    state = factor(),
    label = character()
  )
  oldDisks <- data.frame(
    period = integer(),
    x = numeric(),
    y = numeric(),
    radius = numeric(),
    state = factor(),
    label = character()
  )
  time <- 0
  num <- 0
  denom <- 0
  while(time < n){
    x = runif(1, min = -2, max = 2)
    y = runif(1, min = -2, max = 2)
    if(x ^ 2 + y ^ 2 <= 4){
      denom <- denom + 1
      if(x ^ 2 + y ^ 2 >= 3){
        newState <- 3
        newRadius <- .1
        num <- num + 1
      } else {
        newState <- 2
        newRadius <- .1
      }
      bigDisk <- data.frame(
        period = time,
        x = 0,
        y = 0,
        state = 5,
        radius = 2,
        label = NA
      )
      newDisks <- data.frame(
        period = rep(time, 2),
        x = rep(x, 2),
        y = rep(y, 2),
        state = c(newState, 4),
        radius = c(newRadius, 1),
        label = c(paste(num, '/', denom, sep = ''), NA)
      )
      allNewDisks <- rbind(bigDisk, oldDisks, newDisks)
      allNewDisks$period = rep(time, length(allNewDisks$period))
      diskData <- rbind(diskData, allNewDisks)
      newDisks$state[which(newDisks$state == 2)] <- 0
      newDisks$state[which(newDisks$state == 3)] <- 1
      newDisks$label <- NA
      oldDisks <- rbind(oldDisks, newDisks[1,])
      time <- time + 1
    }
  }
  print(num)
  return(diskData)
}

results <- buildGifData(200)

g <- ggplot(
  data = results,
  aes(
    x0 = x,
    y0 = y,
    r = radius,
    fill = factor(state),
    color = factor(state)
  )
) + 
  geom_circle() + 
  geom_text(
    x = 4,
    y = 0,
    aes(label = label),
    color = '#1a1a1a'
  ) +
  scale_fill_manual(values = c('0' = '#686868', '1' = '#007acc', '2' = '#1a1a1a', '3' = '#007acc', '4' = NA, '5' = NA)) +
  scale_color_manual(values = c('0' = '#686868', '1' = '#007acc', '2' = '#1a1a1a', '3' = '#1a1a1a', '4' = '#1a1a1a', '5' = '#1a1a1a')) +
  xlim(-3,5) + 
  ylim(-3,3) +
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
  nframes = length(unique(results$period)),
  end_pause = 25,
  width = 4,
  height = 3,
  units = 'in',
  res = 200
)

anim_save(
  'riddler.gif'
)
