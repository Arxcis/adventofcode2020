#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 4: Passport processing ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.jorgen.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.preng.py
echo ""
