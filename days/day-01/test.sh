#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

$D/../../languages/py.sh $D/input.txt $D/output.txt $D/solutions/day01.py
$D/../../languages/rust.sh $D/input.txt $D/output.txt $D/solutions/day01.rs
$D/../../languages/sml.sh $D/input.txt $D/output.txt $D/solutions/day01.sml
