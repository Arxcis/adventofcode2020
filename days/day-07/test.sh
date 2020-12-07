#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))


echo ""
echo "--- Day 7: Handy Haversacks ---"
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day07.sml
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/tholok97.go
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day07.stektpotet.py
$D/../../languages/node.sh   $D/input.txt $D/output.txt $D/solutions/day07.mjs
$D/../../languages/deno.sh   $D/input.txt $D/output.txt $D/solutions/day07.ts
echo ""
