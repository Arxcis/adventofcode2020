#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "--- Day 6: Custom customs ---"
$D/../../lang/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../../lang/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../../lang/zig.sh    "$D/solutions/*.zig"  "$D/io/*"
$D/../../lang/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../lang/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../lang/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
$D/../../lang/node.sh   "$D/solutions/*.mjs"  "$D/io/*"
