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


const FLOOR = ".";
const OCCUPIED = "#"
const EMPTY = "L"
const notOccupied = (seat: Seat) => seat !== "#" ? 1 : 0
const isOccupied = (seat: Seat) => seat === "#" ? 1 : 0

// --- part 1 ---
// Copy
let previousGrid = paddedGrid.map(row => row.map(seat => seat))
let currentGrid = paddedGrid.map(row => row.map(seat => seat))
let previousOccupiedCount = -1
let currentOccupiedCount = 0

// Simulate
while (previousOccupiedCount !== currentOccupiedCount) {

  const PADSIZE = 1;
  for (let row = PADSIZE; row < previousGrid.length - PADSIZE; ++row) {

    for (let col = PADSIZE; col < previousGrid[row].length - PADSIZE; ++col) {
      const seat = previousGrid[row][col];
      if (seat === FLOOR) continue;
      // Adjacent seats
      //
      //   TL   T    TR
      //    L   x    R
      //   BL   B    BR
      //
      const TL = previousGrid[row - 1][col - 1]
      const T = previousGrid[row - 1][col]
      const TR = previousGrid[row - 1][col + 1]
      const L = previousGrid[row][col - 1]
      const R = previousGrid[row][col + 1]
      const BL = previousGrid[row + 1][col - 1]
      const B = previousGrid[row + 1][col]
      const BR = previousGrid[row + 1][col + 1]

      const adjecentSeats = [TL, T, TR, L, R, BL, B, BR] as Seat[]

      // #1 Rule: If every adjacent seat are NOT OCCUPIED, the seat becomes OCCUPIED
      const everySeatNotOccupied = adjecentSeats
        .every(seat => notOccupied(seat))

      if (everySeatNotOccupied) {
        currentGrid[row][col] = OCCUPIED

      } else {
        // #2 Rule: If four or more adjacent seats are OCCUPIED, the seat becomes EMPTY
        const fourOrMoreSeatsOccupied = 4 <= adjecentSeats
          .reduce((acc, it) => acc + isOccupied(it), 0)

        if (fourOrMoreSeatsOccupied) {
          currentGrid[row][col] = EMPTY
        }
      }
    }
  }

  // Total seat count
  previousOccupiedCount = currentOccupiedCount
  currentOccupiedCount = currentGrid
    .reduce((accRow, row) => accRow + row
      .reduce((accSeat, seat) => accSeat + isOccupied(seat), 0), 0)

  previousGrid = currentGrid
  currentGrid = currentGrid.map(row => row.map(seat => seat))
}


console.log(currentOccupiedCount)
