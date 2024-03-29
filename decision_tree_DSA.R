#Definindo diretório de trabalho
setwd('c:/FCD/DSA/R')
getwd()

# Criando um dataframe
?expand.grid
clima <- expand.grid(Tempo = c("Ensolarado","Nublado","Chuvoso"), 
                     Temperatura = c("Quente","Ameno","Frio"), 
                     Humidade = c("Alta","Normal"), 
                     Vento = c("Fraco","Forte")) 

#Função expand.grid cria um dataframe a partir de um conjunto de vetores

# Visualizando o dataframe
View(clima)

# Vetor para selecionar as linhas 
response <- c(1, 19, 4, 31, 16, 2, 11, 23, 35, 6, 24, 15, 18, 36) 

# Gerando um vetor do tipo fator para a Variável target
play <- as.factor(c("Não Jogar", "Não Jogar", "Não Jogar", "Jogar", "Jogar", "Jogar", "Jogar", "Jogar", "Jogar", "Jogar", "Não Jogar", "Jogar", "Jogar", "Não Jogar")) 

# Dataframe final
tennis <- data.frame(clima[response,], play)
View(tennis)

#Carregando Pacotes
library(rpart)

#Criando o modelo
tennis_tree <- rpart(play ~., data = tennis, method = 'class',
                     parms = list(split = 'information'), 
                     control = rpart.control(minsplit = 1))

#rpart é a função para árvores de decisão no R
#rpart control é uma função para controle de parametros

tennis_tree #esse é o resultado da árvore de decisão, mas não é muito prático

install.packages('rpart.plot')
library(rpart.plot) #pacote para plot da árvore

prp(tennis_tree, type = 0, extra = 1, under = T, compress = T)



# Fazendo previsões com o modelo

# Dados
clima <- expand.grid(Tempo = c("Ensolarado","Nublado","Chuvoso"), 
                     Temperatura = c("Quente","Ameno","Frio"), 
                     Humidade = c("Alta","Normal"), 
                     Vento = c("Fraco","Forte")) 

# Vetor para selecionar as linhas 
response <- c(2, 20, 3, 33, 17, 4, 5) 

# Novos dados
novos_dados <- data.frame(clima[response,])
View(novos_dados)

# Previsões
?predict
predict(tennis_tree, novos_dados)

# ---------------------------------------------------------------------------

#Prunning da árvore de decisão
#O Prunning é usado para melhorar a acurácia do modelo
#Algumas folhas são removidas da árvore

#gerando o dataset
data("Titanic", package = 'datasets')

#Criando o data frame
dataset <- as.data.frame(Titanic)
View(dataset)


titanic_tree <- rpart(Survived ~ Class + Sex + Age,
                      data = dataset,
                      weights = Freq,
                      method = 'class',
                      parms = list(split = 'information'),
                      control = rpart.control(minsplit = 5))

pruned_titanic_tree <- prune(titanic_tree, cp = 0.02)
pruned_titanic_tree


#Antes do Pruning
prp(titanic_tree, type = 0, extra = 1, under = T, compress = T)


#Depois do Pruning
prp(pruned_titanic_tree, type = 0, extra = 1, under = T, compress = T)
