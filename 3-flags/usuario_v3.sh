# ------------------------------- VARIÁVEIS ----------------------------------------- #
USUARIOS=$(cat /etc/passwd | cut -d : -f 1)
MENSAGEM_USO="
  $0 - [OPÇÕES]

    -h - Menu de ajuda
    -v - Versão
    -s - Ordernar a saída
    -m - Coloca em maiúsculo
"
VERSAO="v1.0"
FLAG_ORDENA=0

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case "$1" in
  -h) echo "$MENSAGEM_USO"    && exit 0 ;;
  -v) echo "$VERSAO"          && exit 0 ;;
  -s) FLAG_ORDENA=1                     ;;
  -m) FLAG_MAIUSCULO=1                     ;;
   *) echo "$USUARIOS"        && exit 0 ;;
esac
echo "$USUARIOS"

[ $FLAG_ORDENA -eq 1 ] && echo "$USUARIOS" | sort
[ $FLAG_MAIUSCULO -eq 1 ] && echo "$USUARIOS" | tr [a-z] [A-Z]
