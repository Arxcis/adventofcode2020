#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 3: Counting trees ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day03.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/python_bjarte.py
echo ""
