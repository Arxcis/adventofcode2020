type SpokenNumberType = {
  value: number;
  lastSpokenTurn: number;
  spokenTurnBeforeThat?: number;
}

export function whatIsTheNthSpokenNumber(initialNumbers: number[], N: number): number{

  //
  // Inital round where everyone speaks the initial numbers in sequential order
  //
  const spokenNumbers = initialNumbers.map((num, i) => ({
    value: num,
    lastSpokenTurn: i+1,
  })) as SpokenNumberType[];

  const spokenMap = new Map(spokenNumbers.map(it => [it.value, it]));

  //
  // Actual game starts here, where the next number is calculated based on what was previously spoken.
  //

  // if initial numbers are [1,2,3] -> should be 3th turn now with lastspoken number 3
  let turn = spokenNumbers.length;
  let lastSpokenNumber = spokenNumbers[spokenNumbers.length-1]

  while (turn < N) {
    ++turn;

    // If the last number is a NEW number which has not been spoken before, speak zero!
    if (!lastSpokenNumber.spokenTurnBeforeThat) {
      let zeroNumber = spokenMap.get(0)
      if (!zeroNumber) {
        zeroNumber = {
          value: 0,
          lastSpokenTurn: turn,
        }
        spokenMap.set(0, zeroNumber)
      } else {
        zeroNumber.spokenTurnBeforeThat = zeroNumber.lastSpokenTurn
        zeroNumber.lastSpokenTurn = turn
      }
      lastSpokenNumber = zeroNumber
    } else {
      // ...else the diff is the next spoken number
      const diff = lastSpokenNumber.lastSpokenTurn - lastSpokenNumber.spokenTurnBeforeThat

      let nextSpokenNumber = spokenMap.get(diff)

      // if the next spoken number been spoken before...
      if (nextSpokenNumber) {
        nextSpokenNumber.spokenTurnBeforeThat = nextSpokenNumber.lastSpokenTurn;
        nextSpokenNumber.lastSpokenTurn = turn;
        lastSpokenNumber = nextSpokenNumber
      } else {
        // ...else add the next spoken number to the map of spoken numbers
        const nextSpokenNumber = {
          value: diff,
          lastSpokenTurn: turn,
        } as SpokenNumberType

        spokenMap.set(diff, nextSpokenNumber)
        lastSpokenNumber = nextSpokenNumber
      }
    }
  }

  return lastSpokenNumber.value;
}
