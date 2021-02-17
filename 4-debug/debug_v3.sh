# Utilizando função para debugar trechos de código

# ------------------------------- VARIÁVEIS ----------------------------------------- #
FLAG_DEBUG=0
NIVEL_DEBUG=0
# ------------------------------- Funções ------------------------------------------- #

Debug () {
  [ $1 -le $NIVEL_DEBUG ] && echo "Debug $* ------"
}

Soma () {
  local total=0
  for i in $(seq 1 25); do
    Debug 1 "Entrei no for com valor: $i"
    total=$((total + i))
    Debug 2 "Soma: $i"
  done;
  echo $total
}

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case "$1" in
  -d) [ $2 ] && NIVEL_DEBUG=$2 ;;
  *)  Soma
esac

Soma
