#!/usr/bin/env bash
D=$(dirname $(realpath $0))

for day in $(ls $D); do $D/$day/test.sh; done
