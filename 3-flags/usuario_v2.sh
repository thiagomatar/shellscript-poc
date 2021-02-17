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
case "$1" in
  -h) echo "$MENSAGEM_USO"    && exit 0 ;;
  -v) echo "$VERSAO"          && exit 0 ;;
  -s) echo "$USUARIOS" | sort && exit 0 ;;
   *) echo "$USUARIOS"        && exit 0 ;;
esac
echo "$USUARIOS"
