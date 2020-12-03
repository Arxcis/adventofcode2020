#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import fileinput

valid_count, valid_xor = 0, 0
for line in fileinput.input():
    min_max, char, test = line.split(' ')
    lim1, lim2, char = *map(int, min_max.split('-')), char[0]
    if lim1 <= test.count(char) <= lim2:
        valid_count += 1
    if (test[lim1 - 1] == char) + (test[lim2 - 1] == char) == 1:
        valid_xor += 1
        
print(valid_count)
print(valid_xor)
