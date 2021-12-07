#!/usr/bin/env bash
set -euo pipefail

echo "$ uname -a"
uname -a
echo ""

echo "$ bash --version"
bash --version
echo ""

echo "$ deno --version"
deno --version
echo ""

echo "$ gcc version"
gcc --version

echo "$ go version"
go version
echo ""

echo "$ node --version"
node --version
echo ""

echo "$ php --version"
php --version
echo ""

echo '$ polyml -v'
poly -v
echo ""

echo "$ python3 --version"
python3 --version
echo ""

echo "$ rustc --version"
rustc --version
echo ""

echo "$ ruby --version"
ruby --version
echo ""

echo "$ zig version"
zig version
echo ""
