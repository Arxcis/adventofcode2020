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
    NW |= +(hitCondition === grid[row - ray]?.[col - ray])
    N  |= +(hitCondition === grid[row - ray]?.[col])
    NE |= +(hitCondition === grid[row - ray]?.[col + ray])
    W  |= +(hitCondition === grid[row][col - ray])
    E  |= +(hitCondition === grid[row][col + ray])
    SW |= +(hitCondition === grid[row + ray]?.[col - ray])
    S  |= +(hitCondition === grid[row + ray]?.[col])
    SE |= +(hitCondition === grid[row + ray]?.[col + ray])
  }

  return {NW, N, NE, W, E, SW, S, SE}
}
