if __name__ == '__main__':
    lines = [line.strip() for line in open(0).readlines()]
    ranks = {key: rank for rank, key in enumerate('([{<', start=1)}
    ranks.update({key: rank for rank, key in enumerate('>}])', start=-4)})
    brackets = {rank: bracket for bracket, rank in ranks.items()}
    corrupt_scores = {')': 3, ']': 57, '}': 1197, '>': 25137}
    completion_scores = {key: rank for rank, key in enumerate(')]}>', start=1)}

    corrupt_score = 0
    line_scoring = []
    for n, line in enumerate(lines):
        expected_closings = []
        for p, c in enumerate(line):
            if (rank := ranks[c]) > 0:
                expected_closings.append(-rank)
            else:
                if rank != (closing_rank := expected_closings.pop()):
                    corrupt_score += corrupt_scores[c]
                    expected_closings.clear()
                    break
        if expected_closings:
            s = 0
            for point in (completion_scores[brackets[rank]] for rank in expected_closings[::-1]):
                s *= 5
                s += point
            line_scoring.append(s)
    print(corrupt_score)
    print(sorted(line_scoring)[len(line_scoring)//2])
