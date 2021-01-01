import fileinput
# 1015
#  201
if __name__ == '__main__':
    nums = [int(i) for i in fileinput.input()]
    mem = {v: time for time, v in enumerate(nums[:-1])}
    last = nums[-1]

    for i in range(len(nums) - 1, 2020-1):
        spoken = i - mem[last] if last in mem else 0
        mem[last] = i
        last = spoken
    print(last)
    for i in range(2020-1, 30000000-1):
        spoken = i - mem[last] if last in mem else 0
        mem[last] = i
        last = spoken
    print(last)
