#!/bin/bash
set -e

# Usage:   ../test-go.sh FILENAME  DIR
# Example: ../test-go.sh main.go   /home/jonas/adventofcode2020/day-00-example

FILENAME=$1
DIR=$2

echo "$(cat $DIR/input)" | go run "$DIR/cmd/$FILENAME" | diff - "$DIR/output"
echo "$DIR / go run $FILENAME ✅"
