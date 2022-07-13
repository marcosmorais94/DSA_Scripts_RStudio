#%% - CURSO MACHINE LEARNING - CLASSIFICADOR COM RANDOM FOREST


#EXEMPLO 2 - CRIANDO RANDOM FOREST COM REGRESSÃO
#-----------------------------------------------------------------------------

#%% - Carregando Pacotes

import pandas
import matplotlib.pyplot as plt
from sklearn.linear_model import  LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split

#%% - Pré Processamento

#Carregando o Dataset
games = pandas.read_csv('dados/games_data.csv')

#Nomes das colunas
print(games.columns)

#81.312 linhas e 20 colunas
print(games.shape) 

#Histograma com a média das avaliações
plt.hist(games['average_rating'])   
plt.show()

#Visualizando as observações com rating = 0
games[games['average_rating'] == 0]

#Primeira linha com rating = 0
print(games[games['average_rating'] == 0].iloc[0])

#Primeira linha com rating > 0
print(games[games['average_rating'] > 0].iloc[0])

#Removendo linhas com avaliações zeradas
games = games[games['users_rated'] > 0]

#Removendo linhas com valores missing
games = games.dropna(axis = 0)

#Histograma com a médias das avaliações
plt.hist(games['average_rating'])
plt.show

#Correlação das variáveis
print(games.corr()['average_rating'])

#%% - Preparando para o modelo

# Obtém todas as colunas do dataframe
colunas = games.columns.tolist()

# Filtra as colunas  e remove  as que não são  relevantes
colunas = [c for c in colunas if c not in ['bayes_average_rating', 'average_rating', 'type', 'name']]

# Preparando a variável target 
target = 'average_rating'

#%% - Modelo de Machine Learning

#Dados de treino e teste
df_treino = games.sample(frac = 0.8, random_state = 101)

df_teste = games.loc[~games.index.isin(df_treino.index)]

#shape dos datasets
print(df_treino.shape)
print(df_teste.shape)

#%% - Criando o regressor
reg_v1 = LinearRegression()

#%% - Fit no modelo
modelo_v1 = reg_v1.fit(df_treino[colunas], df_treino[target])
print(modelo_v1)

#%% - Previsões do Modelo
previsoes = modelo_v1.predict(df_teste[colunas])

#Erros entre valores observados e previstos
print(mean_squared_error(previsoes, df_teste[target]))

#%% - Modelo com Random Forest

#Criando o regressor
reg_v2 = RandomForestRegressor(n_estimators = 100, min_samples_leaf=10, random_state=101)

modelo_v2 = reg_v2.fit(df_treino[colunas], df_treino[target])

previsoes_2 = modelo_v2.predict(df_teste[colunas])

print(mean_squared_error(previsoes_2, df_teste[target]))

# A taxa de erro do Random Forest Regressor foi de 1.395 bem menor do que
# 1.826 do modelo de Regressão Linear