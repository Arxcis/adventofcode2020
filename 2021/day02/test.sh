#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "* day02: Dive! -----------------------------------------------"
$D/../../lang/rust.sh   "$D/solutions/arxcis.rs"  "$D/io/*"
$D/../../lang/zig.sh   "$D/solutions/avokado.zig"  "$D/io/*"
