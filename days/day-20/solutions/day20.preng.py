from functools import reduce
from sys import stdin
import math
import re

# dev tip:
# watchman-make -p 'io/*.input' 'solutions/*.py' --run "cat io/preng.input | /usr/local/opt/python@3.8/bin/python3.8 solutions/day20.preng.py"

def get_stdin():
    return [line.rstrip() for line in stdin]

deltas = {0: (0,-1), 1:(1,0), 2:(0,1), 3:(-1,0)} # up, right, down, left

def fliprows(rows):
    return rows[::-1]

def flipcolumns(rows):
    result = []
    for row in rows:
        result.append(row[::-1])
    return result

def rotaterows(rows): # counter clockwise, quadratic
    result = []
    for i in reversed(range(len(rows))):
        result.append("".join([row[i] for row in rows]))
    return result

class Tile:
    def __init__(self, tileid, rows):
        self.tileid = tileid
        self.rows = rows
        self.size = len(rows)
        self.max = self.size - 1
        self.fixed = False # rotated/flipped to match other tiles?
        self.pos = None # (x,y) on board
        self.edges = ["" for i in range(4)]
        self.makeedges()

    def makeedges(self):
        self.edges[0] = self.rows[0]
        self.edges[1] = "".join([row[self.max] for row in self.rows])
        self.edges[2] = self.rows[self.max]
        self.edges[3] = "".join([row[0] for row in self.rows])

    def fix(self, rotations, reverse, relpos):
        if self.fixed:
            print("WARN refix", self.tileid)
            return
        for i in range(rotations):
            self.rows = rotaterows(self.rows)
        if relpos[0] != 0:
            rotationreverses = rotations in [1, 2]
            doreverse = (rotationreverses and not reverse) or (reverse and not rotationreverses)
            if doreverse:
                self.rows = fliprows(self.rows)
        elif relpos[1] != 0:
            rotationreverses = rotations in [2, 3]
            doreverse = (rotationreverses and not reverse) or (reverse and not rotationreverses)
            if doreverse:
                self.rows = flipcolumns(self.rows)
        self.makeedges()
        self.fixed = True

    def setneighbour(self, other, relpos):
        if self.pos is None:
            print("WARNING setneighbour before setting myself", self.tileid, other.tileid)
            return
        otherpos = (self.pos[0]+relpos[0], self.pos[1]+relpos[1])
        if other.pos is not None and other.pos != otherpos:
            print("attempted move of", other.tileid, "from", other.pos, "to", otherpos, "by", self.tileid)
            return
        other.pos = otherpos

    # return (dx, dy) relative position of other, or None
    def match(self, other):
        for i in range(4):
            relpos = deltas[i]
            for j in range(4):
                matching = False
                flipped = False
                if self.edges[i] == other.edges[j]:
                    matching = True
                elif self.edges[i] == other.edges[j][::-1]:
                    matching = True
                    flipped = True
                if matching:
                    rotations = (j - i + 2) % 4
                    other.fix(rotations, flipped, relpos)
                    self.setneighbour(other, relpos)
                    return relpos
        return None

    def __str__(self):
        return "%d" % (self.tileid)

    def __repr__(self):
        return self.__str__()

    def pretty(self):
        for row in self.rows:
            print(row)
        print()

