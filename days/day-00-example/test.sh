#!/usr/bin/env bash
set -e

DIR=$(dirname $(realpath $0))

# Run tests
$DIR/../../scripts/test-bash.sh $DIR "solutions/example.bash"
$DIR/../../scripts/test-c.sh    $DIR "solutions/example.c"
$DIR/../../scripts/test-cpp.sh  $DIR "solutions/example.cpp"
$DIR/../../scripts/test-go.sh   $DIR "solutions/example.go"
$DIR/../../scripts/test-java.sh $DIR solutions Example
$DIR/../../scripts/test-node.sh $DIR "solutions/example.node.mjs"
$DIR/../../scripts/test-php.sh  $DIR "solutions/example.php"
$DIR/../../scripts/test-py.sh   $DIR "solutions/example.py"
$DIR/../../scripts/test-rust.sh $DIR "solutions/example.rs"
