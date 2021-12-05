use "../../../lib/util.sml";

fun deltas (x :: y :: rest) = (y - x) :: deltas (y :: rest)
  | deltas _ = []

fun solve1 xs =
    let fun count (1, (a, b, c)) = (a+1, b, c)
          | count (2, (a, b, c)) = (a, b+1, c)
          | count (3, (a, b, c)) = (a, b, c+1)
          | count v = raise Fail ("solve1 count " ^ PolyML.makestring v)
        val res = List.foldl count (0, 0, 0) $ deltas xs
    in
        #1 res * #3 res
    end

fun solve2 xs =
    let fun sum (1, (a, b, c)) = (b, c, a + b +c)
          | sum (2, (a, b, c)) = (c, 0, b + c)
          | sum (3, (a, b, c)) = (0, 0, c)
          | sum v = raise Fail ("solve2 sum " ^ PolyML.makestring v)
    in
       #3 $ List.foldl sum (0, 0, 1) $ deltas xs
    end

fun main () =
    let val nums = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.mapPartial Int.fromString
        val adapters = sort Int.compare $ 0 :: 3 + listMax nums :: nums
    in
        println $ Int.toString $ solve1 adapters;
        println $ Int.toString $ solve2 adapters
    end
