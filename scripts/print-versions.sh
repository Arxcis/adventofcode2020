#!/usr/bin/env bash
set -e

echo "$ uname -a"
uname -a
echo ""

echo "$ bash --version"
bash --version
echo ""

echo "$ gcc version"
gcc --version

echo "$ go version"
go version
echo ""

echo "$ node --version"
node --version
echo ""

echo "$ python3 --version"
python3 --version
echo ""

echo "$ rustc --version"
rustc --version
echo ""
