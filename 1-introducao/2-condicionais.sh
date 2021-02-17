#!/usr/bin/env bash

# Existem algumas formas de se usar o if

# Na forma demonstrado abaixo utilizamos a palavra chave if seguido de [[  ]].
# Observe os espaços dentro dos colchetes, eles sao relevantes.
# O operador de comparacao do shellscript é o =

VAR=""
VAR2=""
if [[ $VAR = $VAR2 ]]; then
  echo "São iguais"
fi

if [[ $VAR = $VAR2 ]]
then
  echo "São iguais"
fi

if test "$VAR" = "$VAR2"; then
  echo "São iguais"
fi


if test "$VAR" = "$VAR2"
then
  echo "São iguais"
fi

if [ $VAR = $VAR2 ]
then
  echo "São iguais"
fi

# É boa pratica, quando houver somente uma instrução dentro do bloco do if
# utilizar este modelo de condicionao onde o && representa o then
[ $VAR = $VAR2 ] && echo "São iguais"

#If aninhados
PARAM=0
if [ $PARAM -gt 0 ]
then
  if [ $PARAM -gt 1 ]
  then
    if [ $PARAM -gt2 ]
    then
      echo $PARAM
    fi
  fi
fi

case "$1" in
  -h) echo "$MENSAGEM_USO"    && exit 0 ;;
  -v) echo "$VERSAO"          && exit 0 ;;
  -s) FLAG_ORDENA=1                     ;;
  -m) FLAG_MAIUSCULO=1                     ;;
   *) echo "$USUARIOS"        && exit 0 ;;
esac

# Tabela de condicionais

# Comparação de Strings   | Descrição
# Str1 = Str2             | Retorna true se as Strings são iguais
# Str1 != Str2            | Retorna true se as Strings não são iguais
# -n Str1                 | Retorna true se a String não é null
# -z Str1                 | Retorna true se a String é null

# Comparação Numérica     | Descrição
# expr1 -eq expr2         | Retorna true se os valores são iguais
# expr1 -ne expr2         | Retorna true se os valores não são iguais
# expr1 -gt expr2         | Retorna true se o expr1 é maior que o expr2
# expr1 -ge expr2         | Retorna true se o expr1 é maior ou igual ao expr2
# expr1 -lt expr2         | Retorna true se o expr1 é menor que o expr2
# expr1 -le expr2         | Retorna trues se o expr1 é menor ou igual ao expr2
# ! expr1                 | Nega o resultado da expressão (se for true vira
#                           false e vice-versa)

# Condicionais de arquivo | Descrição
# -d file                 | Retorna se for um diretório
# -e file                 | Retorna true se o arquivo existir
# -f file                 | Retorna true se o arquivo existir (-f é mais usado
#                           porque é mais portável)
# -g file                 | Retorna true se o GID estiver habilitado no arquivo
# -r file                 | Retorna true se o arquivo tiver permissão de leitura
# -s file                 | Retorna true se o arquivo tiver um tamanho
#                           diferente de zero
# -u                      | Retorna true se o UID estiver habilitado no arquivo
# -w                      | Retorna true se o arquivo tiver permissão de escrita
# -x                      | Reteorna true se o arquivo tiver permissão
#                           de execução
