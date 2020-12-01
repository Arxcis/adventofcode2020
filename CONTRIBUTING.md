# Contributing
1. Pop a can of beer :beer: (or whatever is your favourite :popcorn: :lollipop: :champagne: :milk_glass: :wine_glass: :tropical_drink: :chocolate_bar:
2. Make a branch. Example: `git checkout -b jonas/day-03`
3. Write a solution, in the language of your choice. Example: `vim day-03/solutions/super-optimized.py`
4. Test your solution.

```sh
cat day-03/input.txt | python3 day-03/solutions/super-optimized.py | diff - day-03/output.txt
```

5. Make a Pull Request to the `main` branch.
6. Merge when the tests pass!
7. Remember to have fun :tada:

## How are solutions tested?

Every solution gets the `input.txt`-file delivered to `stdin` using `cat`, and whatever is written to `stdout` is compared for equality against `output.txt` using `diff`. This is identical for every language.

```sh
#!/usr/bin/env bash
cat input.txt | <solution-in-any-language> | diff - output.txt
```
See [day-00-example/solutions/](https://github.com/Arxcis/adventofcode2020/tree/main/days/day-00-example/solutions), for examples on how to read from `stdin` and how to write to `stdout` in different languages.
