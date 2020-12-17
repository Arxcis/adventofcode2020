const input = (await Deno.readTextFile("/dev/stdin"))
const maskGroups = [...input.matchAll(/mask = [X10]+\n(mem\[\d+\] = \d+\n)+/g)]

//
// --- Part 1 ---
//
{
  const memoryMap = new Map()
  for (const [group] of [...maskGroups]) {
    const maskString = [...(group.match(/[X10]{36}/)?.[0] ?? "")].reverse() as ("X"|"1"|"0")[]

    let SET_ONE_MASK  = 0x00000000000000000000000000000000n
    let SET_ZERO_MASK = 0xffffffffffffffffffffffffffffffffn

    for (let i = 0; i < maskString.length; ++i) {
      const char = maskString[i]

      switch (char) {
        case "1": { SET_ONE_MASK |= 1n << BigInt(i) } break;
        case "0": { SET_ZERO_MASK &= (~(1n << BigInt(i))) } break;
        case "X": {} break;
      }
    }

    const initLines = [...group
        .matchAll(/mem\[(\d+)\] = (\d+)/g)]

    const initValues = initLines
      .map(([,index, value]) => ([parseInt(index), BigInt(value)])) as [number, bigint][]

    for (let [index, value] of initValues) {
      value |= SET_ONE_MASK
      value &= SET_ZERO_MASK

      memoryMap.set(index, value)
    }
  }
  const sum = [...memoryMap.values()].reduce((acc,it) => acc+it, 0n)
  console.log(`${Number(sum)}`)
}

//
// Part 2
//
{
  const memoryMap = new Map()
  for (const [group] of [...maskGroups]) {
    const maskString = [...(group.match(/[X10]{36}/)?.[0] ?? "")] as ("X"|"1"|"0")[]

    const memoryInitLines = [...group
      .matchAll(/mem\[(\d+)\] = (\d+)/g)]
    const memoryInits = memoryInitLines
      .map(([,address, value]) => ([BigInt(address), BigInt(value)])) as [bigint, bigint][]


    for (let [address, value] of memoryInits) {
      let addressCombinations = [address]

      // Enumerate addresses by X's (free floating bits either 0 or 1)
      for (let i = maskString.length-1; i >= 0; --i) {
        const char = maskString[maskString.length-1-i]
        switch (char) {
          case "X": {
            addressCombinations = addressCombinations
              .reduce((acc, it) => [
                ...acc,
                it | 1n << BigInt(i),
                it & ~(1n << BigInt(i))
              ], [] as bigint[])
          } break;
        }
      }

      // OR 1's
      for (let i = maskString.length-1; i >= 0; --i) {
        const char = maskString[maskString.length-1-i]
        switch (char) {
          case "1": {
            addressCombinations = addressCombinations
              .map(it => it | 1n << BigInt(i))
          } break;
        }
      }

      for (const address of addressCombinations) {
        memoryMap.set(address, value)
      }
    }
  }
  const sum = [...memoryMap.values()].reduce((acc,it) => acc+it, 0n)
  console.log(`${Number(sum)}`)
}
