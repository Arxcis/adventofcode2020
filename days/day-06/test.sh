#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "$D / --- Day 6: Custom Customs ---";
$D/../../languages/go.sh $D/input.txt $D/output.txt $D/solutions/tholok97.go
echo ""
