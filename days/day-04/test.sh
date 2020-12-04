#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 4: Passport processing ---"
$D/../../languages/c.sh   $D/input.txt $D/output.txt $D/solutions/day04.c
echo ""
