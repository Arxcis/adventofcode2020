#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

$D/../../scripts/test-py.sh $D/input.txt $D/output.txt $D/solutions/day01.py
$D/../../scripts/test-rust.sh $D/input.txt $D/output.txt $D/solutions/day01.rs
$D/../../scripts/test-sml.sh $D/input.txt $D/output.txt $D/solutions/day01.sml
