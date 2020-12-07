import { readFileSync } from "fs";

const STANDARD_IN = 0
const input = readFileSync(STANDARD_IN)
  .toString();

//   (light red)   bags contain  (1)                (bright white) bag,    (2)    muted yellow bags.
// /^([\w]+ [\w]+) bags contain (.*)[.]$/g

const bags = [
    ...input.matchAll(/([\w]+ [\w]+) bags contain (\d (.*)[.]|no other bags)/g)
  ].map(([,color, rest]) => {

    const bags_inside = ([
      ...rest.matchAll(/(\d) ([\w]+ [\w]+)/g)
    ])
    .map(([,count, color]) => ({count, color}))

    return ({color, bags_inside})
  })


// Recursively scan bags
function findShinyGoldenBag(bag_refs) {
  const resolved_bags = bag_refs.map(bag => bags.find(({color}) => color === bag.color))

  for (const { color, bags_inside } of resolved_bags) {
    if (color === "shiny gold") {
      return 1;
    } else if (bags_inside.length == 0) {
      return 0;
    } else {
      return findShinyGoldenBag(bags_inside);
    }
  }
  return 0;
}

const shinyGoldenBagCount = bags
  .reduce((count, bag) => count + findShinyGoldenBag(bag.bags_inside), 0);

console.log(shinyGoldenBagCount)
