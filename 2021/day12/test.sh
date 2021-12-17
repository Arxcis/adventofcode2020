#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 12: Passage Pathing -------------------------------------"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/arxcis*"
