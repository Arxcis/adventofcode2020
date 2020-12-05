#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 5: Boarding pass ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/preng.py
echo ""
