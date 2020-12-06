import { readFileSync } from "fs";

const STANDARD_IN = 0
const lines = readFileSync(STANDARD_IN)
  .toString()
  .split("\n")
  .slice(0, -1)
  .map(line => parseInt(line));

const double = lines.reduce((acc, i) => !acc ? i * lines.find(j => j + i === 2020): acc, null);
const triple = lines.reduce((acc, i) => !acc ? i * lines.reduce((acc, j) => !acc ? j * lines.find(k => i + j + k === 2020): acc, null): acc, null);

console.log(`${double}`);
console.log(`${triple}`);
