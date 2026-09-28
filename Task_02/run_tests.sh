#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <program> <test_file>"
    exit 1
fi

program="$1"
test_file="$2"

if [ ! -x "$program" ]; then
    echo "Error: $program does not exist or is not executable."
    exit 1
fi

if [ ! -f "$test_file" ]; then
    echo "Error: $test_file does not exist."
    exit 1
fi

test_number=0
passed=0
failed=0

total_tests=$(grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$test_file" | awk 'END {print NR}')

grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$test_file" |
while read -r line; do
    argument=$(echo "$line" | awk -F '|' '{print $1}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    expected=$(echo "$line" | awk -F '|' '{print $2}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    actual=$("$program" "$argument")

    test_number=$((test_number + 1))

    if [ "$expected" = "$actual" ]; then
        echo "Test $test_number: PASS"
        passed=$((passed + 1))
    else
        echo "Test $test_number: FAIL"
        failed=$((failed + 1))
    fi

    if [ "$test_number" -eq "$total_tests" ]; then
        echo "Passed: $passed"
    fi
done
