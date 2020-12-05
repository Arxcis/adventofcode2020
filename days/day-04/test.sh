#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo
echo "--- Day 4: Passport Processing ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.preng.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.jorgen.py
echo
