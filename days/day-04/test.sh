#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo
echo "--- Day 4: Passport Processing ---"
$D/../../languages/c.sh      $D/input.txt $D/output.txt $D/solutions/day04.c
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day04.sml
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/day04.tholok97.go
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.klyve.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.preng.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.jorgen.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day04.stektpotet.py
$D/../../languages/deno.sh   $D/input.txt $D/output.txt $D/solutions/day04.ts
$D/../../languages/node.sh   $D/input.txt $D/output.txt $D/solutions/day04.mjs
$D/../../languages/ruby.sh   $D/input.txt $D/output.txt $D/solutions/day04.klyve.rb
echo
