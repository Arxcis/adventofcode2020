const matches = (await Deno.readTextFile("/dev/stdin"))
  .matchAll(/\d+/g)

const numbersIncludingInitialPreamble = [...matches]
  .map(([match]) => parseInt(match))

const PREAMBLE_LENGTH = 25

const numbers = numbersIncludingInitialPreamble
  .slice(PREAMBLE_LENGTH)

/** --- part 1 --- */
const firstNotValid = numbers
  .find((num, i) => {

    const preamble = numbersIncludingInitialPreamble
      .slice(0 + i, PREAMBLE_LENGTH + i)

    const valid = preamble
      .some(a => preamble.some(b => a + b === num))

    return !valid;
  })


/** --- part2 --- */
let encryptionWeakness = null;

for (let i = 0; i < numbersIncludingInitialPreamble.length; ++i) {
  for (let j = i + 1; j < numbersIncludingInitialPreamble.length; ++j) {

    const contiguousList = numbersIncludingInitialPreamble
      .slice(i, j)

    const sum = contiguousList
      .reduce((sum, it) => sum + it, 0)

    if (sum === firstNotValid) {
      encryptionWeakness = Math.min(...contiguousList) + Math.max(...contiguousList)
      break;
    }
  }
  if (encryptionWeakness !== null) break;
}

console.log(`${firstNotValid}`)
console.log(`${encryptionWeakness}`)
