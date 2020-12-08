#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 0: Examples ---"

$D/../../languages/python.sh "$D/solutions/*.py"   "io/*"
$D/../../languages/rust.sh   "$D/solutions/*.rs"   "io/*"
$D/../../languages/go.sh     "$D/solutions/*.go"   "io/*"
$D/../../languages/c.sh      "$D/solutions/*.c"    "io/*"
$D/../../languages/cpp.sh    "$D/solutions/*.cpp"  "io/*"
$D/../../languages/sml.sh    "$D/solutions/*.sml"  "io/*"
$D/../../languages/deno.sh   "$D/solutions/*.ts"   "io/*"
$D/../../languages/node.sh   "$D/solutions/*.mjs"  "io/*"
$D/../../languages/ruby.sh   "$D/solutions/*.rb"   "io/*"

echo ""
