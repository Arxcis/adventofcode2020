use "../../../lib/util.sml";

local
    structure SS = StringSet
in

fun transpose ([] :: _) = nil
  | transpose xs = List.map List.hd xs :: (transpose $ List.map List.tl xs)

fun between x (_, (a, b), (c, d)) = (a <= x andalso x <= b)
                                    orelse (c <= x andalso x <= d)
fun goodValue fields v = List.exists (between v) fields
fun solve1 (fields, mine, others) =
    listSum $ List.filter (not o goodValue fields) $ List.concat others

fun goodTicket fields = List.all (goodValue fields)

fun solve2 (fields, mine, others) =
    let val validTickets = mine :: List.filter (goodTicket fields) others
        fun candidateFields v = List.foldl (fn ((v,_,_), s) => SS.insert v s) SS.empty $ List.filter (between v) fields
        fun rawGuesses vs = foldl' SS.intersection $ List.map candidateFields vs
        val startGuesses = indexedMap (fn (i, xs) => (i, rawGuesses xs)) $ transpose validTickets
        fun extractSmallest _ [] = NONE
          | extractSmallest acc ((elem as (i, s)) :: xs) =
            if SS.size s = 1 then
                SOME (i, valOf $ SS.max s, List.foldl (op ::) xs acc)
            else
                extractSmallest (elem :: acc) xs
        fun recur res cur =
            case extractSmallest [] cur of
                SOME (i, v, rst) =>
                let
                    val rst' = List.map (fn (i, t) => (i, SS.remove v t)) rst
                in
                    recur ((i, v) :: res) rst'
                end
              | NONE => res
    in
        recur [] startGuesses
              >> List.filter (fn (_, s) => String.isPrefix "departure" s)
              >> List.map (fn (i, _) => List.nth (mine, i))
              >> listProduct
    end

fun parseFields xs =
    let fun parseRange s =
            case String.tokens (fn c => c = #"-") s
                               >> List.mapPartial Int.fromString of
                [a, b] => (a, b)
              | x => raise Fail $ "parseRange: " ^ (PolyML.makestring x)
        fun parse1 x =
            case sensibleStringFields ": " x of
                [field, rawRanges] =>
                (case sensibleStringFields " or " rawRanges
                                           >> List.map parseRange of
                     [a, b] => (field, a, b)
                   | _ => raise Fail $ "parse1 rawRanges: " ^ (PolyML.makestring rawRanges))
              | _ => raise Fail $ "parse1: " ^ (PolyML.makestring x)
    in
        List.map parse1 xs
    end

val parseTicket = List.mapPartial Int.fromString o String.tokens (fn c => c = #",")
val parseTickets = List.map parseTicket o List.tl

fun parse [fields, mine, others] = (parseFields fields, List.hd $ parseTickets mine, parseTickets others)
  | parse x = raise Fail $ "parse: " ^ (PolyML.makestring x)

fun main () =
    let val data = TextIO.inputAll TextIO.stdIn
                                   >> sensibleStringFields "\n\n"
                                   >> List.map (String.tokens (fn c => c = #"\n"))
                                   >> parse
    in
        println $ Int.toString $ solve1 data;
        println $ Int.toString $ solve2 data
    end
end
