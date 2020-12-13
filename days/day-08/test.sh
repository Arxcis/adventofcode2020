#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 8: Handheld Halting ---"
$D/../../lang/go.sh       "$D/solutions/*.go"  "$D/io/*"
$D/../../lang/sml.sh      "$D/solutions/*.sml" "$D/io/*"
$D/../../lang/python.sh   "$D/solutions/day08.stektpotet.py"  "$D/io/*"
$D/../../lang/deno.sh     "$D/solutions/*.ts"  "$D/io/*"
$D/../../lang/python.sh   "$D/solutions/day08.preng.py"  "$D/io/*"
echo ""
