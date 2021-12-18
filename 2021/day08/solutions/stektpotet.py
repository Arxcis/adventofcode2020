import fileinput
from functools import reduce as r
from operator import or_, add


def infer_mapping(entry):
    #   aaaa
    #  f    b
    #  f    b
    #   gggg
    #  e    c
    #  e    c
    #   dddd
    sentry = list(sorted((set(e) for e in entry), key=len))
    digit_mapping = {1: sentry[0], 4: sentry[2], 7: sentry[1], 8: sentry[-1]}
    occurance = {c: 0 for c in 'abcdefg'}
    for word in sentry:
        for c in word:
            occurance[c] += 1

    _mapping = {'a': digit_mapping[7].difference(digit_mapping[1]).pop()}
    for k, v in occurance.items():
        if v == 4:
            _mapping['e'] = k
        elif v == 6:
            _mapping['f'] = k
        elif v == 9:
            _mapping['c'] = k

    _mapping['b'] = digit_mapping[1].difference({_mapping['c']}).pop()
    _mapping['g'] = digit_mapping[4].difference(digit_mapping[1].union({_mapping['f']})).pop()
    _mapping['d'] = digit_mapping[8].difference(digit_mapping[4].union({_mapping['a'], _mapping['e']})).pop()
    return {_mapping[k]: 1 << i for i, k in enumerate('gfedcba')}


if __name__ == '__main__':
    data = [tuple(l.split() for l in line.split('|')) for line in fileinput.input()]
    data_s = [tuple([len(word) for word in word_list] for word_list in t) for t in data]
    print(sum([(2 <= k <= 4) or k == 7 for _, out in data_s for k in out]))

    from_bin = {0b1111110: 0, 0b0110000: 1, 0b1101101: 2, 0b1111001: 3, 0b0110011: 4,
              0b1011011: 5, 0b1011111: 6, 0b1110000: 7, 0b1111111: 8, 0b1111011: 9}
    s = 0
    for mapping, digits in ((infer_mapping(s), d) for s, d in data):
        v = 0
        for i, digit in enumerate(digits):
            d = 0b0000000
            for bit in digit:
                d |= mapping[bit]
            v += from_bin[d] * (10**(3-i))
        s += v
    print(s)
