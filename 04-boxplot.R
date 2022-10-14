#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap04')
getwd()

#carregando dataset com attach
#não preciso dizer o nome do dataset, somente coluna
attach(sleep)

#Criando o Boxplot
sleepboxplot <- boxplot(data = sleep, extra ~ group, main = 'Duração do Sono',
                        col.main = 'red', ylab = 'Horas', xlab = 'Droga')

#Criando vetor de média
medias <- by(extra, group, mean)

#Criando pontos de média
points(medias, col = 'red')
#Estou com a seção já com o boxplot nesse momento, 
#por isso não preciso dizer qual gráfico a função points vai
#basicamente ele só altera a camada da gráfico atual
#FAZER GRÁFICOS EM CAMADA SEMPRE!!!

#boxplot horizontal
boxplot_horizontal <- boxplot(data = sleep, extra ~ group, 
                              main = 'Duração do Sono',
                              col.main = 'red', 
                              ylab = 'Horas', 
                              xlab = 'Droga',
                              horizontal = T)

boxplot_horizontal_colorido <- boxplot(data = sleep, extra ~ group, 
                              main = 'Duração do Sono',
                              col.main = 'red', 
                              ylab = 'Horas', 
                              xlab = 'Droga',
                              horizontal = T,
                              col = c('sienna2','orange'))
