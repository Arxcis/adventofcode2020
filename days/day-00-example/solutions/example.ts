const file = (await Deno.readTextFile('/dev/stdin'))
  .split("\n")
  .slice(0, -1)

let sum_all = 0;
let sum_odd = 0;

for (const line of file) {
  const num = parseInt(line);
  sum_all += num;
  sum_odd += num % 2 == 1 ? num : 0;
}
console.log(`${sum_all}`);
console.log(`${sum_odd}`);
