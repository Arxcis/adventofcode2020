#!/bin/bash

for i in {01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24}
do
    cat > "./.github/workflows/day-$i.yaml" << WORKFLOW
name: day-${i}
on:
push:
    paths:
    - 'day-${i}/**'

jobs:
test:
    runs-on: ubuntu-latest
    container:
    image: jonasjso/adventofcode2020
    steps:
    - uses: actions/checkout@v2
    - name: Print versions
        run: ./scripts/print-versions.sh
    - name: Run test
        run: ./day-${i}/test.sh
WORKFLOW
done
