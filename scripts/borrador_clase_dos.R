### borrador clase 2

# cuando la poblacion es grande como en los países se prefiere realizar uncenso
# esto debido a lo qcono9mico y eficaz
# la información recabada se puede generalizar
# toma de una muestra de la poblacion
# poblacion, todo el dataset
# muestra es un csubconjunto de datos

# un parametro de población es un calculo realizado en un conjunto de datos
# de una poblacion

# una muestra estadística se calcula a partir de la muestra

# para las muestras se utiliza la funcion slice_sample() y sample() para vectores
?sample
# toma una muestra de un determinado tamaño de los elementos de x con
# y sin reemplazo

# sample pertenece a base. Vcetores
# slice_sample pertenece a dplyr. flujos de trabajo y df
?slice_sample


spotify_sample <- spotify_population %>% slice_sample(n = 1000) # ejemplo

####

# the literacy digest landon roosevelt

# el muesttreo por conveniencia puede generar sesgos y resultados imparciales

# no se recomienda usar head o slice_head() por no ser aleatorios



loudness_pop <- spotify_population$loudness
loudness_samp <- sample(loudness_pop, size = 100) # ejemplo


###

# set seed para repetir resultados

set.seed(123) # para generar datos reproducibles

rnorm(5) # sin set.seed genera numeros nuevos al azar


## boostrapping

# resampling sampling with replacement

# se agrega replace = TRUE
spotify_sample <- spotify_population %>% slice_sample(prop = 1, replace = TRUE)
# porp = 1 como argumento genera una muestra del mismo tamaño del dataset original


# diferencias

# sampling: de la poblacion a una muestra
# bootstrapping: crear una poblacion teorica de la muestra


# Replicate this 1000 times
mean_danceability_1000 <- replicate(
  n = 1000,
  expr = {
    spotify_1_resample <- spotify_sample %>%
      slice_sample(prop = 1, replace = TRUE)
    spotify_1_resample %>%
      summarize(mean_danceability = mean(danceability)) %>%
      pull(mean_danceability)
  }
)

# See the result
mean_danceability_1000


### DISTRIBUCION


# distribucion probabilistica

# la probabilidad de que un evento ocurra debe ser igual a 1.
# la suma de las posibilidades deben ser igual a 1

# en la distribución uniforme todos los eventos tienen la misma
# posibilidad de suceder

dice <- data.frame(n = c(1,2,3,4,5,6),
                   prop = c(1/6,1/6,1/6,1/6,1/6,1/6))
dice

library(ggplot2)
ggplot(dice, aes(x = n, y = prop)) +
  geom_col() +
  ylim(0,1)


library(dplyr)
dado_5 <- dice %>%
  sample_n(5, replace = TRUE)

ggplot(dado_5, aes(x = n)) +
  geom_histogram()

library(dplyr)
dado_10 <- dice %>%
  sample_n(10, replace = TRUE)

ggplot(dado_10, aes(x = n)) +
  geom_histogram()

dado_100 <- dice %>%
  sample_n(100, replace = TRUE)

ggplot(dado_100, aes(x = n)) +
  geom_histogram()


dado_1000 <- dice %>%
  sample_n(1000, replace = TRUE)

ggplot(dado_1000, aes(x = n)) +
  geom_histogram()


dado_100000 <- dice %>%
  sample_n(100000, replace = TRUE)

ggplot(dado_100000, aes(x = n)) +
  geom_histogram()


# distribucion uniforme en R
# con esta funcion se puede realizar en discretos y continuos

# probabilidad de menos de 5
punif(5, min = 0, max = 6)

# probabilidad de mas de 5
punif(5, min = 0, max = 6, lower.tail = FALSE)

# proabilidad de obtener entre 4 < p < 5
punif(5, min = 0, max = 6) - punif(4, min = 0, max = 6)


# proabilidad de obtener entre 3 < p < 5
punif(5, min = 0, max = 6) - punif(3, min = 0, max = 6)

