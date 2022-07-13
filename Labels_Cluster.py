#%% - Gerando Labels para Cluster
# Curso de Machine Learning Data Science Academy

#%% - Importando os Pacotes

import pandas as pd
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
import pylab as pl

#%% - Carregando o Dataset

iris = load_iris()
#%% - Criando o modelo

kmeans = KMeans(n_clusters = 3, random_state = 111)
kmeans.fit(iris.data)

#%% - Cluster Map
cluster_map = pd.DataFrame(iris.data)
cluster_map['cluster'] = kmeans.labels_

#%% - Reduzindo Dimensionalidade
pca = PCA(n_components = 2).fit(iris.data)

#%% - Aplicando PCA
pca_2d = pca.transform(iris.data)

#%% - Gerando Labels
for i in range(0, pca_2d.shape[0]):
    if kmeans.labels_[i] == 0:
        c1 = pl.scatter(pca_2d[i,0], pca_2d[i,1], c='r', marker='+')
    elif kmeans.labels_[i] == 1:
        c2 = pl.scatter(pca_2d[i,0], pca_2d[i,1], c='g', marker='o')
    elif kmeans.labels_[i] == 2:
        c3 = pl.scatter(pca_2d[i,1], pca_2d[i,1], c='b', marker='*')
        pl.legend([c1, c2, c3],['Cluster 0', 'Cluster 1', 'Cluster 2'])
        pl.title('Clusters Kmeans com Iris dataset em 3 clusters')
pl.show()

