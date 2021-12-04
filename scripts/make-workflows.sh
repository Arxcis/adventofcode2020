#!/usr/bin/env bash

. .env

#
# Make Github workflows for all the days in the calendar
# We make one workflow for every day,instead of one job for every day,
# to enable selectively trigger when the workflow runs using the paths:
# to make sure the workflow only runs when needed.
#
for YEAR in {2020,2021}
do
  cat > "./.github/workflows/$YEAR.yaml" << WORKFLOW
name: ${YEAR}
on:
  workflow_dispatch:

  push:
    branches:
      - main
    paths:
      - '.github/workflows/${YEAR}.yaml'
      - 'lang/**'
      - 'lib/**'
      - '${YEAR}/**/test.sh'
      - '${YEAR}/**/io/**'
      - '${YEAR}/**/solutions/**'

  pull_request:
    branches:
      - main
    paths:
      - '.github/workflows/${YEAR}.yaml'
      - 'lang/**'
      - 'lib/**'
      - '${YEAR}/**/test.sh'
      - '${YEAR}/**/io/**'
      - '${YEAR}/**/solutions/**'

jobs:
WORKFLOW

  for DAY in {day-01,day-02,day-03,day-04,day-05,day-06,day-07,day-08,day-09,day-10,day-11,day-12,day-13,day-14,day-15,day-16,day-17,day-18,day-19,day-20,day-21,day-22,day-23,day-24,day-25}
  do
    cat >> "./.github/workflows/$YEAR.yaml" << WORKFLOW
 test-${YEAR}-${DAY}:
    runs-on: ubuntu-latest
    container:
      image: ${DOCKER_TAG}
    steps:
      - uses: actions/checkout@v2
      - name: running ./scripts/print-versions.sh
        run: ./scripts/print-versions.sh
      - name: running ./${YEAR}/${DAY}/test.sh
        run: ./${YEAR}/${DAY}/test.sh
WORKFLOW

  done

  cat >> "./.github/workflows/$YEAR.yaml" << WORKFLOW

WORKFLOW

done

