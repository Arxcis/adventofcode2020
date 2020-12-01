#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 1: Report Repair ---"
$D/../../languages/python.sh $D/input.txt $D/output.txt $D/solutions/day01.py
$D/../../languages/rust.sh $D/input.txt $D/output.txt $D/solutions/day01.rs
$D/../../languages/sml.sh $D/input.txt $D/output.txt $D/solutions/day01.sml
$D/../../languages/ruby.sh  $D/input.txt $D/output.txt $D/solutions/day01.rb
echo ""
