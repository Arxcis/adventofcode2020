#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 2: Password Philosophy ---"
$D/../../languages/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../../languages/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../../languages/zig.sh    "$D/solutions/*.zig"  "$D/io/*"
$D/../../languages/cpp.sh    "$D/solutions/*.cpp"  "$D/io/*"
$D/../../languages/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../languages/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../languages/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
echo ""
