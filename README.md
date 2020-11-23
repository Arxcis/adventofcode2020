# adventofcode2020
Solving the 2020 edition of https://adventofcode.com/ in many languages, and test the solutions using Github CI.

## Contributing
1. Make a branch. Example: `git checkout -b jonas/day-03`
2. Write a program, in the language of your choice. Example: `vim ./day-03/cmd/super-optimized.py`
3. Test your program.

```sh
cat ./input | python3 ./cmd/super-optimized.py | diff - ./output
```

4. Make sure your program is automatically tested by the Github CI, by adding a line of code to `./day-03/test.sh`. 
*Example line:*
```sh
$DIR/../scripts/test-py.sh $DIR "./cmd/super-optimized.py"
```

5. Make a Pull Request to the `main` branch.
6. Get merged!

**How are programs tested?**

Every program gets the `input`-challenge delivered to `stdin`, and every program is expected to respond by writing the `output` - the answer to the `input`-challenge - to `stdout`.

```sh
#!/bin/bash
cat ./input | <run-program> | diff - ./output
```

**The CI does not support my favourite language. What do I do?**

If we don't support the language you want to write in, don't worry. Make an issue on `Github`, and we will add it.

## Status
![day-00-example](https://github.com/Arxcis/adventofcode2020/workflows/day-00-example/badge.svg)

## References
- Last attempt https://github.com/Arxcis/adventofcode2018/
