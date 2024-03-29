# FORMAÇÃO CIENTISTA DE DADOS - MACHINE LEARNING
# ESTUDO DE CASO - ANÁLISE DE RISCO DE CRÉDITO

#Definindo diretório de trabalho
setwd('c:/FCD/DSA/R/dados')
getwd()


#Carregando o dataset
credit <- read.csv('credito.csv')
str(credit)
View(credit)


#Convertendo em variáveis do tipo fator

names <- c('checking_balance', 'credit_history', 'purpose',
           'savings_balance', 'employment_duration', 'other_credit',
           'housing', 'job', 'default')

credit[,names] <- lapply(credit[,names], as.factor)
str(credit)

#Verificando 2 atributos do cliente, balance saving e checking balance
summary(credit$checking_balance)
summary(credit$amount)

#Analisando variável target
table(credit$default)

#Classe desbalanceada, opção seria aplicar a técnica smooth
#Boa prática é criar o modelo desbalanceado e depois balanceado

#A mesma proporção, que no caso é 70 e 30, deve ser mantida nos dados
#de treino e teste para que o resultado não seja comprometido

#Usando sample para construir os dados de treino e teste
set.seed(123)
train_sample <- sample(1000, 900)

#Split DataFrame com a função sample
credit_train <- credit[train_sample,]
credit_test <- credit[-train_sample,]

#Dessa forma o dataset fica da forma mais generalista possível

#Verificando a proporção dos dados de treino e teste
#A mesma proporção, que no caso é 70 e 30, deve ser mantida nos dados
#de treino e teste para que o resultado não seja comprometido

prop.table(table(credit_test$default))
prop.table(table(credit_train$default))

#A proporção se manteve em ambos os datasets...


#Pacote C50 para algoritmo de árvore de decisão
install.packages('C50')
library(C50)

#Criando o modelo de Machine Learning
credit_model <- C5.0(credit_train[-17], credit_train$default)
summary(credit_model)

# Pontos importantes para o Summary

#Ao final do summary, temos o ERRORS, que é quantidad de erros
#nesse caso, temos 11% de erro o que razoável para o modelo

#Outro ponto importante é o ATRIBUTE USAGE, que mostra as variáveis
#mais significativas para o modelo.
# No exemplo, foi o checking_balance que é o saldo em conta!!

#Previsões com o Modelo
credit_pred <- predict(credit_model, credit_test)

#Confusion Matrix para comparar valores observados e previstos
install.packages('gmodels')
library(gmodels)

#Criando a Confusion Matrix
CrossTable(credit_test$default,
           credit_pred,
           prop.chisq = F,
           prop.c = F,
           prop.r = F,
           dnn = c('Observado', 'Previsto'))

#Primeiro passamos o histório e depois o previsto!!

#Melhorando o modelo
#Arvore com menos nós entre as versões do modelo indica que
# o modelo aprendeu mais em menos nós... um bom sinal

#Novo modelo com 10 tentatis, argumento trials
credit_boost10 <- C5.0(credit_train[-17], credit_train$default, trials = 10)
summary(credit_boost10)

# Com trials, cada passada tem uma % de erro e os variáveis mais relavantes
# também têm alteração

#Score do modelo
credit_boost_pred10 <- predict(credit_boost10, credit_test)

#Confusion Matrix
CrossTable(credit_test$default,
           credit_boost_pred10,
           prop.chisq = F,
           prop.c = F,
           prop.r = F,
           dnn = c('Observado', 'Previsto'))


#Bonus - Peso nos erros
#É uma técnica interessante porque alguns modelos podem impactar
#a vida das pessoas. Assim, o modelo é penalizado ao errar.


#Matriz de dimensão de custo
matrix_dimensions <- list(c('no', 'yes'), c('no', 'yes'))
names(matrix_dimensions) <- c('Previsto', 'Observado')
matrix_dimensions

#Construindo a Matriz
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2, dimnames = matrix_dimensions)
error_cost


#Modelo
credit_cost <- C5.0(credit_train[-17], credit_train$default, costs = error_cost)

#Score do Modelo
credit_cost_pred <- predict(credit_cost, credit_test)

#Confusion Matrix
CrossTable(credit_test$default,
           credit_cost_pred,
           prop.chisq = F,
           prop.c = F,
           propr.r = F,
           dnn = c('Obervado', 'Previsto'))