#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo
echo "--- Day 4: Passport Processing ---"
$D/../../languages/c.sh   $D/input.txt $D/output.txt $D/solutions/day04.c
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/python_klyve.py
$D/../../languages/ruby.sh   $D/input.txt $D/output.txt $D/solutions/ruby_klyve.rb
echo
