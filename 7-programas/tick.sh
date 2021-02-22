#!/usr/bin/env bash
#
# tick.sh - Realiza requisições http, verifica status da requisicao
#
# Site:       https://github.com/thiagomatar
# Autor:      Thiago Queiroz Matar
#
# ------------------------------------------------------------------------ #
#  Descricao do script
#
#  Exemplos:
#      $ ./script.sh -d 1
#      Neste exemplo o script será executado no modo debug nível 1.
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

  -t - Delay between requests in seconds or minutes (default=10s). Ex: 1s, 1m
  -u - Set URL (argument required)
  -m - Set HTTP method (defaut GET)
  -d - Set body of request
  -H - Set header (default Content-Type:application/json)
  -r - Set how many request
  -h - Help
  -v - Version

  Examples:
  $0 -u http://localhost:8080/account
  $0 -u http://localhost:8080/account -m POST
"
DELAY=1s
COUNT=10
METHOD="GET"
CONTENT_TYPE_HEADER="Content-Type:application/json"
RESPONSE_LIST=()
BODY=""

FLAG_HELP=0
FLAG_VERSION=0
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

sendRequest(){
  echo "Sending request to: $URL [$METHOD]"
  if [[ "$METHOD" = "GET" ]]; then
    STATUS_RESPONSE=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")
    RESPONSE_LIST+=($STATUS_RESPONSE)
  elif [[ "$METHOD" = "POST" || "$METHOD" = "PUT" ]]; then
    STATUS_RESPONSE=$(curl -X "$METHOD" -H "$CONTENT_TYPE_HEADER" -d "$BODY" \
      -o /dev/null -s -w "%{http_code}\n" "$URL")
    RESPONSE_LIST+=($STATUS_RESPONSE)
  fi
  echo "Status Response: $STATUS_RESPONSE"
}

analyzeResults(){
  for i in "${RESPONSE_LIST[@]}"; do
      case $i in
        "100") ((count100++))  ;;
        "200") ((count200++))  ;;
        "201") ((count201++))  ;;
        "202") ((count202++))  ;;
        "203") ((count203++))  ;;
        "204") ((count204++))  ;;
        "206") ((count206++))  ;;
        "207") ((count207++))  ;;
        "208") ((count208++))  ;;
        "226") ((count226++))  ;;
        "300") ((count300++))  ;;
        "301") ((count301++))  ;;
        "302") ((count302++))  ;;
        "303") ((count303++))  ;;
        "304") ((count304++))  ;;
        "305") ((count305++))  ;;
        "306") ((count306++))  ;;
        "307") ((count307++))  ;;
        "308") ((count308++))  ;;
        "400") ((count400++))  ;;
        "401") ((count401++))  ;;
        "402") ((count402++))  ;;
        "403") ((count403++))  ;;
        "404") ((count404++))  ;;
        "405") ((count405++))  ;;
        "406") ((count406++))  ;;
        "407") ((count407++))  ;;
        "408") ((count408++))  ;;
        "409") ((count409++))  ;;
        "410") ((count410++))  ;;
        "411") ((count411++))  ;;
        "412") ((count412++))  ;;
        "413") ((count413++))  ;;
        "414") ((count414++))  ;;
        "416") ((count416++))  ;;
        "417") ((count417++))  ;;
        "418") ((count418++))  ;;
        "420") ((count420++))  ;;
        "422") ((count422++))  ;;
        "423") ((count423++))  ;;
        "424") ((count424++))  ;;
        "425") ((count425++))  ;;
        "426") ((count426++))  ;;
        "429") ((count429++))  ;;
        "431") ((count431++))  ;;
        "444") ((count444++))  ;;
        "450") ((count450++))  ;;
        "451") ((count451++))  ;;
        "494") ((count494++))  ;;
        "500") ((count500++))  ;;
        "501") ((count501++))  ;;
        "502") ((count502++))  ;;
        "503") ((count503++))  ;;
        "504") ((count504++))  ;;
        "506") ((count506++))  ;;
        "507") ((count507++))  ;;
        "508") ((count508++))  ;;
        "509") ((count509++))  ;;
        "510") ((count510++))  ;;
   esac
  done
  echo "