# probabilidad de obtener menor de 6
punif(6, min = 0, max = 6)



# distribucion normal
# es simetrica, la probabilidad nunca es igual a 0
# la probabilidad siempre es 1
# se basa en la media y la desviacion estandar

# no todo sigue una distribucion uniforme

# 68% de la poblacion se encuentra en la primera desviacion estandar
# 95% en dos de, 99.7 en 3 de

# para esto se utiliza la funcion pnorm()
# ejemplo cuantas personas miden menos de 154 cm
# se necesita conocer el promedio y la desviacion estandar

pnorm(154, mean = 161, sd = 7)

# mayor a 154
pnorm(154, mean = 161, sd=7, lower.tail = FALSE)

# rangos. Entre 154 y 157
pnorm(157, mean = 161, sd = 7) - pnorm(154, mean  = 161, sd = 7)


# tambien se pueden calcular porcentajes utilizando la funcion qnorm()

# que estatura mas corta tiene el 90% de la poblacion

qnorm(0.9, mean = 161, sd = 7)

# estatura mas alta al 90% de la poblacion

qnorm(0.9, mean = 161, sd = 7, lower.tail = FALSE)


# 10 numeros al azar siguiendo la distribucion normal

rnorm(10, mean = 161, sd = 7)


## teorema del limite central
# la distribución de la muestra se acerca a la distribucion
# normal en cuanto aumentan el numero de experimentos
# esto solo aplica cuando las muestras se toman al
# de manera independiente

library(dplyr)
library(ggplot2)

dado <- seq(1,6,1)

replicate(10, sample(dado, 5, replace = TRUE) %>%
                     mean()) %>% as.data.frame() %>%
  ggplot(aes(x = .)) + geom_histogram()


replicate(100, sample(dado, 5, replace = TRUE) %>%
            mean()) %>% as.data.frame() %>%
  ggplot(aes(x = .)) + geom_histogram()

replicate(1000, sample(dado, 5, replace = TRUE) %>%
            mean()) %>% as.data.frame() %>%
  ggplot(aes(x = .)) + geom_histogram()

replicate(1000, sample(dado, 5, replace = TRUE) %>%
            mean()) %>% as.data.frame() %>%
  ggplot(aes(x = .)) + geom_histogram()


### la distribucion binominal

# dos posbiles resultados
# 1 y 0, exito y fracaso, ganar y perder


# en R es posible hacer esto con la funcion
# rbinom(numero_observaciones, numero_ensayos, exito)

rbinom(2, 1, 0.5)

# si se cambia el segundo argumento, indica
# el numero de exitos

set.seed(123)
rbinom(2, 3, 0.5) # se hicieron dos ensayos.
# en cada una se lanzaron 3 monedas. hubo un exito
# en la primera y dos exitos en la segunda


# 10 experimentos. 3 ensayos por experimento
rbinom(10, 3, 0.5)

# modificando probabilidad de exito al 25%

rbinom(1, 1, 0.25)

# para obtener la probabilidad de obtener
# n exitos se utiliza la funcion
# dbinom()
# ejemplo, obtener 7 exitos en 10 experimentos

dbinom(7, 10, 0.5)


# pbinom() genera la probabilidad de encontrar n o
# menos exitos
# ejemplo, probabilidad de obtener igual o menos de 7 exitos
# en 10 experimentos

pbinom(7, 10, 0.5)

# con el argumento lower.tail = se obtiene la proabbilidad
# de tener mas de n exitos
# ejemplo, obtener mas de 7 exitos en 10 experimentos

pbinom(7, 10, 0.5, lower.tail = FALSE)


# siempre 1
pbinom(7, 10, 0.5) + pbinom(7, 10, 0.5, lower.tail = FALSE)


##### ejemplos de clase previa
library(dplyr)


summary(iris)
glimpse(iris)


df=data.frame(id=c(2,1,3,4,NA),
              name=c('sravan',NA,'chrisa','shivgami',NA),
              gender=c(NA,'m',NA,'f',NA))

