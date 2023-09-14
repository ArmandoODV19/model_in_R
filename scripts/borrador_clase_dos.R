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

loudness_pop <- spotify_population$loudness
loudness_samp <- sample(loudness_pop, size = 100) # ejemplo
