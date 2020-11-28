# https://fivethirtyeight.com/features/rig-the-election-with-math/

library(pbapply)

words <- read.table('words.txt')$V1
words <- words[order(nchar(words), words, decreasing = T)]

checkIfScrabbleWord <- function(word){
  if(nchar(word) == 2){
    if(word %in% words){
      return(T)
    } else {
      return(F)
    }
  } else {
    if(word %in% words){
      frontWord <- checkIfScrabbleWord(substring(word, 1, nchar(word) - 1))
      backWord <- checkIfScrabbleWord(substring(word, 2, nchar(word)))
      if(frontWord | backWord){
        return(T)
      } else {
        return(F)
      }
    } else {
      return(F)
    }
  }
}

scrabbleWords <- pblapply(words, checkIfScrabbleWord)
