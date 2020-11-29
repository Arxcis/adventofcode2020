import readline from "readline";

(async function () {
  const lines = readline.createInterface({
    input: process.stdin,
  });

  let sumAll = 0;
  let sumOdd = 0;
  for await (const line of lines) {
    const num = parseInt(line);
    sumAll += num;
    sumOdd += num % 2 !== 0 ? num : 0
  }

  // = Answer
  console.log(`${sumAll}`)
  console.log(`${sumOdd}`)
  // ================
})()
