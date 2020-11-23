#!/bin/bash
DIR=$(dirname $(realpath $0))

# Run tests
$DIR/../scripts/test-deno.sh $DIR "solution/main.deno.ts"
$DIR/../scripts/test-go.sh   $DIR "solution/main.go"
$DIR/../scripts/test-node.sh $DIR "solution/main.node.mjs"
$DIR/../scripts/test-py.sh   $DIR "solution/main.py"
