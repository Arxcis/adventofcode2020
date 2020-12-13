const matches = [
  ...(await Deno.readTextFile("/dev/stdin")).matchAll(/(\d+|x)/g)
]

const numbers = matches
  .map(([,number]) => parseInt(number))

const idealDepartureTime = numbers[0]

const busIDS = (numbers.slice(1)
  .map((number, i) => ({ busID: number, timeOffset: i })) as {
    busID: number,
    timeOffset: number
  }[])
  .filter(({busID}) => !isNaN(busID))


// --- Part1 ---
const nextDepartures = busIDS.map(({busID}) => ({
  busID,
  nextDeparture: Math.ceil(idealDepartureTime / busID) * busID - idealDepartureTime
})).sort((a, b) => a.nextDeparture - b.nextDeparture)

console.log(nextDepartures[0].nextDeparture * nextDepartures[0].busID)

// --- Part2 ---
let multiplier = 1;
const firstBusID = busIDS[0].busID
let idealTime = null

// Simulate
for (;;)  {
  const time = firstBusID * multiplier

  let foundIdealTime = busIDS
    .every(({busID: otherBusID, timeOffset}) =>
      ((Math.ceil(time / otherBusID) * otherBusID - time) === timeOffset) ? 1:0)

  if (foundIdealTime) {
    idealTime = time
    break;
  }

  ++multiplier
}

console.log(idealTime)
