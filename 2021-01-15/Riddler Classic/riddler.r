# https://fivethirtyeight.com/features/can-you-hunt-for-the-mysterious-numbers/

library(pbapply)

firstRow <- c(677, 767, 776)
secondRow <- c(666, 389, 398, 839, 893, 938, 983, 469, 496, 649, 694, 946, 964)
thirdRow <- c(359, 395, 539, 593, 935, 953)
fourthRow <- c(277, 727, 772)
fifthRow <- c(278, 287, 728, 782, 827, 872, 447, 474, 744)
sixthRow <- c(347, 374, 437, 473, 734, 743, 267, 276, 627, 672, 726, 762)
seventhRow <- c(577, 757, 775)
eighthRow <- c(245, 254, 425, 452, 524, 542, 158, 185, 518, 581, 815, 851)

allCombos <- do.call(expand.grid, list(firstRow, secondRow, thirdRow, fourthRow,
                                       fifthRow, sixthRow, seventhRow, eighthRow))

evaluateCombo <- function(row){
  firstCol <- prod(floor(row / 100))
  secondCol <- prod(floor((row - 100 * floor(row / 100)) / 10))
  thirdCol <- prod(row - 100 * floor(row / 100) -  10 * floor((row - 100 * floor(row / 100)) / 10))
  return(firstCol == 8890560 & secondCol == 156800 & thirdCol == 55566)
}

print(allCombos[which(pbapply(allCombos, 1, evaluateCombo)),])
