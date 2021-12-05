import fileinput



if __name__ == '__main__':
    instructions = [(l[0], int(l[1:])) for l in fileinput.input()]

    # =================================================== Part 1 ===================================================
    p = [0, 0]
    headings = "ENWS"
    heading = 'E'

    def north(n):
        p[1] += n
    def east(n):
        p[0] += n
    def turn_left(n):
        global heading
        heading = headings[(headings.find(heading) + n // 90) % 4]

    m = {   # this is pretty neat
        'N': lambda n: north(n),
        'S': lambda n: north(-n),
        'E': lambda n: east(n),
        'W': lambda n: east(-n),
        'L': lambda n: turn_left(n),
        'R': lambda n: turn_left(-n),
        'F': lambda n: m[heading](n)
    }

    any(m[i](n) for i, n in instructions)  # hacky way to consume the void generator
    print(abs(p[0]) + abs(p[1]))

    # =================================================== Part 2 ===================================================

    w_p = [10, 1]
    p = [0, 0]

    def move(n):
        p[0] += w_p[0] * n
        p[1] += w_p[1] * n
    def w_north(n):
        w_p[1] += n
    def w_east(n):
        w_p[0] += n
    def w_turn_left(n):
        d = [w_p[0], w_p[1]]
        if n // 90 % 4 == 1:
            w_p[0] = -d[1]
            w_p[1] = d[0]
        elif n // 90 % 4 == 2:
            w_p[0] = -d[0]
            w_p[1] = -d[1]
        elif n // 90 % 4 == 3:
            w_p[0] = d[1]
            w_p[1] = -d[0]

    m = {
        'N': lambda n: w_north(n),
        'S': lambda n: w_north(-n),
        'E': lambda n: w_east(n),
        'W': lambda n: w_east(-n),
        'L': lambda n: w_turn_left(n),
        'R': lambda n: w_turn_left(-n),
        'F': lambda n: move(n)
    }

    any(m[i](n) for i, n in instructions)  # hacky way to consume the void generator
    print(abs(p[0]) + abs(p[1]))
