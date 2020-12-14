const matches = (await Deno.readTextFile("/dev/stdin"))
  .matchAll(/\d+/g)

const joltages = [...matches]
  .map(([match]) => parseInt(match))
  .sort((a, b) => a - b)

const boundedJoltages = [0, ...joltages, joltages[joltages.length - 1] + 3]

let joltageDiffCount = { [1]: 0, [3]: 0 }

/** --- part 1 --- */
for (let i = 1; i < boundedJoltages.length; ++i) {
  const joltageDiff: 1 | 3 = boundedJoltages[i] - boundedJoltages[i - 1] as 1 | 3;
  joltageDiffCount[joltageDiff] = joltageDiffCount[joltageDiff] + 1
}
console.log(`${joltageDiffCount[1] * joltageDiffCount[3]}`)

/** --- part 2 --- */
let combinations = 1;
for (let i = 1; i < boundedJoltages.length; ++i) {

  // Compute combinations per +1-group: (4,5,6,7,8) -> 1+(0+1+2+3+4) = 10 combinations
  let plusOneGroupCombinations = 1
  for (let j = 0; boundedJoltages[i] - boundedJoltages[i-1] === 1; ++j, ++i) {
    plusOneGroupCombinations += j
  }

  // Multiply +1-groups together, to get the total combinations:
  //
  // comb(1) * comb(4,5,6,7,8) * comb(11,12,13) -> (1)*(10)*(2) = 20
  combinations *= plusOneGroupCombinations
}

console.log(`${combinations}`)
