#!/bin/bash
DIR=$(dirname $(realpath $0))

# Run tests
$DIR/../scripts/test-deno.sh $DIR "cmd/main.deno.ts"
$DIR/../scripts/test-go.sh   $DIR "cmd/main.go"
$DIR/../scripts/test-node.sh $DIR "cmd/main.node.mjs"
$DIR/../scripts/test-py.sh   $DIR "cmd/main.py"
