#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "2021 / --- Day 3: Binary Diagnostic ---"
$D/../../lang/rust.sh     "$D/solutions/arxcis.rs"  "$D/io/*"

