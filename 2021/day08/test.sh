#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 8: Seven Segment Search ---------------------------------"
$D/../../lang/python.sh "$D/solutions/stektpotet.py"  "$D/io/*"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/*"
