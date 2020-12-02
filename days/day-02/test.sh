#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 2: Password Philosophy ---"
$D/../../languages/c.sh   $D/input.txt $D/output.txt $D/solutions/day02.c
$D/../../languages/sml.sh $D/input.txt $D/output.txt $D/solutions/day02.sml
echo ""
