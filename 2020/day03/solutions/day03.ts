const lines = [...(await Deno.readTextFile('/dev/stdin'))
  .matchAll(/[.#]+/g)]
  .map(([line])=> line);

/** @assumption: every line has the same width */
const LINE_WIDTH = lines[0].length

const toboggans = [
  { x: 0, y: 0, right: 3, down: 1, treesHit: 0},
  { x: 0, y: 0, right: 1, down: 1, treesHit: 0},
  { x: 0, y: 0, right: 5, down: 1, treesHit: 0},
  { x: 0, y: 0, right: 7, down: 1, treesHit: 0},
  { x: 0, y: 0, right: 1, down: 2, treesHit: 0},
]

const FREE = ".";
const TREE = "#";

for (const toboggan of toboggans) {
  // Move toboggan
  toboggan.x = (toboggan.x + toboggan.right) % LINE_WIDTH;
  toboggan.y = toboggan.down;

  while (toboggan.y < lines.length) {
    const line = lines[toboggan.y];

    // Check hit?
    toboggan.treesHit += (line.charAt(toboggan.x) === TREE ? 1:0);

    toboggan.x = (toboggan.x + toboggan.right) % LINE_WIDTH;
    toboggan.y = toboggan.y + toboggan.down;
  }
}


let treeProduct = 1;
for (const { treesHit } of toboggans) {
  treeProduct *= treesHit;
}

console.log(`${toboggans[0].treesHit}`)
console.log(`${treeProduct}`)
