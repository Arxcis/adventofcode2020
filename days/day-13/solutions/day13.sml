use "../../../lib/util.sml";

fun earliest1 n b =
    case n mod b of
        0 => (0, b)
     | k => (b - k, b)

fun solve1 n buses =
    let val (k, b) = listMinBy #1 $ List.mapPartial (Option.map $ earliest1 n) buses
    in
        k * b
    end

fun crt v jump (lst as (a, n) :: xs) =
    if v mod n = a then
        crt v (jump * n) xs
    else
        crt (v + jump) jump lst
  | crt v jump [] = v

fun solve2 buses =
    let fun toPairs i [] = []
          | toPairs i (NONE :: bs) = toPairs (i + 1) bs
          | toPairs i (SOME b :: bs) =
            (~i mod b, b) :: toPairs (i + 1) bs
    in
        crt 0 1 $ toPairs 0 buses
    end

fun parse [a, b] = (valOf $ Int.fromString a,
                    List.map Int.fromString $ String.tokens (fn c => c = #",") b)
  | parse x = raise Fail $ "parse: " ^ (PolyML.makestring x)

fun main () =
    let val (n, buses) = TextIO.inputAll TextIO.stdIn
                                         >> String.tokens (fn c => c = #"\n")
                                         >> parse
    in
        println $ Int.toString $ solve1 n buses;
        println $ Int.toString $ solve2 buses
    end
