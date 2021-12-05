const numbers = (await Deno.readTextFile('/dev/stdin'))
  .split("\n")
  .slice(0, -1)
  .map((line: string) => parseInt(line))

let part1 = 0, part2 = 0;

for (const i of numbers) {
  for (const j of numbers) {
    if (!part1 && i + j === 2020) {
      part1 = i * j;
    }
    for (const k of numbers) {
      if (!part2 && i + j + k === 2020) {
        part2 = i * j * k;
      }
    }
  }
}

console.log(`${part1}`)
console.log(`${part2}`)
