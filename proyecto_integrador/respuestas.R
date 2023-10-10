#### Respuestas

# librerias de trabajo
library(dplyr)
library(ggplot2)
library(modeest)

set.seed(456)
attach(covid_mexico)

# 1.
mean(total_cases, na.rm = TRUE)
median(total_cases, na.rm = TRUE)
mfv(total_cases, na_rm = TRUE)

# 2.

var(new_tests, na.rm = TRUE)
sd(new_tests, na.rm = TRUE)

# 3.

quantile(total_tests, na.rm = TRUE)

# 4.












