import { whatIsTheNthNumberSpoken } from "./whatIsTheNthNumberSpoken.ts"

expect(`The ${4}th spoken number`, 0, whatIsTheNthNumberSpoken([0,3,6], 4))
expect(`The ${5}th spoken number`, 3, whatIsTheNthNumberSpoken([0,3,6], 5))
expect(`The ${6}th spoken number`, 3, whatIsTheNthNumberSpoken([0,3,6], 6))
expect(`The ${7}th spoken number`, 1, whatIsTheNthNumberSpoken([0,3,6], 7))
expect(`The ${8}th spoken number`, 0, whatIsTheNthNumberSpoken([0,3,6], 8))
expect(`The ${9}th spoken number`, 4, whatIsTheNthNumberSpoken([0,3,6], 9))
expect(`The ${10}th spoken number`, 0, whatIsTheNthNumberSpoken([0,3,6], 10))

expect(`The ${4}th spoken number`, 0, whatIsTheNthNumberSpoken([2,1,3], 4))
expect(`The ${5}th spoken number`, 0, whatIsTheNthNumberSpoken([2,1,3], 5))
expect(`The ${6}th spoken number`, 1, whatIsTheNthNumberSpoken([2,1,3], 6))

expect(`The ${2020}th spoken number`, 10, whatIsTheNthNumberSpoken([2,1,3], 2020))
expect(`The ${2020}th spoken number`, 27, whatIsTheNthNumberSpoken([1,2,3], 2020))
expect(`The ${2020}th spoken number`, 78, whatIsTheNthNumberSpoken([2,3,1], 2020))
expect(`The ${2020}th spoken number`, 438, whatIsTheNthNumberSpoken([3,2,1], 2020))
expect(`The ${2020}th spoken number`, 1836, whatIsTheNthNumberSpoken([3,1,2], 2020))
expect(`The ${2020}th spoken number`, 1259, whatIsTheNthNumberSpoken([15,5,1,4,7,0], 2020))

expect("The 30000000th spoken number", 175594, whatIsTheNthNumberSpoken([0,3,6], 30000000))
expect("The 30000000th spoken number", 2578, whatIsTheNthNumberSpoken([1,3,2], 30000000))
expect("The 30000000th spoken number", 3544142, whatIsTheNthNumberSpoken([2,1,3], 30000000))
expect("The 30000000th spoken number", 261214, whatIsTheNthNumberSpoken([1,2,3], 30000000))
expect("The 30000000th spoken number", 6895259, whatIsTheNthNumberSpoken([2,3,1], 30000000))
expect("The 30000000th spoken number", 18, whatIsTheNthNumberSpoken([3,2,1], 30000000))
expect("The 30000000th spoken number", 362, whatIsTheNthNumberSpoken([3,1,2], 30000000))



function expect<T>(name: string, expected: T, actual: T) {
  if (expected === actual) {
    console.info(`[TEST PASS ✅] Expected ${name} to be ${expected} Actual: ${actual}`)
  } else {
    console.info(`[TEST FAIL ❌] Expected ${name} to be ${expected} Actual: ${actual}`)
  }
}
