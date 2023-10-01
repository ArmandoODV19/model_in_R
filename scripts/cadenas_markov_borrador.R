# instalando paquetería

install.packages('markovchain')

# llamando libreria

library(markovchain)

# creando matriz de transicion

P = matrix(c(0.2,0.3,0.5,0.4,0.2,0.4,0.1,0.6,0.3),
           nrow = 3,byrow = TRUE)
P

# creando la matriz

mc <- new('markovchain', transitionMatrix = P,
          states = c('a', 'b', 'c'), name = 'Cadena1')

str(mc)
