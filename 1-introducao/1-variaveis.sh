#!/usr/bin/env bash

# Para definir uma variavel basta descrever o nome e atribuir o
# valor com =, sem espaço
VARIAVEL=Valor

# Para tornar explícito que a variavel é do tipo caracteres, atribua
# o valor entre ""
STRING="Valor"

# Para atribuir a variavel resultante de um cálculo, usar $(())
VAL1=2
VAL2=2
RESULTADO=$(($VAL1 + $VAL2))

# Para ler o valor de uma variavel utilizar $NOME_DA_VARIAVEL
echo $RESULTADO

# Quando o valor de uma variavel for do tipo caracteres utilizar
# "$NOME_DA_VARIAVEL"
echo "$STRING"

# Para atribuir um array em uma variavel utilizamos conforme demonstrado
# abaixo
Array=(
  'elemento 1'
  'elemento 2'
  'elemento 3'
)
# Para recuperar um elemento de um array devemos usar ${} conforme demonstrado
# abaixo
echo "Array " ${Array[0]}

# As variaveis em shellscript podem ser utilizadas para armazenar
# retorno de execução de comandos
CURL=$(curl -I http://www.example.org | head -n1 | grep 200)
echo "$CURL"

# Abaixo algumas variaveis reservadas e não devem ser utilizadas para
# atribuir valores

# As variaveis $1 $2, ... são variaveis que representam os
# parametros enviados na chamada do script e não devem ser utilizadas Ex:
echo "Parametro 1 -> $1"

# A variável $* representa a a listagem de todos os parametros enviados
# na chamada do shellscript
echo "Parametros -> $*"

# A variavel $# representa a contagem de todos os parametros enviados na
# chamada do shellscript
echo "Quantidade de parametros -> $#"

# A variavel $? representa a saida do ultimo comando com a
# saída 0-> OK e 1-: ERRO
echo "Ultimo comando -> $?"

# A variavel $$ representa o PID do programa executado
echo "PID $$"

# A variavel $0 retorna o nome do script
echo "$0"
