# Para usar o modo bash debug utilizar o comando
# bash -x ./debug_bash_v1.sh -s -m

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
while test -n "$1"
do
  case "$1" in
    -h) echo "$MENSAGEM_USO"  && exit 0 ;;
    -v) echo "$VERSAO"        && exit 0 ;;
    -s) FLAG_ORDENA=1                   ;;
    -m) FLAG_MAIUSCULO=1                ;;
     *) echo "Opção invalida" && exit 1 ;;
  esac
  shift
done

[ $FLAG_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
[ $FLAG_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
