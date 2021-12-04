infix 1 >> fun x >> f = f x

fun sum xs =
    List.foldl (op +) 0 xs

fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.tokens (fn c => c = #"\n")
                                    >> List.mapPartial Int.fromString
        val odds = List.filter (fn n => n mod 2 = 1) input
    in
        print (Int.toString (sum input) ^ "\n");
        print (Int.toString (sum odds) ^ "\n")
    end
