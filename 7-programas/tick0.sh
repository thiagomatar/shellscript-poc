#!/usr/bin/env bash
#
# tick.sh - Realiza requisições http e verifica status da requisicao.
#           Caso a requisição falhe o programa é finalizado com status 1
#           É possivel definir um percentual de erro aceitavel
#
# Site:       https://github.com/thiagomatar
# Autor:      Thiago Queiroz Matar
#
# ------------------------------------------------------------------------ #
#  Descricao do script
#
#  Exemplos:
#      $ ./tick.sh -u http://localhost:8080/account
#      Neste exemplo o programa irá realizar 10 requisicoes http
#      GET para o host informado com 1s de atraso entre as requisições
#
#      $ ./tick.sh -u http://localhost:8080/account -m POST -r 50 -t 0s -H \
#      Content-Type: application/json -d {"name": "Test"} -s 80 -p
#      Neste exemplo o programa irá realizar 50 requisicoes(-r 50) http POST (-m POST)
#      com 0 segundos(-t 0s) de atraso entre as requisicoes com passando um
#      header (-H Content-Type: application/json)  e um corpo para requisicao
#      (-d {"name": "Test"}). Tambem espera que 80% das requisicoes tenham
#      status 2XX e imprime o resultado no final
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 19/02/2021, Thiago Queiroz Matar:
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.20
# ------------------------------------------------------------------------ #


# ------------------------------- VARIABLES ----------------------------------------- #
VERSION="v1.0"
USAGE="usage: $0 -h"
HELP="
  $0 - [OPTIONS]

  -t - Delay between requests in seconds or minutes (default=1s). Ex: 1s, 1m
  -u - Set URL (argument mandatory)
  -m - Set HTTP method (defaut GET)
  -d - Set body of request
  -H - Set header (default Content-Type:application/json)
  -r - Define a series of requests (default 10)
  -s - Set a percentage of success (default 100%)
  -p - Print the results of requests
  -h - Help
  -v - Version


  Examples:
  $0 -u http://localhost:8080/account
  $0 -u http://localhost:8080/account -m POST
  $0 -u http://localhost:8080/account -m POST -r 50 -t 0s -H Content-Type: application/json -d {"name": "Test"} -s 80 -p
"
DELAY=1s
COUNT=10
METHOD="GET"
CONTENT_TYPE_HEADER="Content-Type:application/json"
RESPONSE_LIST=()
BODY=""
SUCCESS_PERCENTAGE=100

FLAG_HELP=0
FLAG_VERSION=0
FLAG_PRINT=0
# ------------------------------------------------------------------------ #
# ------------------------------- TESTS ----------------------------------------- #
[ ! -x "$(which curl)" ] && echo "curl has not been installed" && exit 1 # curl instalado?
# ------------------------------------------------------------------------ #

# ------------------------------- FUNCTIONS ----------------------------------------- #

isTheDelayArgumentValid(){
  regex='^[0-9]+(s|m|h)$'
  if ! [[ $1 =~ $regex ]] ; then
     echo "Error: \"-t $1\" is not a valid format. Please check $USAGE" >&2; exit 1
  fi
}

isUrlMalformed() {
  regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
  if [[ ! $1 =~ $regex ]]
  then
      echo "Malformed url, Please check $USAGE" && exit 1;
  fi
}

isHttpMethodValid(){
  regex='^(POST|PUT|GET)$'
  if ! [[ $1 =~ $regex ]] ; then
     echo "Error: \"-m $1\" is not a valid method. Please check $USAGE" >&2; exit 1
  fi
}

isSuccessPercentageValid(){
  regex='^[1-9]$|^[1-9][0-9]$|^(100)$'
  if ! [[ $1 =~ $regex ]] ; then
     echo "Error: \"-s $1\" is not a valid percentage. Please check $USAGE" >&2; exit 1
  fi
}

isTheCounterValid(){
  regex='^[1-9]$|^[1-9][0-9]$|^(100)$'
  if ! [[ $1 =~ $regex ]] ; then
     echo "Error: \"-c $1\" is out of range. Please check $USAGE" >&2; exit 1
  fi
}

