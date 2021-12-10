#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "* day07: The Treachery of Whales -----------------------------"
#$D/../../lang/go.sh     "$D/solutions/*.go"  "$D/io/*"
#$D/../../lang/sml.sh    "$D/solutions/*.sml" "$D/io/*"
$D/../../lang/python.sh "$D/solutions/stektpotet.py"  "$D/io/*"
#$D/../../lang/deno.sh   "$D/solutions/*.ts"  "$D/io/*"


