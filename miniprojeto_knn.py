#%% - MINI PROJETO KNN

# A partir de dados de consumo de energia de clientes, o objetivo é agrupar 
# os consumidores por similaridade a afim de compreender o comportamento dos 
# clientes e sua relação com o consumo de energia.

# Fonte dos dados:
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

#%% - Carregando os pacotes

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import pylab
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.model_selection import train_test_split
from scipy.spatial.distance import cdist, pdist
from sklearn.metrics import silhouette_score
import warnings
warnings.filterwarnings('ignore')

#%% - Carregando dataset

dataset = pd.read_csv('dados/household_power_consumption.txt',
                      delimiter = ';',
                      low_memory = False)

#%% - Analise exploratória

# Check dos dados
dataset.head()
dataset.shape
dataset.dtypes

# Check dos valores missing
dataset.isnull().values.any()

# Removendo valores NA e duas primeiras colunas
dataset = dataset.iloc[0:, 2:9].dropna()
dataset.head()

dataset.isnull().values.any() # Sem valores NA

#%% Pré-Processamento

