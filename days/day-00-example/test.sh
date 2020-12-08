#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 0: Examples ---"

$D/../../languages/rust.sh   "$D/solutions/*.rs"   "$D/io/*"
$D/../../languages/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../../languages/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../../languages/cpp.sh    "$D/solutions/*.cpp"  "$D/io/*"
$D/../../languages/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../languages/bash.sh   "$D/solutions/*.bash" "$D/io/*"
$D/../../languages/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../languages/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
$D/../../languages/node.sh   "$D/solutions/*.mjs"  "$D/io/*"
$D/../../languages/ruby.sh   "$D/solutions/*.rb"   "$D/io/*"
$D/../../languages/php.sh    "$D/solutions/*.php"  "$D/io/*"

echo ""
