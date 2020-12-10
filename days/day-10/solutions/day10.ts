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


let combinations = 1;

for (let i = 0; i < boundedJoltages.length;) {
  const arr = boundedJoltages;
  const it = boundedJoltages[i];

  const first = (arr[i + 1] !== undefined && arr[i + 1] - it <= 3) ? 1 : 0;
  const second = (arr[i + 2] !== undefined && arr[i + 2] - it <= 3) ? 1 : 0;
  const third = (arr[i + 3] !== undefined && arr[i + 3] - it <= 3) ? 1 : 0;

  const comb = Math.max(1, first + second + third)

  combinations *= comb;

  if (first && second && third) {
    ++i; ++i;
  } else {
    ++i;
  }
}

console.log(joltageDiffCount[1] * joltageDiffCount[3])
console.log(combinations)
