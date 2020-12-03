# https://fivethirtyeight.com/features/dont-throw-out-that-calendar/

library(lubridate)

classifyYear <- function(year){
  four <- 1 * (year %% 4 == 0)
  startDay <- wday(ymd(paste(as.character(year), '-1-1', sep = '')))
  return(paste(four, '-', startDay, sep = ''))
}

yearClasses <- unlist(lapply(2000:2140, classifyYear))

yearData <- data.frame(
  year = 2000:2140,
  yearClass = yearClasses
)

identifyNextSameYear <- function(year){
  yearClass <- yearData$yearClass[which(yearData$year == year)]
  nextClass <- yearData$year[which(yearData$year > year & yearData$yearClass == yearClass)]
  if(length(nextClass) > 0){
    return(min(nextClass) - year)
  } else {
    return(NA)
  }
}

calendarGap <- unlist(lapply(2000:2140, identifyNextSameYear))
yearData$calendarGap <- calendarGap

yearData