summary(df)
glimpse(df)
which(is.na(df))
sum(is.na(df))
which(is.na(df$gender))


# conociendo datos y NA

# generamos df ficticion

dummy_data <- data.frame(id=c(2,1,3,4,NA),
              horas_estudio=c(2, 5, 4, 2, 1),
              horas_recre=c(4, 2, 4, 3, 1),
              edad = c(20, 15, 16, 22, 20))

# contar y detectar NA de dataset

sum(is.na(dummy_data))
summary(dummy_data)
which(is.na(dummy_data$id))
which(is.na(dummy_data$nombre))
which(is.na(dummy_data$sexo))

# mas rapido
na_count <- sapply(dummy_data, function(y) sum(length(which(is.na(y)))))
na_count

# eliminando NA con na.omit()

na.omit(dummy_data)

# hay que tener cuidado

dummy_data_2 <- data.frame(id=c(2,1,3,4,NA),
                           horas_estudio=c(NA, 5, 4, 2, 1),
                           horas_recre=c(4, NA, 4, 3, 1),
                           edad = c(20, 15, NA, 22, NA))

na.omit(dummy_data_2)

na_count <- sapply(dummy_data_2, function(y) sum(length(which(is.na(y)))))
na_count


# RECODE por 0 en todo el df
dummy_data_2[is.na(dummy_data_2)] = 0
dummy_data_2

# recode por columna

dummy_data_3 <- data.frame(id=c(2,1,3,4,NA,6,7,8,9,10,11,12),
                           horas_estudio=c(NA,5,4,2,1,3,NA,2,4,3,5,NA),
                           horas_recre=c(9,NA,8,3,NA,8,5,6,8,NA,4,7),
                           edad = c(20,15,NA,22,NA,17,18,NA,18,20,18,15))

summary(dummy_data_3)
# recode horas de estudio
mean(dummy_data_3$horas_estudio, na.rm = TRUE)
dummy_data_3$horas_estudio[is.na(dummy_data_3$horas_estudio)]=3.2
dummy_data_3

# recode horas recreativas
mean(dummy_data_3$horas_recre, na.rm = TRUE)
dummy_data_3$horas_recre[is.na(dummy_data_3$horas_recre)] = 6.4
dummy_data_3

# recode edad
mean(dummy_data_3$edad, na.rm = TRUE)
dummy_data_3$edad[is.na(dummy_data_3$edad)] = 18
dummy_data_3

### identificar cuartiles

# identificando puntos de corte

quantile(iris$Sepal.Length)

identificando_cuartiles <- function(x){
  if(x <= 5.1) print('debajo Q1')
  if(x > 5.1 & x <= 5.8) print('entre Q1 y Q2')
  if(x >5.8 & x <= 6.4) print('entre Q2 y Q3')
  if(x > 6.4) print('superior a Q3')
}

identificando_cuartiles(6.5)

# usando case_when()

iris_df <- iris

quantile(iris_df$Sepal.Length)

iris_df_cuartil <- iris_df %>%
  mutate(cuartil = case_when(Sepal.Length <= 5.1 ~ '< Q1',
                             Sepal.Length > 5.1 & Sepal.Length <= 5.8 ~ 'Q1 & Q2',
                             Sepal.Length > 5.8 & Sepal.Length <= 6.4 ~ 'Q1 & Q3',
                             Sepal.Length > 6.4 ~ '> Q3'))

iris_nueva <- c(5.222,NA,NA,NA,NA)

new_iris <- rbind(iris_nueva, iris_df)

head(new_iris %>%
       mutate(cuartil = case_when(Sepal.Length <= 5.1 ~ '< Q1',
                                             Sepal.Length > 5.1 & Sepal.Length <= 5.8 ~ 'Q1 & Q2',
                                             Sepal.Length > 5.8 & Sepal.Length <= 6.4 ~ 'Q1 & Q3',
                                             Sepal.Length > 6.4 ~ '> Q3')),1)
