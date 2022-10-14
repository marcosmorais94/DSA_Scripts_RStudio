#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap04')
getwd()


#Definindo dataset
dados <- cars$speed

#Construido o histograma
hist(dados)

#Alterando o histograma
hist(dados, breaks = 10, main = 'Histograma de Velocidades')
hist(dados, labels = T, breaks = c(0,5,10,20,30), main = 'Histograma de Velocidades')
hist(dados, labels = T, breaks = 10, main = 'Histograma de Velocidades' )
hist(dados, labels = T,ylim = c(0,10) ,breaks = 10, main = 'Histograma de Velocidades' )

#Adicionando linhas no histograma (curva normal)
grafico <- hist(dados, breaks = 10, main = 'Histograma de Velocidades')

xaxis <- seq(min(dados), max(dados), length = 10)
yaxis <- dnorm(xaxis, mean = mean(dados), sd = sd(dados))
yaxis <- yaxis*diff(grafico$mids)*length(dados)

lines(xaxis, yaxis, col = 'red')