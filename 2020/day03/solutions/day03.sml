infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

val product = List.foldl (op *) 1
fun println x = print $ x ^ "\n"

fun trees [] x delta = 0
  | trees (row :: r) x (dy, dx) =
    let
        val count = if List.nth (row, x mod (List.length row)) = #"#" then 1 else 0
        val rest = List.drop (r, Int.min (dy - 1, List.length r))
    in
        count + trees rest (x + dx) (dy, dx)
    end

fun solve grid deltas =
    Int.toString $ product $ List.map (trees grid 0) deltas

fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.tokens (fn c => c = #"\n")
                                    >> List.map String.explode
    in
        println $ solve input [(1, 3)];
        println $ solve input [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)]
    end
