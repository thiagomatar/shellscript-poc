# ------------------------------- VARIÁVEIS ----------------------------------------- #
USUARIOS=$(cat /etc/passwd | cut -d : -f 1)
MENSAGEM_USO="
  $0 - [OPÇÕES]

    -h - Menu de ajuda
    -v - Versão
    -s - Ordernar a saída
"
VERSAO="v1.0"

# ------------------------------- EXECUÇÃO ----------------------------------------- #
[ $1 = "-h" ] && echo "$MENSAGEM_USO" && exit 0;
[ $1 = "-v" ] && echo "$VERSAO" && exit 0;
[ $1 = "-v" ] && echo "$USUARIOS" | sort && exit 0;
echo "$USUARIOS"
