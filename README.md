# adventofcode2020
Solving the 2020 edition of https://adventofcode.com/ in many languages, and test the solutions using Github CI.

## Contributing
1. Make a branch. Example: `git checkout -b jonas/day-03`
2. Write a solution, in the language of your choice. Example: `vim day-03/solutions/super-optimized.py`
3. Test your solution.

```sh
cat day-03/input | python3 day-03/solutions/super-optimized.py | diff - day-03/output
```

4. Make sure your solution is automatically tested by the Github CI, by adding a line of code to `day-03/test.sh`.
*Example line:*
```sh
$DIR/../scripts/test-py.sh $DIR "solutions/super-optimized.py"
```

5. Make a Pull Request to the `main` branch.
6. Merge when the tests pass!

**How are solutions tested?**

Every solution gets the `input`-challenge delivered to `stdin`, and every solution is expected to answer, by writing the `output`-answer to `stdout`.

```sh
#!/bin/bash
cat input | <run-solution> | diff - output
```

**Which languages are supported?**

Any langugae you can install via `sudo apt install <language>`. Add the language you want to the `Dockerfile`.


## Status
![day-00-example](https://github.com/Arxcis/adventofcode2020/workflows/day-00-example/badge.svg)

## References
- Last attempt https://github.com/Arxcis/adventofcode2018/
