import { readLines } from "https://deno.land/std@0.78.0/io/bufio.ts";

let sumAll = 0;
let sumOdd = 0;
for await (const line of readLines(Deno.stdin)) {
  if (line === "") continue;

  const num = parseInt(line);
  sumAll += num;
  sumOdd += num % 2 === 0 ? 0 : num;
}

// = Answer
console.log(`${sumAll}`);
console.log(`${sumOdd}`);
// ================
