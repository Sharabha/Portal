#!/bin/bash

PROGRAM_ID=$1
TEST_ID=$2
TIMEOUT=$3

PROGRAM_PATH=./source/$PROGRAM_ID.c
INPUT_PATH=./input/$TEST_ID.txt
OUTPUT_PATH=./output/$TEST_ID.txt

#echo "${1} ${2} ${3} ${4} ${5}"

if [ "$#" -ne 3 ]; then
  printf "usage: ${0} PROGRAM_ID TEST_ID TIMEOUT\n"
  exit
fi


printf "Kompilacja: ${PROGRAM_PATH} "
printf "(kompilator GCC)"
gcc -std=c99 -Wall -W -O2 -static -DSPRAWDZACZKA -lm $PROGRAM_PATH -o $PROGRAM_PATH.compile
printf ", "


printf "uruchomienie: "
/usr/bin/time -f "%S" timeout $TIMEOUT $PROGRAM_PATH.compile < $INPUT_PATH > "_output" 2> "_time"
printf "ok, "


_TIME=$(cat _time) 
CALLBACK_FILE=result/$PROGRAM_ID-$TEST_ID.txt
printf "sprawdzanie: "
if [[ $_TIME == *non-zero* ]]; then
  printf "result: timeout or non-zero status"
  echo "0" > $CALLBACK_FILE
else
  _DIFF=$(diff -b -B _output $OUTPUT_PATH)
  if [ $_DIFF == ""]; then
    printf "true"
    echo "1" > $CALLBACK_FILE
  else
    printf "false"
    echo "0" > $CALLBACK_FILE
  fi
fi

printf "\n"
