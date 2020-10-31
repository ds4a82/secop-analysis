comprss <- function(tx) { 
  div <- findInterval(as.numeric(gsub("\\,", "", tx)), 
                      c(1, 1e3, 1e6, 1e9, 1e12) )
  # div[is.na(div)] <- 1
  div[div == 0] <- 1
  paste(round(as.numeric(gsub("\\,","",tx))/10^(3*(div-1)), 1), 
        c("COP","mil COP","millones COP","mil millones COP","billones COP")[div])
}
