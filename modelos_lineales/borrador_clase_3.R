## borrador clase 3
# modelo lineal generalizado
# extraccion de coeficientes
# prediccion con modelos lineales generalizados
# regresion logistica
# regresion multiple
# regresion de poisson


# formula y = b0 + b1X + E
# en R se utiliza la función lm() para graficar modelos lineales
# lm(y~x, data = df) y is predicted by x
# solo examina modelos lineales
# asume que los residuales se distribuyen de manera normal
# funcionan mejor con datos continuos
# limitantes: count data y datos binarios

library(datasets)
View(ChickWeight)

attach(ChickWeight)
lm(formula = weight~Diet, data = ChickWeight)


# glm
# funciones no lineales
# se utiliza la funcion glm()
# glm( y~x, data=df, family='gaussian') similar a lm()


### poisson

# lamba para media y varianza
# modelar el numero de goles en un partido o en una temporada

# se calcula con la funcion dpois()
# dpois(x = ..., lambda = ...)
# conteo discreto
# definior area y tiempo
# los coeficientes en este modelo estan en escala logaritmica
# no se usa con valores negativos o decimales

# usando glm()
# glm( y~x, data=df, family='poisson')



## estrayendo i9nfo de modelo
print(lm(formula = weight~Diet, data = ChickWeight))

summary(lm(formula = weight~Diet, data = ChickWeight))

library(broom)
tidy(lm(formula = weight~Diet, data = ChickWeight))

# extraccion de coeficientes
coef(lm(formula = weight~Diet, data = ChickWeight))

# intervalos de confianza
confint(lm(formula = weight~Diet, data = ChickWeight))

# prediccion
library(dplyr)
new <- ChickWeight %>%
  select(weight, Diet) %>%
  slice_sample(prop = 0.2)

new2 <- data.frame(weight = c(55, 70, 84),
                   Diet = as.factor(c(1, 2, 3)))

predict(lm(formula = weight~Diet, data = ChickWeight), new)
predict(lm(formula = weight~Diet, data = ChickWeight), new2,
        type = 'response')


### regresion logistica

# datos binominales


# logit(p) = B0 + B1X + E

# se usa la funcion glm(), solo se agrega el argumento
# family = 'binomial'
# glm(y~x, data = dat, family = 'binomial')

# para informacion del modelo tambien se utliza
# print(), summary(), tidy()

### graficando modelos

# poisson
# poisson_out <- glm(x~y, family = 'poisson')
# tidy(poisson_out, exponentiate = TRUE)

library(ggplot2)

ggplot(data = dat, aes(x = dose, y = cells)) +
  geom_jitter(width = 0.05, height = 0.05) +
  geom_smooth(method = 'glm', method.args = list(family = 'poisson'))



# regresion logistica

# extraccion de intervalos de confianza
glm_out <- glm(y~x, family = 'binomial')
tidy(glm_out, exponentiate = TRUE, conf.int = TRUE)


# multiple logistic regression
glm(formula = Bus~CommuteDays + MilesOneWay,
    family = 'binomial', data = bus)

# correlacion entre variables
cor()


#### borrador clase

# librerias de trabajo

library(readr)
library(dplyr)
library(corrplot)
library(ggplot2)
library(scales)
library(ggpubr)
library(broom)

# cargando data

vacunas_df <- read_csv('data/dataset_vacunas.csv')

# generando variable sunicas de colnames

attach(vacunas_df)

# generando modelo lineal

gdp_vs_life <- lm(Life_expectancy~GDP, data = vacunas_df)

# extrayendo info de modelo
summary(gdp_vs_life)
confint(gdp_vs_life)
tidy(gdp_vs_life)

# graficando modelo

ggplot(vacunas_df, aes(x = GDP, y = Life_expectancy)) +
  geom_point()+
  geom_smooth(method = 'glm')+
  xlab('Producto Interno Bruto')+
  ylab('Esperanza de vida')+
  theme_bw()

# tuneando gráfico


ggplot(vacunas_df, aes(x = GDP, y = Life_expectancy)) +
  geom_point(size = 7, color = 'dodgerblue', alpha = 0.7)+
  geom_smooth(method = 'glm', color = 'azure4')+
  xlab('Producto Interno Bruto')+
  ylab('Esperanza de vida')+
  theme_bw()

# visualizando distribución de los datos de gdp

ggplot(vacunas_df, aes(GDP)) +
  geom_histogram()

