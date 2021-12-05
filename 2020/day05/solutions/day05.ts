const lines = [...(await Deno.readTextFile('/dev/stdin'))
  .matchAll(/[BFLR]+/g)]
  .map(([line]) => line)

let ids = lines
  .map(line => [...line]
    .reverse()
    .reduce((acc, char, i) => acc | (char === "B" || char === "R" ? (1 << i) : 0)
      , 0)
)

// --- part1 ---
const maxSeat = ids.reduce((acc, id) => Math.max(acc, id), -Infinity)

// --- part2 ---
const emptySeat = ids
  .sort((a, b) => a - b)
  .find((id, i) => i > 0 && id !== (ids[i-1] + 1))
  ?? 0

console.log(`${maxSeat}`)
console.log(`${emptySeat - 1}`) // Why -1?
