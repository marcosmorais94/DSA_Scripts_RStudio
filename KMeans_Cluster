#%% - Algoritmo K-Means no Python
# Curso de Machine Learning - Data Science Academy

#%% - Carregando Pacotes

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import pylab
from sklearn.cluster import KMeans
from sklearn.metrics import homogeneity_completeness_v_measure
import warnings
warnings.filterwarnings('ignore')


#%% - Gerando a amostra de dados
from sklearn.datasets._samples_generator import make_blobs

#%% - Definindo os centros 
centers = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

#%% - Gerando os dados

X, y = make_blobs(n_samples = 1000, 
                  centers = centers,
                  cluster_std=0.5, 
                  random_state= 101)

# É criado um objeto numpy array com duas colunas e 1000 linhas.

#%% - Plot
plt.scatter(X[:,0],
            X[:,1],
            c = y,
            edgecolors = 'none',
            alpha = 0.9)
plt.show()

#%% - Gera os clusters e cria o plot dos clusters nas células de Voronoi

pylab.rcParams['figure.figsize'] = (10.8, 8.0)

for n_iter in range(1, 5):
    
    #Cria o classificador e constrói o modelo com os dados de entrada definidos nas células anteriores
    modelo = KMeans(n_clusters = 4,
                    max_iter = n_iter,
                    n_init = 1,
                    init = 'random',
                    random_state = 101)
    modelo.fit(X)
    
    # Plot
    plt.subplot(2, 2, n_iter)
    h = 0.02
    xx, yy = np.meshgrid(np.arange(-3, 3, h), np.arange(-3, 3, h))
    z = modelo.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)
    plt.imshow(z,
               interpolation = 'nearest',
               cmap = plt.cm.Accent,
               extent = (xx.min(), xx.max(), yy.min(), yy.max()),
               aspect = 'auto',
               origin = 'lower')
    
    # Função ravel transforma o objeto em um de uma dimensão
    # Inertia = Soma das distâncias das amostras para o seu centro de agrupamento mais próximo
    # Iteration = Número de iterações definido pelo parâmetro n_iter definido acima
    plt.scatter(X[:, 0],
                X[:, 1],
                c = modelo.labels_,
                edgecolors = 'none',
                alpha = 0.7)
    
    plt.scatter(modelo.cluster_centers_[: , 0],
                modelo.cluster_centers_[:, 1],
                marker = 'x',
                color = 'r',
                s = 100,
                linewidths = 4)
    plt.title('Interation=%s, inertia=%s' % (n_iter, int(modelo.inertia_)))

plt.show()

#%% - Check da Homegeneidade do cluster

pylab.rcParams['figure.figsize'] = (6.0, 4.0)

# Definindo a massa de dados
centers = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

X, y = make_blobs(n_samples = 1000, 
                  centers = centers,
                  cluster_std=0.5, 
                  random_state= 101)

# Lista com os valores de K
valores_k = range(2, 10)

# Lista para receber métricas
HCVs = []

for K in valores_k:
    y_pred = KMeans(n_clusters = K,
                    random_state = 101).fit_predict(X)
    HCVs.append(homogeneity_completeness_v_measure(y, y_pred))
    
plt.plot(valores_k, [el[0] for el in HCVs], 'b', label = 'Homogeneidade')
plt.plot(valores_k, [el[1] for el in HCVs], 'g', label = 'Completude')
plt.plot(valores_k, [el[2] for el in HCVs], 'r', label = 'Medida V')
plt.ylim([ 0, 1])
plt.xlabel('Valor de K')
plt.ylabel('Score')
plt.legend(loc = 4)
plt.show()

#%% - Inertia = Soma das distâncias das amostras para o seu centro  de agrupamento mais próximo

# Lista de valores de K
Ks = range(2, 10)

# Lista para as métricas
valores_metrica = []

# Loop por diferentes mdoelos com diferentes valores de K
for K in Ks:
    modelo = KMeans(n_clusters = K, random_state = 101)
    modelo.fit(X)
    valores_metrica.append(modelo.inertia_)
    
plt.plot(Ks, valores_metrica, 'o-')
plt.xlabel('Valor de K')
plt.ylabel('Inertia')
plt.show()