class Board:
    def __init__(self, lines):
        self.tiles = self.readtiles(lines)

    def readtiles(self, lines):
        tiles = []
        pos = 0
        while pos < len(lines):
            l = lines[pos]
            if l == "":
                pos += 1
            else:
                tileid = int(re.findall("\d+", l)[0])
                pos += 1
                l = lines[pos]
                tilesize = len(l)
                tilerows = []
                for j in range(tilesize):
                    tilerows.append(lines[pos+j])
                pos += tilesize
                tiles.append(Tile(tileid, tilerows))
                tileid = None
        return tiles

    def matchalltiles(self):
        first = self.tiles[0]
        first.pos = (0,0) # gotta start
        first.rows = fliprows(first.rows) # match aoc printout
        first.makeedges()
        matchedtiles = [first]
        unmatched = list(self.tiles[1:])
        while len(unmatched) > 0:
            kidx = 0
            while kidx < len(matchedtiles):
                known = matchedtiles[kidx]
                for unknown in unmatched:
                    res = known.match(unknown)
                    if res is not None:
                        matchedtiles.append(unknown)
                        unmatched.remove(unknown)
                        break
                kidx += 1

    def bounds(self):
        bbox = [9999, 9999, -9999, -9999]
        for t in self.tiles:
            if t.pos is None:
                print("bounds called before positioning tiles")
                break
            x = t.pos[0]
            y = t.pos[1]
            if x < bbox[0]:
                bbox[0] = x
            if x > bbox[2]:
                bbox[2] = x
            if y < bbox[1]:
                bbox[1] = y
            if y > bbox[3]:
                bbox[3] = y
        return bbox

    def corners(self):
        bbox = self.bounds()
        poslist = [(bbox[0],bbox[1]), (bbox[0],bbox[3]), (bbox[2],bbox[1]), (bbox[2],bbox[3])]
        return [t.tileid for t in self.tiles if t.pos in poslist]

    def makearray(self):
        bbox = self.bounds()
        a = [["...." for x in range(bbox[0], bbox[2]+1)] for y in range(bbox[1], bbox[3]+1)]
        for t in self.tiles:
            x = t.pos[0] - bbox[0]
            y = t.pos[1] - bbox[1]
            a[y][x] = t
        return a

    def getimage(self): # without borders
        a = self.makearray()
        tilecnt = len(a)
        tilesize = a[0][0].size
        innersize = tilesize - 2
        image = [["." for c in range(tilecnt * (tilesize - 2))] for r in range(tilecnt * (tilesize - 2))]
        for tilerow in range(tilecnt):
            for tilecol in range(tilecnt):
                t = a[tilerow][tilecol]
                for y in range(tilesize-2):
                    for x in range(tilesize-2):
                        image[tilerow*innersize + y][tilecol*innersize + x] = t.rows[y+1][x+1]
        return image

    def printarray(self):
        a = self.makearray()
        for row in a:
            print(" ".join(["%s" % (item) for item in row]))

    def checkvalid(self):
        a = self.makearray()
        for y in range(len(a)-1):
            for x in range(len(a)-1):
                this = a[y][x]
                right = a[y][x+1]
                if this != "...." and right != "....":
                    thiscol = "".join([row[this.max] for row in this.rows])
                    rightcol = "".join([row[0] for row in right.rows])
                    if thiscol != rightcol:
                        print("CHECK mismatch for", this.tileid, "at", x, y, "against right", right.tileid, thiscol, rightcol)
                        this.pretty()
                        right.pretty()
                under = a[y+1][x]
                if this != "...." and under != "....":
                    thisrow = this.rows[this.max]
                    underrow = under.rows[0]
                    if thisrow != underrow:
                        print("CHECK mismatch for", this.tileid, "at", x, y, "against under", under.tileid, thisrow, underrow)
                        this.pretty()
                        under.pretty()

def copyimage(image):
    return [list(row) for row in image]

def alreadyhit(hits, dy, dx, y, x):
    for hit in hits:
        if y >= hit[0] and y <= hit[0]+dy and x >= hit[1] and x <= hit[1]+dx:
            return True
    return False

def maskimage(image, mask):
    target = copyimage(image)
    imagesize = len(image)
    maskdy = len(mask)
    maskdx = len(mask[0])
    hits = []
    for y in range(imagesize - maskdy):
        for x in range(imagesize - maskdx):
            match = True
            for dy in range(maskdy):
                if not match:
                    break
                for dx in range(maskdx):
                    maskchar = mask[dy][dx]
                    if maskchar == "#" and image[y+dy][x+dx] != "#":
                        match = False
                        break
            if match:
                if not alreadyhit(hits, maskdy, maskdx, y+dy, x+dx):
                    hits.append([y, x])
                    for dy in range(maskdy):
                        for dx in range(maskdx):
                            if mask[dy][dx] == "#":
                                target[y+dy][x+dx] = "."
    return len(hits), sum([sum([1 for c in row if c == "#"]) for row in target])

def maskpermutations(image, mask):
    for i in range(4):
        image = rotaterows(image)
        hits, remain = maskimage(image, mask)
        if hits > 0:
            return hits, remain
        hits, remain = maskimage(flipcolumns(copyimage(image)), mask)
        if hits > 0:
            return hits, remain
    return 0, remain


# PART 1

lines = get_stdin()
board = Board(lines)
board.matchalltiles()
board.checkvalid()
cornertiles = board.corners()
print(math.prod(cornertiles))

# PART 2

monster = [
"                  # ",
"#    ##    ##    ###",
" #  #  #  #  #  #   ",
]

image = board.getimage()
hits, remain = maskpermutations(image, monster)
print(remain)
