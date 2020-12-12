import { raymarchEightDirections } from "./raymarch.ts"
//
// Example input:
//
// L.LL.LL.LL
// LLLLLLL.LL
// L.L.L..L..
// LLLL.LL.LL
// L.LL.LL.LL
// L.LLLLL.LL
// ..L.L.....
// LLLLLLLLLL
// L.LLLLLL.L
// L.LLLLL.LL
//
type Seat = "." | "#" | "L";
const matches = (await Deno.readTextFile("/dev/stdin"))
  .matchAll(/[L.]+/g)

const grid = [...matches]
  .map(([match]) => [...match]) as Seat[][]


const isOccupied = (seat: Seat) => seat === "#" ? 1 : 0
const FLOOR = ".";
const OCCUPIED = "#"
const EMPTY = "L"

//
// --- part 1 ---
//
{
  // Copy grid
  let previousGrid = grid.map(row => row.map(seat => seat))
  let currentGrid = grid.map(row => row.map(seat => seat))

  // Init counters
  let previousOccupiedCount = -1
  let currentOccupiedCount = 0

  // Simulate
  while (previousOccupiedCount !== currentOccupiedCount) {

    for (let row = 0; row < previousGrid.length; ++row) {
      for (let col = 0; col < previousGrid[row].length; ++col) {

        const seat = previousGrid[row][col];
        if (seat === FLOOR) continue;

        const {NW, N, NE, W, E, SW, S, SE} =
          raymarchEightDirections(previousGrid, row, col, OCCUPIED, 1)

        // # Rule: If four or more directions are OCCUPIED, the seat becomes EMPTY
        const fourOrMoreDirectionsOccupied = (NW + N + NE + W + E + SW + S + SE) >= 4
        if (fourOrMoreDirectionsOccupied) {
          currentGrid[row][col] = EMPTY
          continue
        }

        // # Rule: If every direction is NOT OCCUPIED, the seat becomes OCCUPIED
        const everyDirectionNotOccupied = !NW && !N && !NE && !W && !E && !SW && !S && !SE
        if (everyDirectionNotOccupied) {
          currentGrid[row][col] = OCCUPIED
          continue
        }
      }
    }

    // Count occupied seats
    previousOccupiedCount = currentOccupiedCount
    currentOccupiedCount = currentGrid
      .reduce((accRow, row) => accRow + row
        .reduce((accSeat, seat) => accSeat + isOccupied(seat), 0), 0)

    // Copy grid
    previousGrid = currentGrid
    currentGrid = currentGrid.map(row => row.map(seat => seat))
  }

  console.log(currentOccupiedCount)
}

//
// --- part 2 ---
//
{
  // Copy grid
  let previousGrid = grid.map(row => row.map(seat => seat))
  let currentGrid = grid.map(row => row.map(seat => seat))

  // Init counters
  let previousOccupiedCount = -1
  let currentOccupiedCount = 0

  // Simulate
  while (previousOccupiedCount !== currentOccupiedCount) {

    for (let row = 0; row < previousGrid.length; ++row) {
      for (let col = 0; col < previousGrid[row].length; ++col) {

        const seat = previousGrid[row][col];
        if (seat === FLOOR) continue;

        const rayLimit = Math.max(row+1, col+1, grid.length - row, grid[row].length - col)

        const {NW, N, NE, W, E, SW, S, SE} =
          raymarchEightDirections(previousGrid, row, col, OCCUPIED, rayLimit)

        // #Rule: If five or more directions are OCCUPIED, the seat becomes EMPTY
        const fiveOrMoreSeatsOccupied = (NW + N + NE + W + E + SW + S + SE) >= 5
        if (fiveOrMoreSeatsOccupied) {
          currentGrid[row][col] = EMPTY
          continue
        }

        // #Rule: If every direction is NOT OCCUPIED, the seat becomes OCCUPIED
        const everyDirectionNotOccupied = !NW && !N && !NE && !W && !E && !SW && !S && !SE
        if (everyDirectionNotOccupied) {
          currentGrid[row][col] = OCCUPIED
          continue
        }
      }
    }

    // Count occupied seats
    previousOccupiedCount = currentOccupiedCount
    currentOccupiedCount = currentGrid
      .reduce((accRow, row) => accRow + row
        .reduce((accSeat, seat) => accSeat + isOccupied(seat), 0), 0)

    // Copy grid
    previousGrid = currentGrid
    currentGrid = currentGrid.map(row => row.map(seat => seat))
  }

  console.log(currentOccupiedCount)
}
