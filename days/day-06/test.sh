#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname $(realpath $0))

echo ""
echo "--- Day 6: Custom customs ---"
$DIR/../../languages/sml.sh    $DIR/input.txt $DIR/output.txt $DIR/solutions/day06.sml
$DIR/../../languages/python.sh $DIR/input.txt $DIR/output.txt $DIR/solutions/day06.preng.py
echo ""
