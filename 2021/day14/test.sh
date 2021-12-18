#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 14: Extended Polymerization -----------------------------"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/example*"

