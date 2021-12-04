#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day: Examples ---"

$D/../lang/rust.sh   "$D/solutions/*.rs"   "$D/io/*"
$D/../lang/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../lang/c.sh      "$D/solutions/*.c"    "$D/io/*"
$D/../lang/cpp.sh    "$D/solutions/*.cpp"  "$D/io/*"
$D/../lang/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../lang/bash.sh   "$D/solutions/*.bash" "$D/io/*"
$D/../lang/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../lang/deno.sh   "$D/solutions/*.ts"   "$D/io/*"
$D/../lang/node.sh   "$D/solutions/*.mjs"  "$D/io/*"
$D/../lang/ruby.sh   "$D/solutions/*.rb"   "$D/io/*"
$D/../lang/php.sh    "$D/solutions/*.php"  "$D/io/*"

echo ""
