from functools import reduce
from sys import stdin
import math
import re

# dev tip:
# watchman-make -p 'io/*.input' 'solutions/*.py' --run "cat io/preng.input | /usr/local/opt/python@3.8/bin/python3.8 solutions/day22.preng.py"

def get_stdin():
    return [line.rstrip() for line in stdin]

def gethistory(players):
    p1 = players[0].cards[:]
    p2 = players[1].cards[:]
    return [p1, p2]

class Player:
    def __init__(self, pid, cards):
        self.pid = pid
        self.cards = cards

    def pop(self):
        return self.cards.pop(0)

    def push(self, cards):
        self.cards += cards

    def points(self):
        value = 1
        sum = 0
        for card in reversed(self.cards):
            sum += card * value
            value += 1
        return sum

    def clone(self, cnt):
        return Player(self.pid, self.cards[0:cnt])

    def __str__(self):
        return "Player %d: %s"  % (self.pid, self.cards)

    def __repr__(self):
        return self.__str__()

def readplayers(lines):
    players = []
    player = None
    for l in lines:
        if l == "":
            continue
        if "Player" in l:
            if player is not None:
                players.append(player)
            player = Player(int(l[7:-1]), [])
        else:
            player.cards.append(int(l))
    players.append(player)
    return players

def playround(players):
    table = []
    for p in players:
        play = (p, p.pop())
        table.append(play)
    table = sorted(table, key = lambda play: -play[1])
    #print("Table:", table)
    table[0][0].push([play[1] for play in table])
    return table[0][0]

def done(players):
    for p in players:
        if len(p.cards) == 0:
            return True
    return False

def winner(players):
    w = players[0]
    for p in players[1:]:
        if len(p.cards) > len(w.cards):
            w = p
    return w

def play1(players):
    isdone = False
    while not isdone:
        playround(players)
        isdone = done(players)
    print(winner(players).points())

nextgame = 0

def getnextgameid():
    global nextgame
    nextgame += 1
    return nextgame

class Game2:  # assuming 2 players now
    def __init__(self, players, level = 0):
        self.players = players
        self.history = []
        self.level = level
        self.gameid = getnextgameid()
        #print("Game", self.gameid, self.level, self.players)

    def state(self):
        return [p.cards[:] for p in self.players]

    def seenbefore(self):
        return self.state() in self.history

    def p1(self):
        return self.players[0]

    def p2(self):
        return self.players[1]

    def recurse(self, c1, c2):
        return Game2([self.p1().clone(c1), self.p2().clone(c2)], self.level + 1)

    def playround(self): # return idx of winner
        winner = -1
        if self.seenbefore():
            return 0, True
        self.history.append(self.state())
        p1 = self.p1()
        p2 = self.p2()
        c1 = p1.pop()
        c2 = p2.pop()
        if len(p1.cards) >= c1 and len(p2.cards) >= c2:
            winner = self.recurse(c1, c2).play()
        else:
            if c1 >= c2:
                winner = 0
            else:
                winner = 1
        if winner == 0:
            p1.push([c1, c2])
        elif winner == 1:
            p2.push([c2, c1])
        else:
            print("whafuck no winner??")
            exit(0)
        return winner, False

    def play(self):
        isdone = False
        winner = -1
        while not isdone:
            winner, seenbeforewin = self.playround()
            if seenbeforewin:
                return 0
            isdone = done([self.p1(), self.p2()])
        return winner

# PART 1

lines = get_stdin()
players = readplayers(lines)
play1(players)

# PART 2

game = Game2(readplayers(lines))
winner = game.play()
print(game.players[winner].points())
