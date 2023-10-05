# librerias de trabajo
library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)

# llamando dataset
covid_mexico <- readRDS('data/covid_mexico.RDS')

min(covid_mexico$date)
max(covid_mexico$date)
summary(covid_mexico$date)
length(covid_mexico$date)
1310/365  #3.5 años
deltat(covid_mexico$date) # intervalo de fechas

diferencia_casos <- diff(covid_mexico$total_cases) %>%
  na.omit()

head(diferencia_casos,20)


ggplot(covid_mexico, aes(x = date, y = total_cases)) +
  geom_line()

# con linea de tendencia

ggplot(covid_mexico, aes(x = date, y = total_cases)) +
  geom_line() +
  geom_smooth()


# tuneando el grafico

ggplot(covid_mexico, aes(x = date, y = total_cases)) +
  geom_line() +
  geom_smooth() +
  xlab('Fecha') +
  ylab('Casos Totales') +
  theme_bw()

# scale_x_date() para darle formato a la fecha

# %d: Day as a number between 0 and 31
# %a: Abbreviated weekday (e.g. “Tue”)
# %A: Unabbreviated weekday (e.g. “Tuesday”)
# %m: Month between 0 and 12
# %b: Abbreviated month (e.g. “Jan”)
# %B: Unabbreviated month (e.g. “January”)
# %y: 2-digit year (e.g. “21”)
# %Y: 4-digit year (e.g. “2021”)
# %W: Week of the year between 0 and 52


ggplot(covid_mexico, aes(x = date, y = total_cases)) +
  geom_line() +
  geom_smooth() +
  xlab('Fecha') +
  ylab('Casos Totales') +
  scale_x_date(date_labels = '%b %Y') +
  theme_bw()


# realizando cortes a la fecha
# scale_x_date(date_breaks = "4 week")
# por cuatrimestre

ggplot(covid_mexico, aes(x = date, y = total_cases)) +
  geom_line() +
  geom_smooth() +
  xlab('Fecha') +
  ylab('Casos Totales') +
  scale_x_date(date_labels = '%b %Y',
               date_breaks = '4 month') +
  theme_bw()

# filtrando entre fechas
min(covid_mexico$date)
max(covid_mexico$date)

covid_mexico %>%
  filter(date >= '2021-01-01',
         date <= '2021-12-31')

# graficando intervalo

covid_mexico %>%
  filter(date >= '2021-01-01',
         date <= '2021-12-31') %>%
  ggplot(aes(x = date, y = total_cases)) +
  geom_line() +
  scale_x_date(date_breaks = '1 month') +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5, hjust=1))+
  xlab('Fecha') +
  ylab('Casos Totales')


a <- covid_mexico %>%
  filter(date >= '2021-01-01',
         date <= '2021-12-31') %>%
  select(total_cases, date) %>%
  ggplot(aes(y = total_cases, x = date)) +
  geom_line() +
  geom_smooth()

b <- covid_mexico %>%
  filter(date >= '2021-01-01',
         date <= '2021-12-31') %>%
  select(total_deaths, date) %>%
  ggplot(aes(y = total_deaths, x = date)) +
  geom_line() +
  geom_smooth()

c <- covid_mexico %>%
  filter(date >= '2021-01-01',
         date <= '2021-12-31') %>%
  select(total_tests, date) %>%
  ggplot(aes(y = total_tests, x = date)) +
  geom_line() +
  geom_smooth()


ggarrange(a, b, c,
          labels = c('CASOS', 'MUERTES', 'PRUEBAS'),
          ncol = 3, nrow = 1,
          font.label = list(size = 10),
          hjust = 0, vjust = 2.2)







