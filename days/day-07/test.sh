#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))


echo ""
echo "--- Day 7: Handy Haversacks ---"

$D/../../languages/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../languages/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../../languages/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../languages/node.sh   "$D/solutions/*.mjs"  "$D/io/*"
$D/../../languages/deno.sh   "$D/solutions/*.ts"   "$D/io/*"

echo ""
