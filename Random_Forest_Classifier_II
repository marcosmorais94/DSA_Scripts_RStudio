#%% - CURSO MACHINE LEARNING - CLASSIFICADOR COM RANDOM FOREST 2


#EXEMPLO 2 - CRIANDO RANDOM FOREST CLASSIFIER
#-----------------------------------------------------------------------------

#%% - Carregando Pacotes
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from treeinterpreter import treeinterpreter as ti
from sklearn.datasets import load_iris

#%% - Carregando o datatset 

iris = load_iris()

#%% - Criando o Classificador

rf = RandomForestClassifier(max_depth = 4)

#%% - Obtendo índice

idx = list(range(len(iris.target))) # qtd a partir da variável target
np.random.shuffle(idx) #indice random

#%% - Modelo de Machine Learning
rf.fit(iris.data[idx][:100], iris.target[idx][:100])

#%% - Resultado do Modelo

#Obtendo as instâncias e as probabilidades
instance = iris.data[idx][100:101]
print(rf.predict_proba(instance))

#%% - Contribuição de cada variável no resultado final

prediction, bias, contribuitions = ti.treeinterpreter.predict(rf, instance)
print('Previsões', prediction)
print('Contruibuição dos Atributos: ')
for item, feature in zip(contribuitions[0], iris.feature_names):
    print(feature, item)
