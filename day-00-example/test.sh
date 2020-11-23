#!/bin/bash
set -e
DIR=$(dirname $(realpath $0))

#
# Run tests for day-00-example
#
$DIR/../scripts/test-deno.sh "main.deno.ts" $DIR
$DIR/../scripts/test-go.sh "main.go" $DIR
$DIR/../scripts/test-node.sh "main.node.mjs" $DIR
$DIR/../scripts/test-py.sh "main.py" $DIR
