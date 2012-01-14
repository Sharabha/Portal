#!/bin/bash

PROGRAM_PATH=$1   # scieżka do programu który zostanie skompilowany
INPUT_PATH=$2     # jakie dane wejściowe mają być podane do skryptu (STDIO)
OUTPUT_PATH=$3    # czyli co ma program zwrócić (STDOUT)
TIMEOUT=$4        # po ilu sekundach przerwać test z rezultatem negatywnym
CALLBACK_URL=$5   # gdzie odesłać rezultat przeprowadzonych testów (adres URL, można coś wysłać metodą post
                  # ale to już trzeba poprawić w kodzie, na razie jest prowizorka)

if [ "$#" -ne 5 ]; then
  printf "usage: ${0} PROGRAM_PATH INPUT_PATH OUTPUT_PATH TIMEOUT CALLBACK_URL\n"
  exit
fi

#debug -> echo "${1} ${2} ${3} ${4} ${5}"

printf "Kompilacja: ${PROGRAM_PATH} "
case "$PROGRAM_PATH" in
  *.c )
    printf "(kompilator GCC)"
    gcc -std=gnu99 -Wall -W -O2 -static -DSPRAWDZACZKA -lm $PROGRAM_PATH -o $PROGRAM_PATH.compile ;;
  * )
    printf "error"
esac
printf ", "


printf "uruchomienie: "
/usr/bin/time -f "%S" timeout $TIMEOUT $PROGRAM_PATH.compile < $INPUT_PATH > "_output" 2> "_time"
printf "ok, "


_TIME=$(cat _time) # można wysłać czas wykonywania programu do serwera (modyfikując poniższe linie z curl'em, ale to chyba zbędne)

printf "sprawdzanie: "
if [[ $_TIME == *non-zero* ]]; then
  printf "result: timeout or non-zero status"
  curl -d "timeout or non-zero status" $CALLBACK_URL
else
  _DIFF=$(diff -b -B _output $OUTPUT_PATH)
  if [ $_DIFF == ""]; then
    printf "true"
    curl -d "result: true" $CALLBACK_URL
  else
    printf "false"
    curl -d "result: false" $CALLBACK_URL
  fi
fi

printf "\n"
