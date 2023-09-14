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





