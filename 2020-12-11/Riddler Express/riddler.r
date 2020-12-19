# https://fivethirtyeight.com/features/how-high-can-you-count-with-menorah-math/

number2binary = function(number, noBits) {
  binary_vector = rev(as.numeric(intToBits(number)))
  if(missing(noBits)) {
    return(binary_vector)
  } else {
    binary_vector[-(1:(length(binary_vector) - noBits))]
  }
}

strings <- c('\\one', '\\two', '\\three', '\\four', '\\five', '\\six', '\\seven', '\\eight')
gstrings <- c('\\gone', '\\gtwo', '\\gthree', '\\gfour', '\\gfive', '\\gsix', '\\gseven', '\\geight')

outputString <- ''
binaries <- list()
t <- 0

processBinary <- function(n){
  binary <- number2binary(n, 8)
  binInList <- Position(function(x) identical(x, binary), binaries, nomatch = 0) > 0
  revBinInList <- Position(function(x) identical(x, rev(binary)), binaries, nomatch = 0) > 0
  if(binInList | revBinInList){
    newString <- paste(
      '\\begin{tikzpicture}[scale = 0.75]\n\t\\gmenorah{}\n\t',
      paste(unlist(sapply(which(binary == 1), function(x) gstrings[x])), collapse = ''),
      '\n\\end{tikzpicture}\n',
      sep = ''
    )
    binaries[[n + 1]] <<- binary
    outputString <<- paste(outputString, newString, sep = '')
  } else {
    newString <- paste(
      '\\begin{tikzpicture}[scale = 0.75]\n\t\\menorah{',
      t,
      '}\n\t',
      paste(unlist(sapply(which(binary == 1), function(x) strings[x])), collapse = ''),
      '\n\\end{tikzpicture}\n',
      sep = ''
    )
    binaries[[n + 1]] <<- binary
    t <<- t + 1
    outputString <<- paste(outputString, newString, sep = '')
  }
}

for(i in 0:255){
  processBinary(i)
}

fileConn<-file('~/Documents/Github/fivethirtyeight-riddler/2020-12-11/Riddler Express/riddler2.tex')
writeLines(outputString, fileConn)
close(fileConn)
