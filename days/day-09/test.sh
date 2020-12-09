#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "--- Day 9: ????? ---"
$D/../../lang/deno.sh "$D/solutions/*.ts" "$D/io/*"
echo ""