sendRequest(){
  echo "Sending request to: $URL [$METHOD]"
  if [[ "$METHOD" = "GET" ]]; then
    STATUS_RESPONSE=$(curl -m 2 -o /dev/null -s -w "%{http_code}\n" "$URL")
    RESPONSE_LIST+=($STATUS_RESPONSE)
  elif [[ "$METHOD" = "POST" || "$METHOD" = "PUT" ]]; then
    STATUS_RESPONSE=$(curl -X "$METHOD" -H "$CONTENT_TYPE_HEADER" -d "$BODY" \
      -o /dev/null -s -w "%{http_code}\n" "$URL")
    RESPONSE_LIST+=($STATUS_RESPONSE)
  fi
  echo "Status Response: $STATUS_RESPONSE"
}

printResult(){
  echo "
#####################
# Analyzing Results #
#####################
  "

  for response in "${!responses[@]}";
  do
    quantity=${responses[$response]}
    quantity=$(($quantity + 1))
    echo "$response - $quantity Requests; $(awk "BEGIN {x=$quantity/$COUNT; y=100; z=(x)*y; print z}")% ";
  done
  echo -e "\n\n"
}

analyzeResults(){
  declare -A responses
  for i in "${RESPONSE_LIST[@]}"; do
      case $i in
        "000") responses+=( ["000"]=$((count000++)) ) ;;
        "100") responses+=( ["100"]=$((count100++)) ) ;;
        "200") responses+=( ["200"]=$((count200++)) ) ;;
        "201") responses+=( ["201"]=$((count201++)) ) ;;
        "202") responses+=( ["202"]=$((count202++)) ) ;;
        "203") responses+=( ["203"]=$((count203++)) ) ;;
        "204") responses+=( ["204"]=$((count204++)) ) ;;
        "206") responses+=( ["206"]=$((count206++)) ) ;;
        "207") responses+=( ["207"]=$((count207++)) ) ;;
        "208") responses+=( ["208"]=$((count208++)) ) ;;
        "226") responses+=( ["226"]=$((count226++)) ) ;;
        "300") responses+=( ["300"]=$((count300++)) ) ;;
        "301") responses+=( ["301"]=$((count301++)) ) ;;
        "302") responses+=( ["302"]=$((count302++)) ) ;;
        "303") responses+=( ["303"]=$((count303++)) ) ;;
        "304") responses+=( ["304"]=$((count304++)) ) ;;
        "305") responses+=( ["305"]=$((count305++)) ) ;;
        "306") responses+=( ["306"]=$((count306++)) ) ;;
        "307") responses+=( ["307"]=$((count307++)) ) ;;
        "308") responses+=( ["308"]=$((count309++)) ) ;;
        "400") responses+=( ["400"]=$((count400++)) ) ;;
        "401") responses+=( ["401"]=$((count401++)) ) ;;
        "402") responses+=( ["402"]=$((count402++)) ) ;;
        "403") responses+=( ["403"]=$((count403++)) ) ;;
        "404") responses+=( ["404"]=$((count404++)) ) ;;
        "405") responses+=( ["405"]=$((count405++)) ) ;;
        "406") responses+=( ["406"]=$((count406++)) ) ;;
        "407") responses+=( ["407"]=$((count407++)) ) ;;
        "408") responses+=( ["408"]=$((count408++)) ) ;;
        "409") responses+=( ["409"]=$((count409++)) ) ;;
        "410") responses+=( ["410"]=$((count410++)) ) ;;
        "411") responses+=( ["411"]=$((count411++)) ) ;;
        "412") responses+=( ["412"]=$((count412++)) ) ;;
        "413") responses+=( ["413"]=$((count413++)) ) ;;
        "414") responses+=( ["414"]=$((count414++)) ) ;;
        "416") responses+=( ["416"]=$((count416++)) ) ;;
        "417") responses+=( ["417"]=$((count417++)) ) ;;
        "418") responses+=( ["418"]=$((count418++)) ) ;;
        "420") responses+=( ["420"]=$((count420++)) ) ;;
        "422") responses+=( ["422"]=$((count422++)) ) ;;
        "423") responses+=( ["423"]=$((count423++)) ) ;;
        "424") responses+=( ["424"]=$((count424++)) ) ;;
        "425") responses+=( ["425"]=$((count425++)) ) ;;
        "426") responses+=( ["426"]=$((count426++)) ) ;;
        "429") responses+=( ["429"]=$((count429++)) ) ;;
        "431") responses+=( ["431"]=$((count431++)) ) ;;
        "444") responses+=( ["444"]=$((count444++)) ) ;;
        "450") responses+=( ["450"]=$((count450++)) ) ;;
        "451") responses+=( ["451"]=$((count451++)) ) ;;
        "494") responses+=( ["494"]=$((count494++)) ) ;;
        "500") responses+=( ["500"]=$((count500++)) ) ;;
        "501") responses+=( ["501"]=$((count501++)) ) ;;
        "502") responses+=( ["502"]=$((count502++)) ) ;;
        "503") responses+=( ["503"]=$((count503++)) ) ;;
        "504") responses+=( ["504"]=$((count504++)) ) ;;
        "506") responses+=( ["506"]=$((count506++)) ) ;;
        "507") responses+=( ["507"]=$((count507++)) ) ;;
        "508") responses+=( ["508"]=$((count508++)) ) ;;
        "509") responses+=( ["509"]=$((count509++)) ) ;;
        "510") responses+=( ["510"]=$((count510++)) ) ;;
   esac
  done



   for response in "${!responses[@]}";
   do
     if (( $response > 100 || $response < 300 ))
     then
       quantity=${responses[$response]}
     fi
   done

   if [[ -n "${responses[200]}" ]]; then
       quantity=$(($quantity + 1))
     else
       quantity=0
   fi

   [ $FLAG_PRINT -eq 1 ] && printResult

  score=`awk 'BEGIN{printf('$quantity' / '$COUNT' * 100)}'`
  if (( $(echo "$score < $SUCCESS_PERCENTAGE" |bc -l) )); then
    echo "The number of requests did not reach the expected success percentage"
    echo "Expected: $SUCCESS_PERCENTAGE% Reached: $score%"
    echo "Ending with error :("
    exit 1;
  else
    echo "The number of requests has reached the expected percentage of success"
    echo "Expected: $SUCCESS_PERCENTAGE% Reached: $score%"
    echo "Ending script :)"
    exit 0;
  fi


}

