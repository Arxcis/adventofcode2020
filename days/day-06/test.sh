#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname $(realpath $0))

echo ""
echo "--- Day 6: Custom customs ---"
$DIR/../../languages/python.sh $DIR/input.txt $DIR/output.txt $DIR/solutions/day06.preng.py
$DIR/../../languages/go.sh     $DIR/input.txt $DIR/output.txt $DIR/solutions/tholok97.go
echo ""
