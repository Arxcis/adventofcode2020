const input = (await Deno.readTextFile("/dev/stdin"));

type Bag = {
  color: string;
  bags_inside: BagRef[];
};
type BagRef = {
  count: number;
  color: string;
};

const bags = [
  ...input.matchAll(/([\w]+ [\w]+) bags contain (\d (.*)[.]|no other bags)/g),
].map(([, color, rest]) => {
  const bags_inside = ([
    ...rest.matchAll(/(\d) ([\w]+ [\w]+)/g),
  ])
    .map(([, count, color]) => ({ count: parseInt(count), color })) as BagRef[];

  return ({ color, bags_inside });
}) as Bag[];

const COLOR_SHINY_GOLD = "shiny gold";

// --- Part 1 ----
// Recursively find shiny golden bags
function findShinyGoldenBag(bag_refs: BagRef[]) {
  if (bag_refs.length === 0) {
    return 0;
  }

  const resolved_bags = bag_refs
    .map((bag) => bags.find(({ color }) => color === bag.color))
    .filter((bag) => bag !== undefined) as Bag[];

  for (const { color, bags_inside } of resolved_bags) {
    if (color === COLOR_SHINY_GOLD) {
      return 1;
    } else {
      const found = findShinyGoldenBag(bags_inside);
      if (found) {
        return 1;
      } else {
        continue;
      }
    }
  }
  return 0;
}

const bagContainingShinyGoldeBagCount = bags
  .reduce((count, bag) => count + findShinyGoldenBag(bag.bags_inside), 0);

// --- Part 2 ---
// Recursively count bags inside
function countBagsInside(bag_refs: BagRef[]): number {
  if (bag_refs.length === 0) {
    return 1;
  }

  const resolved_bags = bag_refs
    .map(
      (bag) => [bag.count, bags.find(({ color }) => color === bag.color)]
    ) as [number, Bag][];

  const count = resolved_bags
    .reduce(
      (acc, [bag_count, bag]) =>
        acc + bag_count * countBagsInside(bag.bags_inside),
      1,
    );

  return count;
}

const shinyGoldenBag = bags.find(({ color }) =>
  color === COLOR_SHINY_GOLD
) as Bag;

const shinyGoldBagInsideCount = countBagsInside(shinyGoldenBag.bags_inside) - 1;

console.log(`${bagContainingShinyGoldeBagCount}`);
console.log(`${shinyGoldBagInsideCount}`);
