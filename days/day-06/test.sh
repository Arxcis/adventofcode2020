#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 6: Custom customs ---"
$D/../../languages/c.sh      $D/input.txt $D/output.txt $D/solutions/day06.c
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/day06.stektpotet.go
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/tholok97.go
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/one-liner.stektpotet.py
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day06.sml
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day06.stektpotet.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day06.preng.py
$D/../../languages/deno.sh   $D/input.txt $D/output.txt $D/solutions/day06.ts
$D/../../languages/node.sh   $D/input.txt $D/output.txt $D/solutions/day06.mjs
echo ""
