#!/usr/bin/env bash

# Abaixo exemplo de como criar funcoes e chama-las

ToUpperCase(){
  local texto="$1"
  echo "$texto" | tr [a-z] [A-Z]
}

ToUpperCase "Essa frase em letras maiúsculas"

myfunc()
{
  echo "I was called as : $@"
  x=2
}

echo "Script was called with $@"
x=1
echo "x is $x"
myfunc 1 2 3
echo "x is $x"
