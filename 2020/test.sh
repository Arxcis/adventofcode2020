#!/usr/bin/env bash
D=$(dirname $(realpath $0))

DAYS=$(ls -d $D/*/)

for DAY in $DAYS; do $DAY/test.sh; done
