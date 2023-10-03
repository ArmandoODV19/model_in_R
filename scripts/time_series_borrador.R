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







