const input = (await Deno.readTextFile("/dev/stdin"))
const maskGroups = input.matchAll(/mask = [X10]+\n(mem\[\d+\] = \d+\n)+/g)
const memoryMap = new Map()

for (const [group] of [...maskGroups]) {
  const maskString = [...(group.match(/[X10]{36}/)?.[0] ?? "")].reverse() as ("X"|"1"|"0")[]

  let SET_ONE_MASK  = 0x00000000000000000000000000000000
  let SET_ZERO_MASK = 0xffffffffffffffffffffffffffffffff

  console.log(maskString.join())
  for (let i = 0; i < maskString.length; ++i) {
    const char = maskString[i]

    switch (char) {
      case "1": { SET_ONE_MASK |= 1 << i } break;
      case "0": { SET_ZERO_MASK &= (~(1 << i)) } break;
      case "X": {} break;
    }
    console.log(i, SET_ONE_MASK, SET_ZERO_MASK, 1 << i, (~(1 << i)))
  }

  break;

  const initLines = [...group
      .matchAll(/mem\[(\d+)\] = (\d+)/g)]

  const initValues = initLines
    .map(([,index, value]) => ([parseInt(index), parseInt(value)]))

  // --- part1 ---
  for (let [index, value] of initValues) {
    value |= SET_ONE_MASK
    value &= SET_ZERO_MASK

    memoryMap.set(index, value)
  }
}

const sum = [...memoryMap.values()].reduce((acc,it) => acc+it, 0)
console.log(sum)
