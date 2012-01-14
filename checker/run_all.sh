#!/bin/bash

SOURCE_DIR=./source/*.c                     # podać scieżke do źródeł
INPUT_DIR=./input                           # podać ścieżkę do danych wejściowych, które zostaną wysłane do programu na STDIO
OUTPUT_DIR=./output                         # podać ścieżkę do danych wyjściowych, które powinny zostać zwrócone przez program na STDOUT
TIMEOUT=5                                   # kiedy przerwać wykonywanie programu
CALLBACK="http://api.forwardsms.org/1.json" # pod jaki adres zwrócić rezultat testów (co jest zwracane, należy sprawdzić w pliku run.sh)

while :
do
  for program in $SOURCE_DIR
  do
    if [ ! -f $program.compile ]; then
      ./run.sh $program $INPUT_DIR/0.txt $OUTPUT_DIR/0.txt $TIMEOUT $CALLBACK
    fi
  done
  sleep 1
done
