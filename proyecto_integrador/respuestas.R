#### Respuestas

# librerias de trabajo
library(dplyr)
library(ggplot2)
library(modeest)
library(moments)

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

# debajo del primer cuartil

# 5.

max(covid_mexico$date) # 2 de agosto 2023


# 6.

ggplot(covid_mexico, aes(total_tests)) +
  geom_histogram()

skewness(total_tests, na.rm = TRUE)

# mediana

# 7.

covid_recode <- covid_mexico
median(covid_recode$total_tests, na.rm = TRUE) # recode con 5759946
summary(covid_recode$total_tests) # 410 NA
covid_recode$total_tests[is.na(covid_recode$total_tests)] = 5759946
summary(covid_recode$total_tests) # 0 Na

covid_recode_50 <- slice_sample(covid_recode, n = 50)
covid_recode_200 <- slice_sample(covid_recode, n = 200)
covid_recode_500 <- slice_sample(covid_recode, n = 500)

mean(covid_recode$total_tests);median(covid_recode$total_tests);mfv(covid_recode$total_tests)
# 6176155; 5759946; 5759946
mean(covid_recode_50$total_tests);median(covid_recode_50$total_tests);mfv(covid_recode_50$total_tests)
# 6399293; 5759946; 5759946
mean(covid_recode_200$total_tests);median(covid_recode_200$total_tests);mfv(covid_recode_200$total_tests)
# 6333803; 5759946; 5759946
mean(covid_recode_500$total_tests);median(covid_recode_500$total_tests);mfv(covid_recode_500$total_tests)
# 6315729; 5759946; 5759946

# 8. total_cases total_deaths
mean(covid_recode$total_cases, na.rm = T);median(covid_recode$total_cases, na.rm = T)
ggplot(covid_recode, aes(total_cases))+
  geom_histogram()
mean(covid_recode$total_deaths, na.rm = T);median(covid_recode$total_deaths, na.rm = T)
ggplot(covid_recode, aes(total_deaths))+
  geom_histogram()


covid_recode$total_cases[is.na(covid_recode$total_cases)]=3882764
covid_recode$total_deaths[is.na(covid_recode$total_deaths)]=299378

skewness(covid_recode$total_cases)
skewness(covid_recode$total_deaths)

cases_vs_deaths <-  lm(formula=total_deaths~total_cases,
                       data = covid_recode)
summary(cases_vs_deaths)
cases_vs_deaths$coefficients
confint(cases_vs_deaths)

# 9.

ggplot(covid_recode, aes(x = total_cases, total_deaths)) +
  geom_point(color = 'forestgreen')+
  geom_smooth(method = 'glm', color = 'salmon') +
  xlab('Casos Totales')+
  ylab('Muertes Totales') +
  theme_bw()






