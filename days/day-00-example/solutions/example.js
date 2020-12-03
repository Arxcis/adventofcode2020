const fs = require("fs");

const STANDARD_IN = 0
const lines = fs.readFileSync(STANDARD_IN).toString().split("\n").slice(0, -1)

let sumAll = 0;
let sumOdd = 0;

for (const line of lines) {
  const num = parseInt(line);
  sumAll += num;
  sumOdd += num % 2 !== 0 ? num : 0
}

console.log(`${sumAll}`);
console.log(`${sumOdd}`);
