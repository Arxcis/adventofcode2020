import { whatIsTheNthNumberSpoken } from "../../../lib/whatIsTheNthNumberSpoken.ts"
const input = (await Deno.readTextFile("/dev/stdin"))
const lines = [...input.matchAll(/\d+/g)]

const numbers = lines
  .map(([it]) => parseInt(it))

// Part 1
{
  console.log(whatIsTheNthNumberSpoken(numbers, 2020))
}

// Part 2
{
  console.log(whatIsTheNthNumberSpoken(numbers, 30000000))
}
