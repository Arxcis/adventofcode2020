
fun main() {
  // Parse input
  val input = ArrayList<Int>()
  var rawLine = readLine()
  while (rawLine != null) {
    val ints = rawLine.split("\n").map{ it.toInt() }
    input.addAll(ints)
    rawLine = readLine()
  }

  // Part 1
  var count = 0
  for (left in 0 until input.size-1) {
    val right = left + 1
    count = if(input[left] < input[right]) ++count else count
  }
  println(count)

  // Part 2
  val measurements = ArrayList<Int>()
  for (one in 0 until input.size-2) {
    val two = one + 1
    val three = two + 1
    val sum = arrayOf(input[one],input[two],input[three]).sum()
    measurements.add(sum)
  }
  count = 0
  for (left in 0 until measurements.size-1) {
    val right = left + 1

    count = if(measurements[left] < measurements[right]) ++count else count
  }
  println(count)
}

