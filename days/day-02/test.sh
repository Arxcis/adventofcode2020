#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 2: ? ---"
$D/../../languages/c.sh $D/input.txt $D/output.txt $D/solutions/day02.c
echo ""
