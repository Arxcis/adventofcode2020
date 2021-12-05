
fun main() {
    var input: List<Int> = (readLine()?.split("\n") ?: ArrayList<String>())
        .map{ it.toInt() }

    // Part 1
    println(input.sum())

    // Part 2
    println(input.filter{ it % 2 != 0 }.sum())
}

