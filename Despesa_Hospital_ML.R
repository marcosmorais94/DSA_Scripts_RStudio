#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap11')
getwd()

#Problema de negócio: Previsão de despesas hospitalares
#Aprendizagem Supervisionada

#Etapa 1 - Coleta de dados
despesas <- read.csv('despesas.csv')
View(despesas)

#Etapa 2 - Explorando os dados
  #Visualizando as variáveis
  str(despesas)

  #Medidas de tendência central para o custo  
  summary(despesas$gastos)

  #Histograma com os custos
  hist(despesas$gastos, main = "Histograma", xlab = 'Gastos')
  
  #Tabela de Contigência nas Regiões
  table(despesas$regiao)

  #Explorando a correlação das variaveis
  cor(despesas[c('idade','bmi','filhos','gastos')])

  #Visualizando no Scatterplot
  pairs(despesas[c('idade','bmi','filhos','gastos')])
  
  #Usando pacote Psych para Scatterplot com Matriz
  #install.packages('psych')
  library(psych)  

  pairs.panels(despesas[c('idade','bmi','filhos','gastos')])  
  
#Etapa 3 - Treinando o modelo
  #função ML - lm (variavel alvo ~ variavel peditora 1 + vairavel preditoria 2 + ... variavel preditoria n)
  modelo <- lm(gastos ~ idade + filhos + bmi + sexo + fumante + regiao, data = despesas)
  modelo <- lm(gastos ~ ., data = despesas) #versão resumida
  
  #Visualizando o modelo
  modelo

#Etapa 4 - Prevendo o modelo
  #Prevendo despesas médicas
  previsao1 <- predict(modelo)
  View(previsao1)
  
  #Prevendo os gastos com o modelo de teste
  despesateste <- read.csv('despesas-teste.csv')
  View(despesateste)
  previsao2 <- predict(modelo, despesateste)
  View(previsao2)
  
#Etapa 5 - Avaliando o Modelo
  summary(modelo)

#Etapa 6 - Otimizando o Modelo
  #Adicionando uma variável com o dobro do valor das idades
  despesas$idade2 <- despesas$idade ^ 2
  
  #Adicionando uma indicador para BMI >= 30
  despesas$bmi30 <- ifelse(despesas$bmi >= 30, 1, 0)
  
  #Criando Modelo Final
  modelo_v2 <- lm(gastos ~ idade + idade2 + filhos + bmi + sexo + bmi30 * fumante + regiao,
                  data = despesas)
  
  summary(modelo_v2)