#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 10: Adapter Array ---"
$D/../../lang/python.sh "$D/solutions/*.py"  "$D/io/*"
echo ""
