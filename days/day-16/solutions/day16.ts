const input = (await Deno.readTextFile("/dev/stdin"))
const ruleMatches = [...input.matchAll(/([\w ]+): (\d+)-(\d+) or (\d+)-(\d+)/g)]
const ticketMatches = [...input.matchAll(/(\d+(,\d+)+)\n/g)]

type Rule = {
  name: string;
  ranges: [number, number][]
  position: number;
}

const rules = ruleMatches.map(([,name, firstRangeFrom, firstRangeTo, lastRangeFrom, lastRangeTo]) => ({
  name,
  ranges: [[parseInt(firstRangeFrom), parseInt(firstRangeTo)], [parseInt(lastRangeFrom), parseInt(lastRangeTo)]],
  position: -1,
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
  let validTickets = nearbyTickets
    .filter(ticket => ticket.numbers
      .every(num => rules
        .some(rule => rule.ranges
          .some(([from, to]) => from <= num && num <= to))))


  function recursivelyFindRuleCombinationThatWorks(rules: Rule[], numbers: number[])  {
    if (rules.length !== numbers.length) {
      console.error("rules.length !== numbers.length")
      return null;
    }

    if (numbers.length === 1) {
      const [rule] = rules;
      rule.position = numbers.length - 1
      return rules;
    }

    if (numbers.length === 2) {
      const [rule, otherRule] = rules
      const [number, otherNumber] = numbers
    }

    const [number, ...restNumbers] = numbers


  }

console.log(rules, myTicket)

  // const rulesThatStartWithDeparture = rules
  //   .filter(rule => rule.position !== -1)
  //   .filter(rule => rule.name.startsWith("departure"))

  // console.log(rulesThatStartWithDeparture)
  // console.log(myTicket)
  // const answer = rulesThatStartWithDeparture
  //   .reduce((acc, rule) => acc * myTicket.numbers[rule.position], 1)

  // console.log(`${answer}`)
}
