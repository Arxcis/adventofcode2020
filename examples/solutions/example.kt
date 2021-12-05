
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
    println(input.sum())

    // Part 2
    println(input.filter{ it % 2 != 0 }.sum())
}