execute(){
  echo -e "\n Initiating $COUNT calls with $DELAY delay between requests \n"
  for i in $(seq $COUNT); do
    echo "REQUEST #$i"
    sendRequest
    sleep "$DELAY"
    echo -e "\n"
  done

  analyzeResults
}

while getopts ":t:u:m:H:r:s:phv" opt; do
  case ${opt} in
    t) DELAY="$OPTARG"               ;;
    u) URL="$OPTARG"                 ;;
    m) METHOD="$OPTARG"              ;;
    d) DATA="$OPTARG"                ;;
    H) HEADER="$OPTARG"              ;;
    r) COUNT="$OPTARG"               ;;
    s) SUCCESS_PERCENTAGE="$OPTARG"  ;;
    p) FLAG_PRINT=1                  ;;
    h) FLAG_HELP=1                   ;;
    v) FLAG_VERSION=1                ;;
    \?) echo "Invalid option: $OPTARG. Please check $USAGE" 1>&2 && exit 1;                      ;;
    :)  echo "Invalid option: $OPTARG requires an argument. Please check $USAGE" 1>&2 && exit 1; ;;
  esac
done
shift $((OPTIND -1))

# ------------------------------- EXECUTION ----------------------------------------- #
[ $FLAG_HELP -eq 1 ] && echo "$HELP" && exit 0
[ $FLAG_VERSION -eq 1 ] && echo "$VERSION" && exit 0

isTheDelayArgumentValid $DELAY
isUrlMalformed $URL
isHttpMethodValid $METHOD
isTheCounterValid $COUNT
isSuccessPercentageValid $SUCCESS_PERCENTAGE
execute
