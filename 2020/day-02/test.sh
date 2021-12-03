#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 2: Password Philosophy ---"
$D/../../lang/go.sh     "$D/solutions/day02.stektpotet.go"   "$D/io/*"
$D/../../lang/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../../lang/zig.sh    "$D/solutions/*.zig"  "$D/io/*"
$D/../../lang/cpp.sh    "$D/solutions/*.cpp"  "$D/io/*"
$D/../../lang/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../lang/go.sh     "$D/solutions/day02.tholok97.go"   "$D/io/*"
$D/../../lang/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../lang/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
echo ""
