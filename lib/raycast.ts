/**
 * ## raycastEightDirections()
 *
 * @returns 8 directions
 * ```
 *   NW   N    NE
 *    W   .    E
 *   SW   S    SE
 * ```
 *
 * @example usage:
 * ```js
 * const {NW,E,N,NE,S,SE,SW,W} = raycastEightDirections(grid, 1, 1, grid[0].length, ".")
 * ```
 */
export function raycastEightDirections<Cell>(
  grid: Cell[][], row:number, col:number, rayLimit: number, FLOOR: Cell
) {
  const NW = raycast(rayLimit, FLOOR, ray => grid[row - ray]?.[col - ray])
  const N  = raycast(rayLimit, FLOOR, ray => grid[row - ray]?.[col      ])
  const NE = raycast(rayLimit, FLOOR, ray => grid[row - ray]?.[col + ray])
  const W  = raycast(rayLimit, FLOOR, ray => grid[row      ]?.[col - ray])
  const E  = raycast(rayLimit, FLOOR, ray => grid[row      ]?.[col + ray])
  const SW = raycast(rayLimit, FLOOR, ray => grid[row + ray]?.[col - ray])
  const S  = raycast(rayLimit, FLOOR, ray => grid[row + ray]?.[col      ])
  const SE = raycast(rayLimit, FLOOR, ray => grid[row + ray]?.[col + ray])

  return [NW, N, NE, W, E, SW, S, SE]
}

function raycast<Cell>(
  rayLimit: number, FLOOR: Cell, getCell: (ray: number) => Cell|undefined
): Cell {
  for (let ray = 1; ray <= rayLimit; ++ray) {
    const cell = getCell(ray);
    if (cell === undefined) {
      return FLOOR;
    }
    if (cell !== FLOOR) {
      return cell;
    }
  }

  return FLOOR;
}
