#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 5: Boarding pass ---"
$D/../../lang/go.sh     "$D/solutions/day05.stektpotet.go"   "$D/io/*"
$D/../../lang/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../../lang/zig.sh    "$D/solutions/*.zig"  "$D/io/*"
$D/../../lang/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../lang/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../lang/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
$D/../../lang/go.sh     "$D/solutions/tholok97.go" "$D/io/*" # fails
echo ""
