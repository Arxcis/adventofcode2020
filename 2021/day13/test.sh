#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 13: Transparent Origami ----------------------------------"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/*"

