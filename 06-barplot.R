#Definindo diretório
setwd('C:/FCD/BigDataRAzure/Cap04')
getwd()

#Preparando o dataset
dados <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67),
                nrow = 3, byrow = T)
colnames(dados) <- c('0','1-150','151-300','>300')
rownames(dados) <- c('Jovem','Adulto','Idoso')
dados

#Construindo o bar plot
barplot(dados,beside = T) #colunas lado a lado
barplot(dados) #colunas empilhadas

#Contruindo plot Stacked Bar Plot (Colunas Empilhadas)
barplot(dados, col = c('steelblue1','tan3','seagreen3'))
legend(x = 'topright', 
       legend = c('Jovem', 'Adulto', 'Idoso'),
       fill = c('steelblue1','tan3','seagreen3'),
       title = 'Faixa Etária')

#Mesmo gráfico, mas com matriz transposta
barplot(t(dados), beside = T, col = c('steelblue1','tan3','seagreen3','peachpuff1'))
legend(x = 'topright', 
       legend = c('0','1-150','151-300','>300'),
       fill = c('steelblue1','tan3','seagreen3', 'peachpuff1'),
       title = 'Número de Casametnos')