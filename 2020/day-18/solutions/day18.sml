use "../../../lib/util.sml";

datatype Expr = Num of int
              | Add of (Expr * Expr)
              | Mul of (Expr * Expr)

fun eval (Num x) = x
  | eval (Add (l, r)) = eval l + eval r
  | eval (Mul (l, r)) = eval l * eval r

(* poor man's parser combinator. Works though. *)

infix 1 >>= fun x >>= k = Option.mapPartial k x
infix 1 >=> fun f >=> g = fn x => f x >>= g

fun mustEval f xs = eval $ #1 $ valOf $ f (Num 0, xs)

fun combine t f (v1, xs) = f (v1, xs) >>= (fn (v2, xs) => SOME (t (v1, v2), xs))
val addf = combine Add
val mulf = combine Mul

fun match c (v, (x :: xs)) = if c = x then SOME (v, xs) else NONE
  | match c _ = NONE

fun alt [] v = NONE
  | alt (f :: fs) v =
    case f v of
        SOME x => SOME x
      | NONE => alt fs v

fun many f v =
    case f v of
        SOME w => many f w
      | NONE => SOME v

fun num (_, (c :: cs)) = if Char.isDigit c
                         then SOME (Num $ ord c - ord #"0", cs)
                         else NONE
  | num (_, []) = NONE

fun expr1 v = alt [ num >=> opexpr1, match #")" >=> expr1 >=> match #"(" >=> opexpr1] v
and opexpr1 v = alt [match #"+" >=> addf expr1, match #"*" >=> mulf expr1, SOME] v
(* rev is there as a hack for L->R parsing *)
fun solve1 data = listSum $ List.map (mustEval expr1 o List.rev) data

fun mul2 v = add2 >=> many (match #"*" >=> mulf add2) $ v
and add2 v = prim2 >=> many (match #"+" >=> addf prim2) $ v
and prim2 v = alt [num, match #"(" >=> mul2 >=> match #")"] v
fun solve2 data = listSum $ List.map (mustEval mul2) data

fun main () =
    let val data = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.map (String.explode o String.concat o String.tokens (fn c => c = #" "))
    in
        println $ Int.toString $ solve1 data;
        println $ Int.toString $ solve2 data
    end
