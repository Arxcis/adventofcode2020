#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))


echo ""
echo "--- Day 7: Handy Haversacks ---"

$D/../../lang/sml.sh    "$D/solutions/*.sml"  "$D/io/*"
$D/../../lang/go.sh     "$D/solutions/*.go"   "$D/io/*"
$D/../../lang/python.sh "$D/solutions/*.py"   "$D/io/*"
$D/../../lang/node.sh   "$D/solutions/*.mjs"  "$D/io/*"
$D/../../lang/deno.sh   "$D/solutions/*.ts"   "$D/io/*"

echo ""
