local
    structure TIO = TextIO
    structure SC = StringCvt
in

infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

fun println x = print $ x ^ "\n"

structure PassLine =
struct
type t = {lo: int, hi: int, ch: char, pass: string}

(* bless this mess *)
fun scan getc src =
    let
        val (lo, src) = valOf $ Int.scan SC.DEC getc src
        val src = SC.dropl (fn c => #"-" = c) getc src
        val (hi, src) = valOf $ Int.scan SC.DEC getc src
        val src = SC.skipWS getc src
        val (ch, src) = valOf $ Char.scan getc src
        val src = SC.dropl (Char.contains ": ") getc src
        val (pass, src) = valOf $ String.scan getc src
    in
        SOME ({lo = lo, hi = hi, ch = ch, pass = pass}, src)
    end

val fromString = SC.scanString scan
end

fun sledRentalPolicy {lo, hi, ch, pass} =
    let
        val numCh = List.length $ List.filter (fn c => ch = c) $ String.explode pass
    in
        lo <= numCh andalso numCh <= hi
    end

fun tobogganRentalPolicy {lo, hi, ch, pass} =
    let
        val passCh = String.explode pass
        fun rightCh loc =
            List.nth (passCh, loc - 1) = ch
    in
        rightCh lo <> rightCh hi
    end

fun main () =
    let val input = TIO.inputAll TIO.stdIn
                                 >> String.tokens (fn c => c = #"\n")
                                 >> List.map (valOf o PassLine.fromString)
    in
        println $ Int.toString $ List.length $ List.filter sledRentalPolicy input;
        println $ Int.toString $ List.length $ List.filter tobogganRentalPolicy input
    end
end
