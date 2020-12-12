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

const verticalPadding = grid[0].map(() => ".") as Seat[]
const horizontalPadding = "."

// [ [.,.,.,.], [.,L,.,L,L,.], [.,L,L,L,L,.], [.,.,.,.]]
const paddedGrid = [verticalPadding, ...grid, verticalPadding]
  .map((row) => [horizontalPadding, ...row, horizontalPadding]) as Seat[][]

const notOccupied = (seat: Seat) => seat !== "#" ? 1 : 0
const isOccupied = (seat: Seat) => seat === "#" ? 1 : 0
const FLOOR = ".";
const OCCUPIED = "#"
const EMPTY = "L"

//
// --- part 1 ---
//
{
  // Copy
  let previousGrid = paddedGrid.map(row => row.map(seat => seat))
  let currentGrid = paddedGrid.map(row => row.map(seat => seat))
  let previousOccupiedCount = -1
  let finalOccupiedCount = 0

  // Simulate
  while (previousOccupiedCount !== finalOccupiedCount) {

    const PADSIZE = 1;
    for (let row = PADSIZE; row < previousGrid.length - PADSIZE; ++row) {

      for (let col = PADSIZE; col < previousGrid[row].length - PADSIZE; ++col) {
        const seat = previousGrid[row][col];
        if (seat === FLOOR) continue;
        // Adjacent seats
        //
        //   NW   N    NE
        //    E   x    E
        //   SW   S    SE
        //
        const NW = (OCCUPIED === previousGrid[row - 1][col - 1]) ? 1:0;
        const N  = (OCCUPIED === previousGrid[row - 1][col]) ? 1:0;
        const NE = (OCCUPIED === previousGrid[row - 1][col + 1]) ? 1:0;
        const W  = (OCCUPIED === previousGrid[row][col - 1]) ? 1:0;
        const E  = (OCCUPIED === previousGrid[row][col + 1]) ? 1:0;
        const SW = (OCCUPIED === previousGrid[row + 1][col - 1]) ? 1:0;
        const S  = (OCCUPIED === previousGrid[row + 1][col]) ? 1:0;
        const SE = (OCCUPIED === previousGrid[row + 1][col + 1]) ? 1:0;

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
    previousOccupiedCount = finalOccupiedCount
    finalOccupiedCount = currentGrid
      .reduce((accRow, row) => accRow + row
        .reduce((accSeat, seat) => accSeat + isOccupied(seat), 0), 0)

    // Copy grid
    previousGrid = currentGrid
    currentGrid = currentGrid.map(row => row.map(seat => seat))
  }

  console.log(finalOccupiedCount)
}

//
// --- part 2 ---
//
{
  // Copy
  let previousGrid = grid.map(row => row.map(seat => seat))
  let currentGrid = grid.map(row => row.map(seat => seat))
  let previousOccupiedCount = -1
  let finalOccupiedCount = 0

  let i = 0;
  // Simulate
  while (previousOccupiedCount !== finalOccupiedCount) {

    for (let row = 0; row < previousGrid.length; ++row) {
      for (let col = 0; col < previousGrid[row].length; ++col) {

        const seat = previousGrid[row][col];
        if (seat === FLOOR) continue;

        // 8 directions
        //
        //   NW   N    NE
        //    W   .    E
        //   SW   S    SE
        //
        let NW:(0|1)=0,
             N:(0|1)=0,
            NE:(0|1)=0,
             W:(0|1)=0,
             E:(0|1)=0,
            SW:(0|1)=0,
             S:(0|1)=0,
            SE:(0|1)=0

        const MAX_RAY = Math.max(row+1, col+1, previousGrid.length - row, previousGrid[row].length - col)

        // Do ray-marching in all 8 directions
        for (let ray = 1; ray < MAX_RAY; ++ray) {
          NW |= (OCCUPIED === previousGrid[row - ray]?.[col - ray]) ? 1:0
          N  |= (OCCUPIED === previousGrid[row - ray]?.[col]) ? 1:0
          NE |= (OCCUPIED === previousGrid[row - ray]?.[col + ray]) ? 1:0
          W  |= (OCCUPIED === previousGrid[row][col - ray]) ? 1:0
          E  |= (OCCUPIED === previousGrid[row][col + ray]) ? 1:0
          SW |= (OCCUPIED === previousGrid[row + ray]?.[col - ray]) ? 1:0
          S  |= (OCCUPIED === previousGrid[row + ray]?.[col]) ? 1:0
          SE |= (OCCUPIED === previousGrid[row + ray]?.[col + ray]) ? 1:0
        }

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
    previousOccupiedCount = finalOccupiedCount
    finalOccupiedCount = currentGrid
      .reduce((accRow, row) => accRow + row
        .reduce((accSeat, seat) => accSeat + isOccupied(seat), 0), 0)

    // Copy grid
    previousGrid = currentGrid
    currentGrid = currentGrid.map(row => row.map(seat => seat))
  }

  console.log(finalOccupiedCount)
}
