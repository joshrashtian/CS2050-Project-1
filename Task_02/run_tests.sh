#!/bin/bash

file=$1
tests=$2

if [ $# -ne 2 ]; then 
	echo "Error: 2 arguments needed"
	exit 1
fi

temp_file=$(mktemp)

grep -v '^[[:space:]]*#' "$tests" \
    | grep -v '^[[:space:]]*$' \
    | sed -e 's/[[:space:]]*|[[:space:]]*/|/' \
          -e 's/^[[:space:]]*//' \
          -e 's/[[:space:]]*$//' > "$temp_file"

test_num=0
passed=0

for line in $(cat "$temp_file"); do
	test_num=$((test_num + 1))

	args=$(echo "$line" | awk -F'|' '{print $1}')
        expected=$(echo "$line" | awk -F'|' '{print $2}')

        actual=$("$file" $args)

        if [[ "$actual" == "$expected" ]]; then
                echo "Test $test_num: PASS"
                passed=$((passed + 1))
        else
                echo "Test $test_num: FAIL"
        fi
done

rm $temp_file

echo -e "Passed: $passed" 
