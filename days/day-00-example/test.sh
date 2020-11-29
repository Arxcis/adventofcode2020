#!/usr/bin/env bash
set -e

DIR=$(dirname $(realpath $0))

# Run tests
$DIR/../../scripts/test-bash.sh $DIR "solutions/main.bash"
$DIR/../../scripts/test-c.sh    $DIR "solutions/main.c"
$DIR/../../scripts/test-cpp.sh  $DIR "solutions/main.cpp"
$DIR/../../scripts/test-go.sh   $DIR "solutions/main.go"
$DIR/../../scripts/test-node.sh $DIR "solutions/main.node.mjs"
$DIR/../../scripts/test-py.sh   $DIR "solutions/main.py"
$DIR/../../scripts/test-rust.sh $DIR "solutions/main.rs"
