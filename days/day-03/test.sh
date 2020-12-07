#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 3: Counting trees ---"
$D/../../languages/c.sh      $D/input.txt $D/output.txt $D/solutions/day03.c
$D/../../languages/zig.sh    $D/input.txt $D/output.txt $D/solutions/day03.zig
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/day03.stektpotet.go
$D/../../languages/go.sh     $D/input.txt $D/output.txt $D/solutions/day03.tholok97.go
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day03.sml
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day03.preng.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/one-liner.py
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day03.klyve.py
echo ""
