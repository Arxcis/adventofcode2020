#!/usr/bin/env bash
set -e

D=$(dirname $(realpath $0))

# Run tests
$D/../../scripts/test-bash.sh $D/input.txt $D/output.txt $D/solutions/example.bash
$D/../../scripts/test-c.sh    $D/input.txt $D/output.txt $D/solutions/example.c
$D/../../scripts/test-cpp.sh  $D/input.txt $D/output.txt $D/solutions/example.cpp
$D/../../scripts/test-go.sh   $D/input.txt $D/output.txt $D/solutions/example.go
$D/../../scripts/test-java.sh $D/input.txt $D/output.txt $D/solutions Example
$D/../../scripts/test-node.sh $D/input.txt $D/output.txt $D/solutions/example.node.mjs
$D/../../scripts/test-php.sh  $D/input.txt $D/output.txt $D/solutions/example.php
$D/../../scripts/test-py.sh   $D/input.txt $D/output.txt $D/solutions/example.py
$D/../../scripts/test-rust.sh $D/input.txt $D/output.txt $D/solutions/example.rs
