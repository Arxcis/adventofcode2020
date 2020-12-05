import { readLines } from "https://deno.land/std@0.79.0/io/bufio.ts";

let sum_all = 0;
let sum_odd = 0;

for await (const line of readLines(Deno.stdin)) {
  const num = parseInt(line);
  if (isNaN(num)) continue;
  sum_all += num;
  sum_odd += num % 2 == 1 ? num : 0;
}

console.log(`${sum_all}`);
console.log(`${sum_odd}`);
