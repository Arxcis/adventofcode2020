infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

val sum = List.foldl (op +) 0
fun println x = print $ x ^ "\n"

fun findSubsetsAcc acc xs 0 pred
    = if pred acc then [acc] else []
  | findSubsetsAcc acc (x::xs) n pred
    = findSubsetsAcc (x :: acc) xs (n - 1) pred @ findSubsetsAcc acc xs n pred
  | findSubsetsAcc acc nil n pred
    = []

val findSubsets = findSubsetsAcc []

fun solve xs n target =
    let val match = List.hd $ findSubsets xs n (fn candidate => sum candidate = target)
    in
        List.foldl (op *) 1 match
    end

val target = 2020
fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.tokens (fn c => c = #"\n")
                                    >> List.mapPartial Int.fromString
    in
        println $ Int.toString $ solve input 2 target;
        println $ Int.toString $ solve input 3 target
    end
