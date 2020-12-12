import { raymarchEightDirections }from "./raymarch.ts"

{

  const grid = [
    ".............",
    ".L.L.#.#.#.#.",
    ".............",
  ];
  console.info("\nExpect 1 to the east occupied. (@hypirion's test):")
  console.info(grid)

  const {NW,E,N,NE,S,SE,SW,W} = raymarchEightDirections(grid.map(it => [...it]), 1, 1, "#", grid[0].length)

  expect("NW", 0, NW);
  expect("N ", 0, N);
  expect("NE", 0, NE);
  expect("W ", 0, W);
  expect("E ", 1, E); // Should be OCCUPIED to the east (E)
  expect("SE", 0, SE);
  expect("S ", 0, S);
  expect("SW", 0, SW);
}

{
  const grid = [
    "###",
    "#L#",
    "###",
  ];
  console.info("\nExpect all adjecent occupied:")
  console.info(grid)

  const {NW,E,N,NE,S,SE,SW,W} = raymarchEightDirections(grid.map(it => [...it]), 1, 1, "#", 1)

  expect("NW", 1, NW);
  expect("N ", 1, N);
  expect("NE", 1, NE);
  expect("W ", 1, W);
  expect("E ", 1, E);
  expect("SE", 1, SE);
  expect("S ", 1, S);
  expect("SW", 1, SW);
}


{
  const grid = [
    "...",
    ".L.",
    "...",
  ];
  console.info("\nExpect none adjecent occupied:")
  console.info(grid)

  const {NW,E,N,NE,S,SE,SW,W} = raymarchEightDirections(grid.map(it => [...it]), 1, 1, "#", 1)

  expect("NW", 0, NW);
  expect("N ", 0, N);
  expect("NE", 0, NE);
  expect("W ", 0, W);
  expect("E ", 0, E);
  expect("SE", 0, SE);
  expect("S ", 0, S);
  expect("SW", 0, SW);
}

{
  const grid = [
    "L#.",
    "##.",
    "...",
  ];
  console.info("\nExpect corner-case with 3 adjacent occupied:")
  console.info(grid)

  const {NW,E,N,NE,S,SE,SW,W} = raymarchEightDirections(grid.map(it => [...it]), 0, 0, "#", 2)

  expect("NW", 0, NW);
  expect("N ", 0, N);
  expect("NE", 0, NE);
  expect("W ", 0, W);
  expect("E ", 1, E);
  expect("SE", 1, SE);
  expect("S ", 1, S);
  expect("SW", 0, SW);
}

{
  const grid = [
    "...",
    ".##",
    ".#L",
  ];
  console.info("\nExpect opposite corner-case with 3 adjacent occupied:")
  console.info(grid)

  const {NW,E,N,NE,S,SE,SW,W} = raymarchEightDirections(grid.map(it => [...it]), 2, 2, "#", 2)

  expect("NW", 1, NW);
  expect("N ", 1, N);
  expect("NE", 0, NE);
  expect("W ", 1, W);
  expect("E ", 0, E);
  expect("SE", 0, SE);
  expect("S ", 0, S);
  expect("SW", 0, SW);
}

function expect<T>(name: string, expected: T, actual: T) {
  if (expected === actual) {
    console.info(`[TEST PASS ✅] Expected ${name} to be ${expected} Actual: ${actual}`)
  } else {
    console.info(`[TEST FAIL ❌] Expected ${name} to be ${expected} Actual: ${actual}`)
  }
}
