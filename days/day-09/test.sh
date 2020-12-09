#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 9: Encoding Error ---"
$D/../../lang/deno.sh "$D/solutions/*.ts" "$D/io/*"
echo ""
