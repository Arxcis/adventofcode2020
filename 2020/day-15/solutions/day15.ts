import { whatIsTheNthSpokenNumber } from "../lib/whatIsTheNthSpokenNumber.ts"
const input = (await Deno.readTextFile("/dev/stdin"))
const lines = [...input.matchAll(/\d+/g)]

const numbers = lines
  .map(([it]) => parseInt(it))

// Part 1
{
  console.log(`${whatIsTheNthSpokenNumber(numbers, 2020)}`)
}

// Part 2
{
  console.log(`${whatIsTheNthSpokenNumber(numbers, 30000000)}`)
}
