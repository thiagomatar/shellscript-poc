#!/usr/bin/env bash

# Para adicionar formatacao de texto é necessario colocar as teclas de escape.
# Exemplos

# Utilizamos o echo com o parametro -e
echo -e "\033[34m Texto com a cor azul"
echo -e "\033[31m Texto com a cor vermelha"
# echo -e "\033[32;5m Texto verde piscante"
echo -e "\033[34;1m Texto com a cor azul e negrito"

# Usando cores dinamicamente
AZUL="\033[34m"
echo -e "${AZUL} Ha uma cor azul aqui"


#Tabela de cores e opcoes de formatacao de texto no terminal

# Código  |    Alteração
# ----------------------
# 1       |    Negrito
# 2       |    Borrado
# 4       |    Sublinhado
# 5       |    Piscante
# 7       |    Reverso
# 8       |    Escondido
# 30      |    Preto
# 31      |    Vermelho
# 32      |    Verde
# 33      |    Amarelo
# 34      |    Azul
# 35      |    Roxo
# 36      |    Ciano
# 37      |    Cinza Claro
# 40      |    Fundo Preto
# 41      |    Fundo Vermelho
# 42      |    Fundo Verde
# 43      |    Fundo Amarelo
# 44      |    Fundo Azul
# 45      |    Fundo Roxo
# 46      |    Fundo Ciano
# 47      |    Fundo Cinza Claro
