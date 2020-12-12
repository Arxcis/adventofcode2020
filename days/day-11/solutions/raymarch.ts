type Bin = 0 | 1

export function raymarchEightDirections<Cell>(
  grid: Cell[][], row:number, col:number, hitCondition: Cell, rayLimit = 1
) {
  // 8 directions
  //
  //   NW   N    NE
  //    W   .    E
  //   SW   S    SE
  //
  let NW = 0, N = 0, NE = 0, W = 0, E = 0, SW = 0, S = 0, SE = 0

  // Do ray-marching in all 8 directions
  for (let ray = 1; ray <= rayLimit; ++ray) {

    NW |= (grid[row - ray]?.[col - ray] === hitCondition) ? 1:0
    N  |= (grid[row - ray]?.[col      ] === hitCondition) ? 1:0
    NE |= (grid[row - ray]?.[col + ray] === hitCondition) ? 1:0
    W  |= (grid[row      ]  [col - ray] === hitCondition) ? 1:0
    E  |= (grid[row      ]  [col + ray] === hitCondition) ? 1:0
    SW |= (grid[row + ray]?.[col - ray] === hitCondition) ? 1:0
    S  |= (grid[row + ray]?.[col      ] === hitCondition) ? 1:0
    SE |= (grid[row + ray]?.[col + ray] === hitCondition) ? 1:0
  }

  return {NW, N, NE, W, E, SW, S, SE}
}
