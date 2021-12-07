#!/usr/bin/env bash

. .env

if [ -z "$YEAR" ]
then
  echo "\$YEAR="" is empty. Example usage: ./scripts/make-workflows.sh YEAR=2021"
  exit 1
fi

cat > "./.github/workflows/$YEAR.yaml" << WORKFLOW_YAML
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
WORKFLOW_YAML

for DAY in {day01,day02,day03,day04,day05,day06,day07,day08,day09,day10,day11,day12,day13,day14,day15,day16,day17,day18,day19,day20,day21,day22,day23,day24,day25}
do
  cat >> "./.github/workflows/$YEAR.yaml" << WORKFLOW_YAML
  ${DAY}:
    runs-on: ubuntu-latest
    container:
      image: ${DOCKER_TAG}
    steps:
      - uses: actions/checkout@v2
      - name: running ./scripts/print-versions.sh
        run: ./scripts/print-versions.sh
      - name: running ./${YEAR}/${DAY}/test.sh
        run: ./${YEAR}/${DAY}/test.sh

WORKFLOW_YAML
done
