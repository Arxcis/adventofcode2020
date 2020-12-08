#!/usr/bin/env bash
set -euo pipefail

D=$(dirname $(realpath $0))

echo ""
echo "--- Day 0: Examples ---"
$D/../../languages/rust.sh   $D/io/alice.* $D/solutions/example.rs
$D/../../languages/go.sh     $D/io/alice.* $D/solutions/example.go
$D/../../languages/c.sh      $D/io/alice.* $D/solutions/example.c
$D/../../languages/cpp.sh    $D/io/alice.* $D/solutions/example.cpp
$D/../../languages/sml.sh    $D/io/alice.* $D/solutions/example.sml
$D/../../languages/bash.sh   $D/io/alice.* $D/solutions/example.bash
$D/../../languages/php.sh    $D/io/alice.* $D/solutions/example.php
$D/../../languages/python.sh "$D/solutions/*.py" "$D/io/*"
$D/../../languages/deno.sh   $D/io/alice.* $D/solutions/example.ts
$D/../../languages/node.sh   $D/io/alice.* $D/solutions/example.mjs
$D/../../languages/ruby.sh   $D/io/alice.* $D/solutions/example.rb
$D/../../languages/java.sh   $D/io/alice.* $D/solutions Example
echo ""
