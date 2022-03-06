#%% - CURSO MACHINE LEARNING - CLASSIFICADOR COM RANDOM FOREST


#EXEMPLO 1 - CRIANDO UMA DECISION TREE
#-----------------------------------------------------------------------------

#%% - Carregando Pacotes
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score

#%% - Carregando Dataset


irisData = pd.read_csv('C:/FCD/DSA/Python/dados/iris_data.csv')


#Primeias 5 linhas do Dataset
print(irisData.head())

#Resumo estatístico
print(irisData.describe())

#Correlação
print(irisData.corr())

#Dividindo variáveis de entrada e saída
features = irisData[['SepalLength','SepalWidth', 'PetalLength', 'PetalWidth']]
targetvariable = irisData.Class

#%% - Modelo
#Dados de treino e teste
featureTrain, featureTest, targetTrain, targetTest = train_test_split(features, targetvariable, test_size = .2)

clf = DecisionTreeClassifier()
print(clf)

modelo = clf.fit(featureTrain, targetTrain)
previsoes = modelo.predict(featureTest)

print(confusion_matrix(targetTest, previsoes))

print(accuracy_score(targetTest, previsoes))

#%% - EXEMPLO 2: CLASSIFICADOR COM RANDOM FOREST


#Carregando Pacotes
import numpy as np
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_digits
from sklearn.preprocessing import scale

#%% - Carregando Dataset
digitos = load_digits()

#%% - Pré Processamento

#Aplica Escala nos dados
data = scale(digitos.data)

print(data)

print(data.shape)

n_observ, n_features = data.shape

n_observ

n_features

#%% - Obtendo labels

n_digits = len(np.unique(digitos.target))
labels = digitos.target

#%% - Criando o Classficador
clf = RandomForestClassifier(n_estimators = 10)
#Estimators é cada árvore, valor default é 10

#%% - Modelo

# Treino
modelo_1 = clf.fit(data, labels)

# Score do modelo
scores = modelo_1.score(data, labels)
print(scores)

# Modelo atingiu 99%, provável overfitting

#%% - Importância dos atributos

# Obtendo os índices
importances = modelo_1.feature_importances_
indices = np.argsort(importances)

ind = []
for i in indices:
    ind.append(labels[i])
#%% - Plot da importância dos atributos
plt.figure(1)
plt.title('Importância dos Atributos')
plt.barh(range(len(indices)), importances[indices], color = 'b', align = 'center')
plt.yticks(range(len(indices)), ind)
plt.xlabel(' Importância Relativa')
plt.show()
