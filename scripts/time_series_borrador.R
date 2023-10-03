### time series borrador

# secuencia de datos en orden cronológico
# ordenado de manera secuencial

# para graficar una serie de tiempo se utiliza
# la funcion plot()
# el tiempo se coloca en el eje de las equis
# las observaciones en el eje equis de menor a mayor

print(time_series)
length(time_series) #numero de observaciones
plot(time_series)

plot(Nile, xlab = "Year",
     ylab = "River Volume (1e9 m^{3})",
     main = 'Annual River Nile Volume at Aswan, 1871-1970',
     type = 'b') # l para line, b para puntos y lineas

# funciones
start() # primer valor
end() # ultimo valor
deltat() # intervalo de generacion de datos


# creando objeto ts()

data_vector <- c(10,6,11,8,10,3,6,9)
serie_tiempo <- ts(data_vector)
plot(serie_tiempo)

# agregando año de inicio y tiempo de evolucion
serie_tiempo_2 <- ts(data_vector, start = 2001,
                     frequency = 1)
plot(serie_tiempo_2)

class(serie_tiempo)






