#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 15: --- Rambunctious Recitation ---"
$D/../../lang/deno.sh   "$D/solutions/day15.ts"  "$D/io/*"
$D/../../lang/sml.sh    "$D/solutions/day15.sml" "$D/io/*"
$D/../../lang/python.sh "$D/solutions/stektpotet.py"  "$D/io/*"

# Disabled because too slow
# $D/../../lang/python.sh "$D/solutions/day15.preng.py"  "$D/io/*"
echo ""

