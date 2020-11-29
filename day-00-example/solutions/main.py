#!/usr/bin/env python3
#-*- coding:utf-8 -*-

import fileinput

sum_all = 0
sum_odd = 0

for line in fileinput.input():
  num = int(line)
  sum_all += num
  sum_odd += num if num % 2 != 0 else 0

# = Answer
print(str(sum_all))
print(str(sum_odd))
# ================
