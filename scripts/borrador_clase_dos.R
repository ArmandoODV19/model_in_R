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
