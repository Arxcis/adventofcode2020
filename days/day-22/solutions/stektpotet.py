import itertools
from copy import deepcopy
from sys import stdin
from collections import deque


def recursive_combat_game(decks):
    previous_decks = set()
    while len(decks[0]) > 0 and len(decks[1]) > 0:
        state = tuple(tuple(d) for d in decks)
        if state in previous_decks:
            return 0
        previous_decks.add(state)
        cards = tuple(d.popleft() for d in decks)

        if all(cards[i] <= len(decks[i]) for i in range(2)):  # both have larger decks than their picked cards' rank
            winner = recursive_combat_game(
                tuple(deque(decks[player][i] for i in range(cards[player])) for player in range(2))
            )
        else:
            winner = cards[0] < cards[1]  # is card 1 higher rank
        decks[winner].extend(cards[::1 - winner * 2])  # append cards in order; winning first, losing second
    return len(decks[1]) > 0  # using boolean value of "did player 1 win game?" is equivalent to index of winner


if __name__ == '__main__':
    starting_decks = [
        deque(map(int, a)) for p1, p2 in [tuple(stdin.read().replace('\r', '').split('\n\n'))]
        for a in (p1.split()[2:], p2.split()[2:])
    ]
    deck_size = sum(len(d) for d in starting_decks)

    # Part 1
    decks = deepcopy(starting_decks)
    while len(decks[0]) > 0 and len(decks[1]) > 0:
        cards = tuple(d.popleft() for d in decks)
        winner = cards[0] < cards[1]                # is card 1 higher rank
        decks[winner].extend(cards[::1-winner*2])   # append cards in order; winning first, losing second
    print(sum(i * c for i, c in zip(itertools.count(deck_size, -1), decks[len(decks[1]) > 0])))

    # Part 2
    decks = starting_decks
    print(sum(i * c for i, c in zip(itertools.count(deck_size, -1), decks[recursive_combat_game(decks)])))
