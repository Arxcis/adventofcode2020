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

  const spokenMap = new Array(N)
  for (const num of spokenNumbers) {
    spokenMap[num.value] = num;
  }
  //
  // Actual game starts here, where the next number is calculated based on what was previously spoken.
  //

  // if initial numbers are [1,2,3] -> should be 3th turn now with lastspoken number 3
  let turn = spokenNumbers.length;
  let lastSpokenNumber = spokenNumbers[spokenNumbers.length-1]

  let zeroNumber = spokenMap[0] ?? { value: 0, lastSpokenTurn: 0 }

  while (turn < N) {
    ++turn;

    // If the last number is a NEW number which has not been spoken before, speak zero!
    if (!lastSpokenNumber.spokenTurnBeforeThat) {
      zeroNumber.spokenTurnBeforeThat = zeroNumber.lastSpokenTurn
      zeroNumber.lastSpokenTurn = turn
      lastSpokenNumber = zeroNumber
    } else {
      // ...else the diff is the next spoken number
      const diff = lastSpokenNumber.lastSpokenTurn - lastSpokenNumber.spokenTurnBeforeThat

      // if the next spoken number been spoken before...
      const nextSpokenNumber = spokenMap[diff]
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

        spokenMap[diff] = nextSpokenNumber
        lastSpokenNumber = nextSpokenNumber
      }
    }
  }

  return lastSpokenNumber.value;
}
