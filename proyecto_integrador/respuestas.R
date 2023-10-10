#### Respuestas

# librerias de trabajo
library(dplyr)
library(ggplot2)

set.seed(456)
attach(covid_mexico)

# 1.
mean(total_cases, na.rm = TRUE)
median(total_cases, na.rm = TRUE)
