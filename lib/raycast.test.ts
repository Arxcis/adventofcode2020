import { raycastEightDirections }from "./raycast.ts"


{
  const grid = [
    ".......#.",
    "...#.....",
    ".#.......",
    ".........",
    "..#L....#",
    "....#....",
    ".........",
    "#........",
    "...#.....",
  ];
  console.info("\nExpect to see 8 occupied seats:")
  console.info(grid)

  const [NW,N,NE,W,E,SW,S,SE] = raycastEightDirections(grid.map(r => [...r]), 4, 3, grid[0].length, ".")

  expect("NW", "#", NW);
  expect("N ", "#", N);
  expect("NE", "#", NE);
  expect("W ", "#", W);
  expect("E ", "#", E);
  expect("SE", "#", SE);
  expect("S ", "#", S);
  expect("SW", "#", SW);
}

{
  const grid = [
    ".............",
    ".L.L.#.#.#.#.",
    ".............",
  ];
  console.info("\nExpect to see 1 empty and 7 floor:")
  console.info(grid)

  const [NW,N,NE,W,E,SW,S,SE] = raycastEightDirections(grid.map(r => [...r]), 1, 1, grid[0].length, ".")

  expect("NW", ".", NW);
  expect("N ", ".", N);
  expect("NE", ".", NE);
  expect("W ", ".", W);
  expect("E ", "L", E);
  expect("SE", ".", SE);
  expect("S ", ".", S);
  expect("SW", ".", SW);
}

{
  const grid = [
    ".##.##.",
    "#.#.#.#",
    "##...##",
    "...L...",
    "##...##",
    "#.#.#.#",
    ".##.##.",
  ];
  console.info("\nExpect to see 8 floor:")
  console.info(grid)

  const [NW,N,NE,W,E,SW,S,SE] = raycastEightDirections(grid.map(r => [...r]), 3, 3, grid[0].length, ".")

  expect("NW", ".", NW);
  expect("N ", ".", N);
  expect("NE", ".", NE);
  expect("W ", ".", W);
  expect("E ", ".", E);
  expect("SE", ".", SE);
  expect("S ", ".", S);
  expect("SW", ".", SW);
}



function expect<T>(name: string, expected: T, actual: T) {
  if (expected === actual) {
    console.info(`[TEST PASS ✅] Expected ${name} to be ${expected} Actual: ${actual}`)
  } else {
    console.info(`[TEST FAIL ❌] Expected ${name} to be ${expected} Actual: ${actual}`)
  }
}
