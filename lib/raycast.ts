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
  let NW: Cell|null = null, N: Cell|null = null, NE: Cell|null = null, W: Cell|null = null, E: Cell|null = null, SW: Cell|null = null, S: Cell|null = null, SE: Cell|null = null

  // Ray cast in 8 directions
  for (let ray = 1; ray <= rayLimit; ++ray) {
    NW =  NW ?? (grid[row - ray]?.[col - ray] === FLOOR ? null : grid[row - ray]?.[col - ray] ?? null);
    N  =  N  ?? (grid[row - ray]?.[col      ] === FLOOR ? null : grid[row - ray]?.[col      ] ?? null);
    NE =  NE ?? (grid[row - ray]?.[col + ray] === FLOOR ? null : grid[row - ray]?.[col + ray] ?? null);
    W  =  W  ?? (grid[row      ]?.[col - ray] === FLOOR ? null : grid[row      ]?.[col - ray] ?? null);
    E  =  E  ?? (grid[row      ]?.[col + ray] === FLOOR ? null : grid[row      ]?.[col + ray] ?? null);
    SW =  SW ?? (grid[row + ray]?.[col - ray] === FLOOR ? null : grid[row + ray]?.[col - ray] ?? null);
    S  =  S  ?? (grid[row + ray]?.[col      ] === FLOOR ? null : grid[row + ray]?.[col      ] ?? null);
    SE =  SE ?? (grid[row + ray]?.[col + ray] === FLOOR ? null : grid[row + ray]?.[col + ray] ?? null);
  }

  NW =  NW ?? FLOOR
  N  =  N  ?? FLOOR
  NE =  NE ?? FLOOR
  W  =  W  ?? FLOOR
  E  =  E  ?? FLOOR
  SW =  SW ?? FLOOR
  S  =  S  ?? FLOOR
  SE =  SE ?? FLOOR

  return [NW, N, NE, W, E, SW, S, SE]
}
