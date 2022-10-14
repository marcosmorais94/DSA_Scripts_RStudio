#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap04')
getwd()

#carregando o gglpot2 e reshape2
library(ggplot2)
library(reshape2)

#Plotando um gráfico simples com qplot()
data(tips, package = 'reshape2')
qplot(total_bill, tip, data = tips, geom = 'point')

#Construindo um gráfico pela camada 1
camada1 <- geom_point(
  mapping = aes(x = total_bill, y = tip, color = sex),
  data = tips, 
  size = 3
)
#aes muda toda a estética do gráfico, usar o help

ggplot() + camada1 #aqui criamos o gráfico ao juntar as camadas

#Gráfico a partir do modelo de regressão
modelo_base <- lm(tip ~ total_bill, data = tips)
modelo_fit <- data.frame(
  total_bill = tips$total_bill,
  predict(modelo_base, interval = 'confidence')
)

head(modelo_fit)

camada2 <- geom_line(
  mapping = aes(x = total_bill, y = fit),
  data = modelo_fit,
  color = 'darkred'
)

ggplot() + camada1 + camada2

#Camada 3 no gráfico
camada3 <- geom_ribbon(
  mapping = aes(x = total_bill, ymin = lwr, ymax = upr),
  data = modelo_fit,
  alpha = 0.3
)

ggplot() + camada1 + camada2 + camada3

#Versão final otimizada
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(aes(color = sex)) +
  geom_smooth(method = 'lm')

#Scatterplot com linha de regressão
data = data.frame(
  cond = rep(c('Obs 1', 'Obs 2'),
  each = 10), 
  var1 = 1:100 + rnorm(100, sd = 9), 
  var2 = 1:100 + rnorm(100, sd = 16))

ggplot(data, aes(x = var1, y = var2)) + 
  geom_point(shape = 1) + 
  geom_smooth(method = lm, color = 'red', se = F)

#Bar plot no ggplot2
data1 = data.frame(
  grupo = c('A','B','C','D'),
  valor = c(33,62,56,67),
  num_obs = c(100,500,459,342))

data1$right = cumsum(data1$num_obs) + 30*c(0:(nrow(data1) - 1))
data1$left = data1$right - data1$num_obs
data1

ggplot(data1, aes(ymin = 0)) +
  geom_rect(aes(xmin = left, xmax = right,
                ymax = valor,  colour = grupo, fill = grupo)) +
                xlab('Número de Observações') + 
                ylab('Valor')

#Gráficos usando mtcars
ggplot(data = mtcars, 
       aes(x = disp, y = mpg, colour = as.factor(am))) + 
  geom_point()

#Mapeando a cor dos pontos
ggplot(data = mtcars, 
       aes(x = disp, y = mpg, colour = cyl)) + geom_point()

#Mapeando o tamanho dos pontos
ggplot(data = mtcars, 
  aes(x = disp, y = mpg, colour = cyl, size = wt)) + 
  geom_point()

#Variável contínua na cor dos pontos
ggplot(data = mtcars, 
       aes(x = disp, y = mpg, colour = cyl)) + geom_point()

#Boxplot
ggplot(data = mtcars, aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot()

#Histograma
ggplot(mtcars, aes(x = mpg), binwidth = 30) + geom_histogram()

#Barras
ggplot(mtcars, aes(x = as.factor(cyl))) + geom_bar()

#Colour preenche a linha do gráfico
#Fill preenche o gráfico com uma cor

#Trocando a posição da legenda
ggplot(mtcars, 
       aes(x = as.factor(cyl), fill = as.factor(cyl))) +
       geom_bar() +
       labs(fill = 'cyl') + 
       theme(legend.position = 'top')
#Labs é refente a legenda em si
#theme é configuração da legenda, como posição
?labs
?theme
#Fill igual a FALSE remove a legenda

#Criando facet
ggplot(mtcars, 
       aes(x = mpg, y = disp, colour = as.factor(cyl))) +
       geom_point() + 
  facet_grid(am~.) #var AM vs Todas as outras

#Gráficos diferentes no facet
library(gridExtra)

plot1 <- qplot(price, data = diamonds, binwidth = 1000)
plot2 <- qplot(carat, price ,data = diamonds, colour = cut)

grid.arrange(plot1, plot2, ncol = 1)

#Reshape no facet
install.packages('plotly')
library(plotly)
