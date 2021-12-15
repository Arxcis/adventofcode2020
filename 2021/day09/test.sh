#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 9: Smoke Basin ------------------------------------------"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/*"
