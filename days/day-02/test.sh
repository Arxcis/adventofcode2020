#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 2: Password Philosophy ---"
$D/../../languages/c.sh       $D/input.txt $D/output.txt $D/solutions/day02.c
$D/../../languages/go.sh      $D/input.txt $D/output.txt $D/solutions/day02.stektpotet.go
$D/../../languages/cpp.sh     $D/input.txt $D/output.txt $D/solutions/day02.cpp
$D/../../languages/sml.sh     $D/input.txt $D/output.txt $D/solutions/day02.sml
$D/../../languages/go.sh      $D/input.txt $D/output.txt $D/solutions/day02.tholok97.go
$D/../../languages/python.sh  $D/input.txt $D/output.txt $D/solutions/day02.py
echo ""
