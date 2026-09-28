#!/bin/bash

if [[ $# -ne 3 ]]; then
	echo "Usage: $0 <arg1> <arg2> <arg3>"
	exit 1
fi

file=$1
input=$2
output=$3

if [[ "$file" != *.c ]]; then
	echo "Argument 1 must be a file"
	exit 1;
fi

gcc -o prog "$file"
newOutput=$(./prog "$input")

if [[ "$newOutput" -eq "$output" ]]; then
	echo "PASS"
else
	echo "FAIL"
fi
