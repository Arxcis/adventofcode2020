#!/bin/bash

#
# Make Github workflows for all the days in the calendar
# We make one workflow for every day, instead of one job for every day,
# to enable selectively trigger when the workflow runs using the paths:
# to make sure the workflow only runs when needed.
#
for i in {01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
do
  DAY="day-${i}"
  cat > "./.github/workflows/${DAY}.yaml" << WORKFLOW
name: ${DAY}
on:
  push:
    paths:
      - '${DAY}/**'

jobs:
test:
    runs-on: ubuntu-latest
    container:
    image: jonasjso/adventofcode2020
    steps:
      - uses: actions/checkout@v2
      - name: make test
        run: make test DAY=${DAY}
WORKFLOW
done
