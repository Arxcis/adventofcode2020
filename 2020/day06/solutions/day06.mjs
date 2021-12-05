import { readFileSync } from "fs";

const STANDARD_IN = 0
const lines = readFileSync(STANDARD_IN)
  .toString();

const groups = [...lines.matchAll(/[a-z]+([\s][a-z]+)*/g)]
  .map(([match]) => match);

// -- Part 1 ---
const groupsNoWhitespace = groups
  .map(group => group.replaceAll(/[\s]/g, ""));

const anyoneAnsweredYes = groupsNoWhitespace
  .reduce((count, group) => count
    + (new Set( [...group] )).size, 0)

// -- part 2 --
const groupsSplitByWhitespace = groups
  .map(group => group.split(/[\s]/))

const alphabet = [..."abcdefghijklmnopqrstuvwxyz"];

const everyoneAnsweredYes = groupsSplitByWhitespace
  .reduce((count, group) => count + alphabet
    .reduce((count, char) => count + group
      .every(answer => answer.includes(char)), 0), 0)

console.log(anyoneAnsweredYes)
console.log(everyoneAnsweredYes)
