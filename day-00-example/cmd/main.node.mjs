import readline from "readline";

const lines = readline.createInterface({
  input: process.stdin,
});

let sumAll = 0;
let sumOdd = 0;
for await (const line of lines) {
  const num = parseInt(line);
  sumAll += num;
  sumOdd += num % 2 === 0 ? 0 : num

}

// = Answer
console.log(`${sumAll}`)
console.log(`${sumOdd}`)
// ================
