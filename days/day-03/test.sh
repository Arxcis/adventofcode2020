#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 3: Counting trees ---"
$D/../../languages/c.sh      $D/input.txt $D/output.txt $D/solutions/day03.c
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day03.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/python_klyve.py
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day03.sml
echo ""
