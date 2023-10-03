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

## graficos con ts.plot()
ts.plot(eu_stock, col = 1:4, xlab = "Year",
        ylab = "Index Value",
        main = "Major European Stock Indices, 1991-1998")


# trend

# diff() se utiliza para conocer los incrementos en
# el cambio en una tendencia


# white noise model

# ejemplo de modelo estacionario
#  promedio constante, varianza constante
# sin correlación sobre el tiempo

# la funcion arima.sim() simula un WN serie

wn_1 <- arima.sim(model = list(order = c(0,0,0)), n = 50)
head(wn_1)
ts.plot(wn_1)

wn_2 <- arima.sim(model = list(order = c(0,0,0)), n = 50,
                  mean = 4, sd = 2)
head(wn_2)
ts.plot(wn_2)

# estimando modelo wn

arima(wn_2, order = c(0,0,0))
mean(wn_2) # similar a arima
var(wn_2) # sinilar a arima

# random walk model

# proceso no estacionario, no estable
# sin promedio o varianza específica
# fuerte dependencia sobre el tiempo

# funcion:
# today = yesterday + noise
# Yt = Yt-1  +  Et

random_walk <- arima.sim(model = list(order = c(0,1,0)),
                         n = 100)



# Difference your random_walk data
rw_diff <- diff(random_walk)

# Plot rw_diff
ts.plot(rw_diff)

# Now fit the WN model to the differenced data
model_wn <- arima(rw_diff, order = c(0,0,0))

# Store the value of the estimated time trend (intercept)
int_wn <- model_wn$coef

# Plot the original random_walk data
ts.plot(random_walk)

# Use abline(0, ...) to add time trend to the figure
abline(a = 0, b = int_wn)

## stationary processes

plot.ts(cbind(white_noise,
              random_walk, wn_drift,
              rw_drift)) # varios plots en uno solo



# scatter

plot(stock_a, stock_b)

# covariance and correlations




















