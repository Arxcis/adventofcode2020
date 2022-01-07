if __name__ == '__main__':
    data = [[int(c) for c in l.strip()] for l in open(0).readlines()]
    width, height = len(data[0]), len(data)
    r = []
    lps = []
    for y, row in enumerate(data):
        for x, col in enumerate(row):
            lp = True
            neighbours = []
            if x - 1 >= 0:
                neighbours.append((x - 1, y))
            if x + 1 < width:
                neighbours.append((x + 1, y))
            if y - 1 >= 0:
                neighbours.append((x, y - 1))
            if y + 1 < height:
                neighbours.append((x, y + 1))
            for xn, yn in neighbours:
                if data[yn][xn] <= col:
                    lp = False
                    break
            if lp:
                lps.append((x, y))
                r.append(col + 1)
    print(sum(r))
    basins = [0] * len(lps)

    for i, lp in enumerate(lps):
        open_set = {lp}
        closed_set = set()
        while open_set:
            closed_set.add(p := open_set.pop())
            x, y = p
            if data[y][x] != 9:
                basins[i] += 1
            if (q := (x - 1, y)) not in closed_set and q not in open_set and x - 1 >= 0 and data[q[1]][q[0]] != 9:
                open_set.add(q)
            if (q := (x + 1, y)) not in closed_set and q not in open_set and x + 1 < width and data[q[1]][q[0]] != 9:
                open_set.add(q)
            if (q := (x, y - 1)) not in closed_set and q not in open_set and y - 1 >= 0 and data[q[1]][q[0]] != 9:
                open_set.add(q)
            if (q := (x, y + 1)) not in closed_set and q not in open_set and y + 1 < height and data[q[1]][q[0]] != 9:
                open_set.add(q)
    top_3_basins = sorted(basins, reverse=True)[:3]
    print(top_3_basins[0] * top_3_basins[1] * top_3_basins[2])

    # TODO: Make sets around lps, and traverse through opening neighbours if not 9
