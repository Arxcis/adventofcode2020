type SpokenNumberType = {
  value: number;
  lastSpokenTurn: number;
  spokenTurnBeforeThat?: number;
}

export function whatIsTheNthSpokenNumber(initialNumbers: number[], N: number): number{

  //
  // Inital round where everyone speaks the initial numbers in sequential order
  //
  const turnBeforeThatMap = new Array(N)
  const lastTurnMap = new Array(N)
  for (let i = 0; i < initialNumbers.length; ++i) {
    lastTurnMap[initialNumbers[i]] = i+1;
  }

  //
  // Actual game starts here, where the next number is calculated based on what was previously spoken.
  //

  // if initial numbers are [1,2,3] -> should be 3th turn now with lastspoken number 3
  let turn = initialNumbers.length;
  let lastSpokenNumber = initialNumbers[initialNumbers.length-1]

  while (turn < N) {
    ++turn;

    // If the last number is a NEW number which has not been spoken before, speak zero!
    if (!turnBeforeThatMap[lastSpokenNumber]) {
      turnBeforeThatMap[0] = lastTurnMap[0]
      lastTurnMap[0] = turn
      lastSpokenNumber = 0
    } else {
      // ...else the diff is the next spoken number
      const nextSpokenNumber = lastTurnMap[lastSpokenNumber] - turnBeforeThatMap[lastSpokenNumber]

      // if the next spoken number been spoken before...
      const exist = lastTurnMap[nextSpokenNumber]
      if (exist) {
        turnBeforeThatMap[nextSpokenNumber] = exist;
        lastTurnMap[nextSpokenNumber] = turn;
        lastSpokenNumber = nextSpokenNumber
      } else {
        // ...else add the next spoken number to the map of spoken numbers
        lastTurnMap[nextSpokenNumber] = turn
        lastSpokenNumber = nextSpokenNumber
      }
    }
  }

  return lastSpokenNumber;
}
