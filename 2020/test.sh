#!/usr/bin/env bash
D=$(dirname $(realpath $0))

DAYS=$(ls -d $D/*/)


echo ""
echo "------------------------ 2020 ------------------------"

for DAY in $DAYS; do $DAY/test.sh; done
