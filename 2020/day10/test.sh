#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "--- Day 10: --- Adapter Combinations ---"
$D/../../lang/python.sh "$D/solutions/*.py"  "$D/io/*"
$D/../../lang/deno.sh   "$D/solutions/*.ts"  "$D/io/*"
$D/../../lang/sml.sh    "$D/solutions/*.sml" "$D/io/*"
