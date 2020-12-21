const input = (await Deno.readTextFile("/dev/stdin"))
const ruleMatches = [...input.matchAll(/([\w ]+): (\d+)-(\d+) or (\d+)-(\d+)/g)]
const ticketMatches = [...input.matchAll(/(\d+(,\d+)+)\n/g)]

type Rule = {
  name: string;
  ranges: [number, number][]
  possiblePositions: number[];
}

const rules = ruleMatches.map(([,name, firstRangeFrom, firstRangeTo, lastRangeFrom, lastRangeTo]) => ({
  name,
  ranges: [[parseInt(firstRangeFrom), parseInt(firstRangeTo)], [parseInt(lastRangeFrom), parseInt(lastRangeTo)]],
  possiblePositions: [],
})) as Rule[];

type Ticket = {
  numbers: number[]
}

const [myTicket, ...nearbyTickets] = ticketMatches.map(([commaSeparatedNumbers]) => ({
  numbers: commaSeparatedNumbers.split(",").map((num: string) => parseInt(num))
})) as Ticket[];

//
// Part 1
//
{
  let ticketScanningErrorRate = 0

  for (const ticket of nearbyTickets) {
    for (const num of ticket.numbers) {

      const invalid = rules
        .every(rule => rule.ranges
          .every(([from, to]) => num < from || to < num))

      if (invalid) {
        ticketScanningErrorRate += num
      }
    }
  }

  console.log(`${ticketScanningErrorRate}`)
}

//
// Part 2
//
{
  const validTickets = nearbyTickets
    .filter(ticket => ticket.numbers
      .every(num => rules
        .some(rule => rule.ranges
          .some(([from, to]) => from <= num && num <= to))))

  const allPositions = validTickets[0].numbers
    .map((_,i) => i)

  // 1. Find all possible positions per rule
  for (const rule of rules) {
    rule.possiblePositions = allPositions
      .filter(i => validTickets
        /** @assumption Every ticket has the same amount of numbers, which is why it is safe to use [i] here */
        .map(ticket => ticket.numbers[i])
        .every(num => rule.ranges
          .some(([from, to]) => from <= num && num <= to)))
  }

  // 2. Reduce possibilities to exactly 1 possibility per rule, by elimination method
  let allRules = JSON.parse(JSON.stringify(rules)) as Rule[]
  const rulesWithExactlyOnePossiblePosition = [] as Rule[];
  for (
    let foundIndex = allRules.findIndex(rule => rule.possiblePositions.length === 1);
    foundIndex !== -1;
    foundIndex = allRules.findIndex(rule => rule.possiblePositions.length === 1)
  ) {
    // 3. Copy and push
    const ruleWithExactlyOnePossiblePosition = JSON.parse(JSON.stringify(allRules[foundIndex])) as Rule;
    rulesWithExactlyOnePossiblePosition.push(ruleWithExactlyOnePossiblePosition)

    // 4. Go through all rules, and remove the found possible position
    allRules = allRules
      .map(otherRule => ({
        ...otherRule,
        possiblePositions: otherRule.possiblePositions
          .filter(possiblePosition => possiblePosition !== ruleWithExactlyOnePossiblePosition.possiblePositions[0])
      }))
  }

  const rulesThatStartWithDeparture = rulesWithExactlyOnePossiblePosition
    .filter(rule => rule.name.startsWith("departure"))

  const departueIndicies = rulesThatStartWithDeparture
    .map(rule => rule.possiblePositions[0])

  const answerPart2 = departueIndicies
    .reduce((acc, i) => acc * myTicket.numbers[i], 1)

  console.log(`${answerPart2}`)
}