# transformando los datos

ggplot(vacunas_df, aes(log(GDP)))+
  geom_histogram()

# utilizando transformacion logaritmica


gdp_vs_life_log <- lm(Life_expectancy~log(GDP), data = vacunas_df)

# extrayendo info de modelo
summary(gdp_vs_life_log)
confint(gdp_vs_life_log)
tidy(gdp_vs_life_log)

# comparando modelos
tidy(gdp_vs_life)
tidy(gdp_vs_life_log)


# graficando

ggplot(vacunas_df, aes(x = log(GDP), y = Life_expectancy)) +
  geom_point(size = 7, color = 'dodgerblue', alpha = 0.7)+
  geom_smooth(method = 'glm', color = 'azure4')+
  xlab('Producto Interno Bruto')+
  ylab('Esperanza de vida')+
  theme_bw()

### regresion multiple

# explica la relacion de la variable y con varias
# variables explicativas
# de la misma manera se utiliza la funcion lm()
# se agregan las variables con el signo de +
# modelo de esperanza de vida vs gdp + bcg + Pol3

life_vs_bcg_gdp_pol <- lm(formula = Life_expectancy~GDP+BCG+Pol3,
                          data = vacunas_df)

# extraccion de info
summary(life_vs_bcg_gdp_pol)
confint(life_vs_bcg_gdp_pol)
tidy(life_vs_bcg_gdp_pol)

# esperanza de vida contra todo el dataset
# se agrega ~.
# quitando entidad y codigo

data_vacunas_2 <- vacunas_df %>%
  select(-Entity, -Code)

modelo_multivariable <- lm(formula=Life_expectancy~.,
                           data = data_vacunas_2)

summary(modelo_multivariable)
confint(modelo_multivariable)
tidy(modelo_multivariable)

# correlacion multiple metodo de person
# tambien puede realizarse kendall o spearman

# person

correlaciones <- cor(data_vacunas_2)

corrplot(correlaciones, method = 'circle', tl.col = 'black')

# kendall

correlaciones_kendall <- cor(data_vacunas_2, method = 'kendall')

corrplot(correlaciones_kendall, method = 'circle', tl.col = 'black')


# spearman

correlaciones_spearman <- cor(data_vacunas_2, method = 'spearman')

corrplot(correlaciones_spearman, method = 'circle', tl.col = 'black')



### regresion logisitca

# llamando dataset

cancer_df <- readRDS('data/cancer_data.RDS')

summary(cancer_df)

# datos binominales


# logit(p) = B0 + B1X + E

# se usa la funcion glm(), solo se agrega el argumento
# family = 'binomial'
# glm(y~x, data = dat, family = 'binomial')

# para informacion del modelo tambien se utliza
# print(), summary(), tidy()


attach(cancer_df)

# dx_cancer vs stds_condylomatosis

cancer_model <- glm(dx_cancer~stds_condylomatosis, data = cancer_df,
    family = 'binomial')

print(cancer_model)
summary(cancer_model)
tidy(cancer_model)

# dx_cancer vs stds_hepatitis + dx_hpv

cancer_model_2variables <- glm(dx_cancer~stds_hepatitis_b+dx_hpv,
                               data = cancer_df, family = 'binomial')


print(cancer_model_2variables)
summary(cancer_model_2variables)
tidy(cancer_model_2variables)

# dx_cancer vs todas las variables binomiales

cancer_df_binomial <- cancer_df %>%
  select(-age, -number_of_sexual_partners, -smokes_years)

cancer_multiva <- glm(dx_cancer~., data = cancer_df_binomial,
                      family = 'binomial')

print(cancer_multiva)
summary(cancer_multiva)
tidy(cancer_multiva)


### prediccion

gdp_vs_life <- lm(Life_expectancy~GDP, data = vacunas_df)

# creando la formula

funcion_esperanza <- function(x){
  gdp = 0.000248
  intercept = 67.6
  resultado = intercept + gdp*x
  return(resultado)
}

funcion_esperanza(12531)

# con funcion predict()

nueva_esperanza <- data.frame(esperanza = c(12531))

head(predict(gdp_vs_life, nueva_esperanza, type = 'response'),1)

# mas variables

nueva_esperanza_2 <- data.frame(esperanza = c(12531, 11787, 7159))

head(predict(gdp_vs_life, nueva_esperanza_2, type = 'response'),3)


