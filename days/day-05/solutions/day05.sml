local
    structure A = Array
    structure AS = ArraySlice
    structure W = Word
in

infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

fun println x = print $ x ^ "\n"
val w1 = W.fromInt 1
val w2 = W.fromInt 2
fun getBit n x = W.andb (W.>> (x, n), w1)
val binToNum = List.foldl (fn (a, b) => a + 2*b) 0

val toSeatID = binToNum o List.map (W.toInt o getBit w2 o W.notb o W.fromInt o Char.ord)

val solve1 = List.foldl Int.max 0
fun solve2 ids =
    let
        val arr = A.array (128*8, false)
    in
        List.app (fn i => A.update (arr, i, true)) ids;
        AS.slice (arr, 1, SOME $ 128*8-1)
                 >> AS.findi (fn (i, a) => not a andalso A.sub (arr,i) andalso A.sub(arr,i+2))
                 >> valOf >> #1 >> (fn i => i + 1)
    end

fun main () =
    let val seatIds = TextIO.inputAll TextIO.stdIn
                                      >> String.tokens (fn c => c = #"\n")
                                      >> List.map (toSeatID o String.explode)
    in
        println $ Int.toString $ solve1 seatIds;
        println $ Int.toString $ solve2 seatIds
    end
end
