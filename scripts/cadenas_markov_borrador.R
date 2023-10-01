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

str(mc) # lista de ragumentos

summary(mc)

plot(mc)


recurrentClasses(mc) # clases recurrentes

transientStates(mc) # identifica estados transitorios

absorbingStates(mc)  # identifica estados absorbentes


# analisis probabilistico

transitionProbability(object = mc, t0 = 'a', t1 = 'c')
mc[1,3]

# analisis en n pasos

n <- 3
mc ^ n

# distribucion hacia adelante

X0 = c(200,300,500) # La distribucion de X en t = 0
n = 6
Xn = X0*(mc^n)

Xn
sum(Xn)  # siempre 1

# distribucion estacionaria

disteEst <- steadyStates(mc)
disteEst


M <- 1/disteEst
M
