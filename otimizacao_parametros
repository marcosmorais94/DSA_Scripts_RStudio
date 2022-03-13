#%% - OTIMIZAÇÃO DE PARÂMETROS COM RANDOMIZED SEARCH - CURSO MACHINE LEARNING


#%% - Pacotes

import pandas as pd
import numpy as np
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.model_selection import cross_val_score
from sklearn. model_selection import train_test_split
from sklearn.preprocessing import scale
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
import warnings
warnings.simplefilter(action = 'ignore', category = FutureWarning)

#%% - Carga do Dataset
data = pd.read_excel('dados/credit.xls', skiprows = 1)

print(data)

#%% - Definição variável target
target = 'default payment next month'
y = np.asarray(data[target])

#%% - Variável Preditora
features = data.columns.drop(['ID'], target)
x = np.asarray(data[features])

#%% - Divisão de treino e teste

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.30, random_state = 99)

#%% - Classificador
clf = ExtraTreesClassifier(n_estimators = 500, random_state = 99)

#%% - Treinamento do modelo
clf.fit(x_train, y_train)

#%% - Score do modelo
scores = cross_val_score(clf, x_train, y_train, cv = 3, scoring = 'accuracy', n_jobs = -1)

print("ExtraTreeClassifier -> Acurácia em Treino: Média = %0.3f e Desvio Padrão = %0.3f" % (np.mean(scores), np.std(scores))) 

#%% - Previsões do Modelo
y_pred = clf.predict(x_test)

#%% - Confusion Matrix
ConfusionMatrix = confusion_matrix(y_test, y_pred)
print(ConfusionMatrix)

#%% - Acurácia

print('Acurácia em teste:', accuracy_score(y_test, y_pred))


#%% - GreedSearch x Randomized Search

#Pacotes

import numpy as np
from time import time
from scipy.stats import randint as sp_randint
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import RandomizedSearchCV
from sklearn.datasets import load_digits

#%% - Carga do Datatset

digits = load_digits()
x, y = digits.data, digits.target

#%% - Classificador
clf = RandomForestClassifier(n_estimators = 20)

#%% - Valores dos parâmetros que serão testados
param_dist = {'max_depth': [3, None],
              'max_features': sp_randint(1, 11),
              'min_samples_leaf': sp_randint(1, 11),
              'bootstrap': [True, False],
              'criterion': ['gini', 'entropy']}

#%% - Executando Randomized Search
n_iter_search = 20
random_search = RandomizedSearchCV(clf, 
                                   param_distributions = param_dist,
                                   n_iter = n_iter_search,
                                   return_train_score = True)

#%% - Treino do modelo

start = time()
random_search.fit(x,y)

#%% - Print dos Resultados
print('RandomizedSearchCV executou em %2.f segundos para %d candidatos  a parâmetros do modelo.', ((time() - start), n_iter_search))

# Imprime as combinações dos parâmetros  e suas respectivas  médias de acurácia.
random_search.cv_results_
