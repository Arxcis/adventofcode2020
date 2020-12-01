#!/usr/bin/env python3
#-*- coding: utf-8 -*-

import fileinput

lines = [int(line) for line in fileinput.input()]

part1 = None
part2 = None

for i in lines:
  for j in lines:
    if part1 is None and i + j == 2020:
      part1 = i*j

    for k in lines:
      if part2 is None and i + j + k == 2020:
        part2 = i*j*k

print(part1)
print(part2)
