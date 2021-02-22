#!/usr/bin/env bash

# Expressoes regulares extendidas

# Filtrar uma linha com 50 digitos ou mais
echo "$(egrep "^.{50,}$" /etc/passwd)"

# Filtrar uma linha com 50 a 60 digitos ou mais
echo "$(egrep "^.{50, 60}$" /etc/passwd)"

# Filtrar uma linha com 90 digitos ou mais
echo "$(egrep "^.{90, }$" /etc/passwd)"

# Usando o operador OU
echo "$(grep -E "usertqi|root" /etc/passwd)"

sudo apt-get update &&  sudo apt-get install docker-ce docker-ce-cli containerd.io
