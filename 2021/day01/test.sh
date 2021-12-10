#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo "* day01: Sonar Sweep -----------------------------------------"
$D/../../lang/zig.sh     $D/solutions/avokado.zig  "$D/io/*"
$D/../../lang/rust.sh    $D/solutions/arxcis.rs  "$D/io/*"
$D/../../lang/python.sh  $D/solutions/arxcis.py  "$D/io/*"
$D/../../lang/python.sh  $D/solutions/stektpotet.py  "$D/io/*"
$D/../../lang/python.sh  $D/solutions/stektpotet_one-liner.py  "$D/io/*"
