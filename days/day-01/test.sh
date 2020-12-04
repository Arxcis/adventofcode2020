#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 1: Report Repair ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/one-liner.py
$D/../../languages/cpp.sh    $D/input.txt $D/output.txt $D/solutions/day01.cpp
$D/../../languages/sml.sh    $D/input.txt $D/output.txt $D/solutions/day01.sml
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day01.py
$D/../../languages/rust.sh   $D/input.txt $D/output.txt $D/solutions/day01.rs
$D/../../languages/ruby.sh   $D/input.txt $D/output.txt $D/solutions/day01.rb
$D/../../languages/zig.sh    $D/input.txt $D/output.txt $D/solutions/day01.zig
echo ""
