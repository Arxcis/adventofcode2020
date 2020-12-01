#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

$D/../../scripts/test-py.sh $D/input.txt $D/output.txt $D/solutions/day01.py
