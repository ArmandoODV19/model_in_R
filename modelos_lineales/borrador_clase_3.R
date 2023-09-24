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






