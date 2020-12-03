# https://fivethirtyeight.com/features/can-you-pass-the-cranberry-sauce/

library(lubridate)

classifyYear <- function(year){
  fourHundred <- year %% 400
  oneHundred <- year %% 100
  four <- year %% 4
  startDay <- wday(ymd(paste(as.character(year), '-1-1', sep = '')))
  return(paste(fourHundred, '-', oneHundred, '-', four, '-', startDay, sep = ''))
}

classifiedYears <- unlist(lapply(1994:5217, classifyYear))

identifyLoopPoint <- function(seq){
  init <- seq[1]
  i <- 2
  while(init != seq[i]){
    i <- i + 1
  }
  return(i)
}

identifyLoopPoint(classifiedYears)

findF13sInNextCalYears <- function(year){
  startDate <- ymd(paste(year, '-1-1', sep = ''))
  endDate <- ymd(paste(year + 3, '-12-31', sep = ''))
  dateRange <- seq(startDate, endDate, 1)
  return(length(dateRange[day(dateRange) == 13 & wday(dateRange, label = T) == 'Fri']))
}

findMostF13sInCalYears <- function(year){
  yearWithMostF13 <- c(2020,0)
  for(y in year:(year + 400)){
    f13s <- findF13sInNextCalYears(y)
    if(f13s >= yearWithMostF13[2]){
      yearWithMostF13[1] <- y
      yearWithMostF13[2] <- f13s
    }
  }
  return(c(as.character(yearWithMostF13[1]), as.character(yearWithMostF13[2])))
}

findMostF13sInCalYears(2020)

findF13sInNextYears <- function(date){
  startDate <- date
  if(month(startDate) == 2 & day(startDate) == 29){
    endDate <- startDate - days(1) + years(4)
  } else {
    endDate <- startDate + years(4) - days(1)
  }
  dateRange <- seq(startDate, endDate, by = 1)
  return(length(dateRange[day(dateRange) == 13 & wday(dateRange, label = T) == 'Fri']))
}

findMostF13sInYears <- function(day){
  startDate <- ymd(day)
  endDate <- startDate + years(400)
  currentDate <- startDate
  dateWithMostF13s <- currentDate
  mostF13s <- 0
  while(currentDate <= endDate){
    f13s <- findF13sInNextYears(currentDate)
    if(f13s >= mostF13s){
      dateWithMostF13s <- currentDate
      mostF13s <- f13s
    }
    currentDate <- currentDate + days(1)
  }
  return(c(as.character(dateWithMostF13s), as.character(mostF13s)))
}

findMostF13sInYears('2020-11-20')
