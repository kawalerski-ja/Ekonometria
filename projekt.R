library(tidyverse)
data<-read.csv2("DaneGUS.csv")
summary(data)
# Dane są typu char
for(i in 3:ncol(data)) {
  
  # Usuwanie spacji
  data[, i] <- gsub("\\s+", "", data[, i])
  
  # Zamiana przecinków na kropki
  data[, i] <- gsub(",", ".", data[, i])
  
  # Wymuszenie konwersji na liczbę
  data[, i] <- as.numeric(data[, i])
}

str(data)
