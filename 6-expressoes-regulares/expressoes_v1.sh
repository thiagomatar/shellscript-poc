#!/usr/bin/env bash

FILTER=$(grep "^user" /etc/passwd)
echo "Todo usuario que comeca com user"
echo "$FILTER"

echo "Todo usuario que terina com h"
FILTER=$(grep "h$" /etc/passwd)
echo "$FILTER"

echo "Filtrar tudo que comece com um conjunto e termine com outro"
FILTER=$(grep "^u.*h$" /etc/passwd)
echo "$FILTER"

# Tabela com oepradores padroes 
#  Operador |  Descrição
#     ^     |   Início da linha
#     $     |   Fim da linha
#     .     |   Curinga que representa um caractere
#     +     |   O dígito anterior deve aparecer uma vez ou mais
#     []    |   Lista de caracteres (cas com qualquer um deles)
#     [^]   |   Lista de caracteres negada
#     |     |   Operador "ou"
#     .*    |   Curing para qualquer coisa
#     *     |   O dígito anterior pode aparecer em qualquer quantidade
#     {,}   |   O dígito anterior deve aparecer na quantidade indicada
