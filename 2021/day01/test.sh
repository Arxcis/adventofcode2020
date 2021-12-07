#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "--- 2021/day01: Sonar Sweep ---"
$D/../../lang/python.sh  $D/solutions/arxcis.py  "$D/io/*"
$D/../../lang/python.sh  $D/solutions/stektpotet.py  "$D/io/*"
$D/../../lang/python.sh  $D/solutions/stektpotet_one-liner.py  "$D/io/*"
