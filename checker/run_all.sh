#!/bin/bash

SOURCE_DIR=./source/*.c                     # podać scieżke do źródeł
INPUT_DIR=./input/*.txt                    # podać ścieżkę do danych wejściowych, które zostaną wysłane do programu na STDIO
TIMEOUT=5                                   # kiedy przerwać wykonywanie programu

while :
do
  date
  for program in $SOURCE_DIR
  do
    program_id=${program//[!0-9]/}
    for t in $INPUT_DIR
    do
      test_id=${t//[!0-9]/}
      if [ ! -f ./result/$program_id-$test_id.txt ]; then
        ./run.sh $program_id $test_id $TIMEOUT
      fi
    done
  done
  sleep 5
done
