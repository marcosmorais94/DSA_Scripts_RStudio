#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap11')
getwd()

#Problema de negócio: Previsão de Ocorrência de câncer de mama

# Etapa 1 - Carregando os dados
  dados <- read.csv('dataset.csv', stringsAsFactors = F)
  str(dados)
  View(dados)
  
# Etapa 2 - Pre Processamento de dados
  #Excluir coluna ID para não influenciar o modelo
  dados$id <- NULL

  #renomeando a classificação do tumor  
  dados$diagnosis <- sapply(dados$diagnosis, function(x){ifelse(x == 'M', 'Maligno', 'Benigno')})
  
  #Alguns classificadores exigem ser do tipo fator
  table(dados$diagnosis)
  dados$diagnosis <- as.factor(dados$diagnosis)
  str(dados$diagnosis)  
  
  #Normalização dos dados para deixálos na mesma unidade
  #Esse é um processo de padronização
  normalizar <- function(x){
    return((x - min(x)) / (max(x) - min(x)))
  }
    #testando a função
  normalizar(c(1,2,4,5))
  normalizar(c(10,20,30,40,50))

  #Normalizando dados
  dados_norm <- as.data.frame(lapply(dados[2:31], normalizar))
  View(dados_norm)
  
# Etapa 3 - Modelo com KNN
  library(class)

  # Criando novos datasets de treino e de teste
  dados_treino <- dados_norm[1:469, ]
  dados_teste <- dados_norm[470:569, ]
  
  #Os dados de label será o que o knn irá preencher na previsão
  dados_treino_labels <- dados[ 1:469, 1] 
  dados_teste_labels <- dados[ 470:569, 1]
  
  # Reclassificando
  modelo_knn_v1 <- knn(train = dados_treino, 
                       test = dados_teste,
                       cl = dados_treino_labels, 
                       k = 21)  
  
# Etapa 4 - Avaliando e interpretando o modelo KNN

  #Será usado uma tabela cruzado com dados previstos x dados atuais. Amosta com 100
  library(gmodels)
  CrossTable(x = dados_teste_labels, y = modelo_knn_v1, prop.chisq = F)
  
#Etapa 5 - Otimizando o modelo KNN
  
  #Pradonização do z-score
  #Esse é um processo de normalização dos dados
  dados_z <- as.data.frame(scale(dados[-1]))
    #-1 é para tirar a variavél algo
  
  #Criando dados de treino e teste
  dados_treino <- dados_z[1:469, ]
  dados_teste <- dados_z[470:569, ]
  
  dados_treino_labels <- dados[1:469, 1]
  dados_teste_labels <- dados[470:569, 1]
  
  #reclassificando
  modelo_knn_v2 <- knn(train = dados_treino, 
                       test = dados_teste,
                       cl = dados_treino_labels, 
                       k = 21)  
  
  CrossTable(x = dados_teste_labels, y = modelo_knn_v2, prop.chisq = F)
  
  
  #Etapa 5 - Uso o VSM no modelo
  set.seed(40) 
  
  # Prepara o dataset
  dados <- read.csv("dataset.csv", stringsAsFactors = FALSE)
  dados$id = NULL
  dados[,'index'] <- ifelse(runif(nrow(dados)) < 0.8,1,0)
  #View(dados)
  
  # Dados de treino e teste
  trainset <- dados[dados$index==1,]
  testset <- dados[dados$index==0,]
  
  # Obter o índice 
  trainColNum <- grep('index', names(trainset))
  
  # Remover o índice dos datasets
  trainset <- trainset[,-trainColNum]
  testset <- testset[,-trainColNum]
  
  # Obter índice de coluna da variável target no conjunto de dados
  typeColNum <- grep('diag',names(dados))

  View(trainset)
  
  #library(e1071)
  trainset$diagnosis <- as.factor(trainset$diagnosis)
  modelo_svm_v1 <- svm(diagnosis ~., 
                       data = trainset, 
                       type = 'C-classification', 
                       kernel = 'radial') 
  
  # Previsões nos dados de treino
  pred_train <- predict(modelo_svm_v1, trainset) 
  View(pred_train)
  # Percentual de previsões corretas com dataset de treino
  mean(pred_train == trainset$diagnosis)  
  
  
  # Previsões nos dados de teste
  pred_test <- predict(modelo_svm_v1, testset) 
  
  # Percentual de previsões corretas com dataset de teste
  mean(pred_test == testset$diagnosis)  
  
  # Confusion Matrix
  table(pred_test, testset$diagnosis)
  
  # Etapa 7: Construindo um Modelo com Algoritmo Random Forest
  
  # Criando o modelo
  library(rpart)
  modelo_rf_v1 = rpart(diagnosis ~ ., data = trainset, control = rpart.control(cp = .0005)) 
  
  # Previsões nos dados de teste
  tree_pred = predict(modelo_rf_v1, testset, type='class')
  
  # Percentual de previsões corretas com dataset de teste
  mean(tree_pred==testset$diagnosis) 
  
  # Confusion Matrix
  table(tree_pred, testset$diagnosis)
  