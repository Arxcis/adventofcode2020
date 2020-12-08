#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 8: Handheld Halting ---"
$D/../../languages/go.sh     "$D/solutions/*.go"  "$D/io/*"
$D/../../languages/sml.sh    "$D/solutions/*.sml" "$D/io/*"
$D/../../languages/deno.sh   "$D/solutions/*.ts"  "$D/io/*"
echo ""
