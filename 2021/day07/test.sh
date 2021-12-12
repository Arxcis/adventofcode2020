#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "# Day 7: The Treachery of Whales ------------------------------"
$D/../../lang/python.sh "$D/solutions/stektpotet.py"  "$D/io/*"
