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

library(datasets)
View(ChickWeight)

attach(ChickWeight)
lm(formula = weight~Diet, data = ChickWeight)


# glm
# funciones no lineales
# se utiliza la funcion glm()
# glm( y~x, data=df, family='gaussian')

