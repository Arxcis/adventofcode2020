#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "--- Day 10: --- Adapter Combinations ---"
$D/../../lang/sml.sh    "$D/solutions/*.sml" "$D/io/*"
$D/../../lang/python.sh "$D/solutions/*.py"  "$D/io/*"

echo ""