#####################
# Analyzing Results #
#####################
  "
  count200=20
  count404=23
  count403=7

  [ -n "$count100"  ] && echo "Status 100: $(awk "BEGIN {x=$count100/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count200"  ] && echo "Status 200: $(awk "BEGIN {x=$count200/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count201"  ] && echo "Status 201: $(awk "BEGIN {x=$count201/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count202"  ] && echo "Status 202: $(awk "BEGIN {x=$count202/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count203"  ] && echo "Status 203: $(awk "BEGIN {x=$count203/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count204"  ] && echo "Status 204: $(awk "BEGIN {x=$count204/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count206"  ] && echo "Status 206: $(awk "BEGIN {x=$count206/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count207"  ] && echo "Status 207: $(awk "BEGIN {x=$count207/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count208"  ] && echo "Status 208: $(awk "BEGIN {x=$count208/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count226"  ] && echo "Status 226: $(awk "BEGIN {x=$count226/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count300"  ] && echo "Status 300: $(awk "BEGIN {x=$count300/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count301"  ] && echo "Status 301: $(awk "BEGIN {x=$count301/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count302"  ] && echo "Status 302: $(awk "BEGIN {x=$count302/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count303"  ] && echo "Status 303: $(awk "BEGIN {x=$count303/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count304"  ] && echo "Status 304: $(awk "BEGIN {x=$count304/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count305"  ] && echo "Status 305: $(awk "BEGIN {x=$count305/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count306"  ] && echo "Status 306: $(awk "BEGIN {x=$count306/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count307"  ] && echo "Status 307: $(awk "BEGIN {x=$count307/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count308"  ] && echo "Status 308: $(awk "BEGIN {x=$count308/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count400"  ] && echo "Status 400: $(awk "BEGIN {x=$count400/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count401"  ] && echo "Status 401: $(awk "BEGIN {x=$count401/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count402"  ] && echo "Status 402: $(awk "BEGIN {x=$count402/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count403"  ] && echo "Status 403: $(awk "BEGIN {x=$count403/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count404"  ] && echo "Status 404: $(awk "BEGIN {x=$count404/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count405"  ] && echo "Status 405: $(awk "BEGIN {x=$count405/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count406"  ] && echo "Status 406: $(awk "BEGIN {x=$count406/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count407"  ] && echo "Status 407: $(awk "BEGIN {x=$count407/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count408"  ] && echo "Status 408: $(awk "BEGIN {x=$count408/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count409"  ] && echo "Status 409: $(awk "BEGIN {x=$count409/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count410"  ] && echo "Status 410: $(awk "BEGIN {x=$count410/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count411"  ] && echo "Status 411: $(awk "BEGIN {x=$count411/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count412"  ] && echo "Status 412: $(awk "BEGIN {x=$count412/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count413"  ] && echo "Status 413: $(awk "BEGIN {x=$count413/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count414"  ] && echo "Status 414: $(awk "BEGIN {x=$count414/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count416"  ] && echo "Status 416: $(awk "BEGIN {x=$count416/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count417"  ] && echo "Status 417: $(awk "BEGIN {x=$count417/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count418"  ] && echo "Status 418: $(awk "BEGIN {x=$count418/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count420"  ] && echo "Status 420: $(awk "BEGIN {x=$count420/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count422"  ] && echo "Status 422: $(awk "BEGIN {x=$count422/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count423"  ] && echo "Status 423: $(awk "BEGIN {x=$count423/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count424"  ] && echo "Status 424: $(awk "BEGIN {x=$count424/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count425"  ] && echo "Status 425: $(awk "BEGIN {x=$count425/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count426"  ] && echo "Status 426: $(awk "BEGIN {x=$count426/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count429"  ] && echo "Status 429: $(awk "BEGIN {x=$count429/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count431"  ] && echo "Status 431: $(awk "BEGIN {x=$count431/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count444"  ] && echo "Status 444: $(awk "BEGIN {x=$count444/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count450"  ] && echo "Status 450: $(awk "BEGIN {x=$count450/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count451"  ] && echo "Status 451: $(awk "BEGIN {x=$count451/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count494"  ] && echo "Status 494: $(awk "BEGIN {x=$count494/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count500"  ] && echo "Status 500: $(awk "BEGIN {x=$count500/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count501"  ] && echo "Status 501: $(awk "BEGIN {x=$count501/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count502"  ] && echo "Status 502: $(awk "BEGIN {x=$count502/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count503"  ] && echo "Status 503: $(awk "BEGIN {x=$count503/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count504"  ] && echo "Status 504: $(awk "BEGIN {x=$count504/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count506"  ] && echo "Status 506: $(awk "BEGIN {x=$count506/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count507"  ] && echo "Status 507: $(awk "BEGIN {x=$count507/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count508"  ] && echo "Status 508: $(awk "BEGIN {x=$count508/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count509"  ] && echo "Status 509: $(awk "BEGIN {x=$count509/$COUNT; y=100; z=x*y; print z}")%"
  [ -n "$count510"  ] && echo "Status 510: $(awk "BEGIN {x=$count510/$COUNT; y=100; z=x*y; print z}")%"

  echo -e "\n\n"
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

while getopts ":t:u:m:H:r:hv" opt; do
  case ${opt} in
    t) DELAY="$OPTARG"  ;;
    u) URL="$OPTARG"    ;;
    m) METHOD="$OPTARG" ;;
    d) DATA="$OPTARG"   ;;
    H) HEADER="$OPTARG" ;;
    r) COUNT="$OPTARG"  ;;
    h) FLAG_HELP=1      ;;
    v) FLAG_VERSION=1   ;;
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
execute
