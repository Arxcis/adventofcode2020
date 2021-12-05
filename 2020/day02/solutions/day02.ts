const passwords = [...(await Deno.readTextFile('/dev/stdin'))
  .matchAll(/(\d+)-(\d+) (\w): (\w+)/g)]
  .map(([,from, to, letter, password]) => ({
    from: parseInt(from),
    to: parseInt(to),
    letter,
    password
  }))


// --- part1 ---
const part1_passwords = passwords
  .reduce((count, {from, to, letter, password}) => {

    const letterCount = [...password]
      .reduce((letterCount, passwordLetter) => letterCount + (letter === passwordLetter ? 1:0), 0)

    return count + (from <= letterCount && letterCount <= to ? 1:0);
    }, 0)

const part2_passwords = passwords
  .reduce((count, {from, to, letter, password}) => {

    let letterCount = 0;
    letterCount += (password.charAt(from-1) === letter ? 1:0);
    letterCount += (password.charAt(to-1) === letter ? 1:0);

    return count + (letterCount === 1 ? 1:0);
  }, 0);

console.log(`${part1_passwords}`);
console.log(`${part2_passwords}`);
