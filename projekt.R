library(tidyverse)
data <- read.csv2("DaneGUS.csv")
summary(data)

for(i in 3:ncol(data)) {
  data[, i] <- gsub("\\s+", "", data[, i])
  data[, i] <- gsub(",", ".", data[, i])
  data[, i] <- as.numeric(data[, i])
}

dane_numeryczne <- data[, 3:ncol(data)]

hist(data$Cenam2, 
     main = "Histogram zmiennej Cenam2", 
     xlab = "Cena za m2 [zł]", 
     ylab = "Częstość",
     col = "lightblue")

boxplot(data$Cenam2, 
        main = "Wykres pudełkowy dla zmiennej Cenam2",
        ylab = "Cena za m2 [zł]")

macierz_korelacji <- cor(dane_numeryczne)

library(corrplot)
corrplot(macierz_korelacji, 
         method = "number", 
         type = "upper", 
         tl.col = "black",
         tl.cex = 0.8,
         title = "Macierz korelacji zmiennych",
         mar = c(0,0,2,0))

set.seed(123)
train <- data %>% slice_sample(prop = 0.7)
test <- data %>% anti_join(train, by = "Kod")

model <- lm(Cenam2 ~ Bezrobocie + Wynagrodzenia + Ludnosckm2 + Firmy1000os, data = train)
summary(model)