#!/bin/bash
DIR=$(dirname $(realpath $0))

# Run tests
$DIR/../scripts/test-deno.sh $DIR "solutions/main.deno.ts"
$DIR/../scripts/test-go.sh   $DIR "solutions/main.go"
$DIR/../scripts/test-node.sh $DIR "solutions/main.node.mjs"
$DIR/../scripts/test-py.sh   $DIR "solutions/main.py"
