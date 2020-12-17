const input = (await Deno.readTextFile("/dev/stdin"))
const lines = [...input.matchAll(/\d+/g)]

const numbers = lines
  .map(([it], i) => ({
    value: parseInt(it),
    lastSpoken: i+1,
    spokenBefore: null
  })) as {
    value: number,
    lastSpoken: number|null,
    spokenBefore: number|null
  }[]

//
// Part 1
//
{
  let zeroNumberSpoken = numbers[numbers.length - 1];
  let lastNumberSpoken = numbers[numbers.length - 1];
  let turn = numbers.length + 1
  let tiredOfPlaying = false

  while (!tiredOfPlaying) {
    if (!lastNumberSpoken.spokenBefore) {
      // Jump to zero
      zeroNumberSpoken.spokenBefore = zeroNumberSpoken.lastSpoken
      zeroNumberSpoken.lastSpoken = turn;
      lastNumberSpoken = zeroNumberSpoken
    } else {
      const diff = lastNumberSpoken?.lastSpoken ?? 0 - lastNumberSpoken?.spokenBefore ?? 0
      const maybeLastNumberSpoken = numbers.find(it => it.value === diff)
      if (!maybeLastNumberSpoken) {
        // New number
        numbers.push({
          value: diff,
          lastSpoken: turn,
          spokenBefore: null
        })
        lastNumberSpoken = {
          value: diff,
          lastSpoken: turn,
          spokenBefore: null
        }
        numbers.push(lastNumberSpoken)
      } else {
        // Existing number
        maybeLastNumberSpoken.spokenBefore = maybeLastNumberSpoken.lastSpoken
        maybeLastNumberSpoken.lastSpoken = turn;
        lastNumberSpoken = maybeLastNumberSpoken
      }
    }
    console.log(lastNumberSpoken)

    if (turn === 2020) tiredOfPlaying = true;
    ++turn
  }
}
