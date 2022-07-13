#%% - Imports
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA

#%% - Carregando dataset
iris = load_iris()

#%% - V1 modelo
dbscan_v1 = DBSCAN()


#%% - Reduzindo a dimensionalidade
pca = PCA(n_components=2).fit(iris.data)

pca_2d = pca.transform(iris.data)

#%% - PLot
for i in range(0, pca_2d.shape[0]):
    if dbscan_v1.labels_[i] == 0:
        c1 = plt.scatter(pca_2d[i,0], pca_2d[i, 1], c='r', marker='+')
    elif dbscan_v1.labels_[i] == 1:
        c2 = plt.scatter(pca_2d[i,0], pca_2d[i, 1], c='g', marker='0')
    elif dbscan_v1.labels_[i] == -1:
        c3 = plt.scatter(pca_2d[i,0], pca_2d[i, 1], c='b', marker='*')
plt.legend([c1, c2, c3], ['Cluster 1', 'Cluster 2', 'Noise'])
plt.title('DBSCAN Gerou 2 Clusters e Encontrou Noise (Outliers)')
plt.show()