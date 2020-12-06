infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

fun println x = print $ x ^ "\n"

fun splitWith pred list =
    let
        fun acc done [] [] = done
          | acc done last [] = last :: done
          | acc done last (x :: xs) =
            if pred x then
                acc (last :: done) [] xs
            else
                acc done (x :: last) xs
    in
        acc [] [] list
    end

fun foldl' f (x :: xs) = List.foldl f x xs
  | foldl' f [] = raise Fail "empty list to foldl'"

val listSum = List.foldl (op +) 0
val listProduct = List.foldl (op *) 1

signature ORD =
sig
    type t

    val cmp : t * t -> order
end

signature MAP =
sig
    type K
    type 'a Coll

    val empty : 'a Coll
    val lookup : K -> 'a Coll -> 'a option
    val insert : K -> 'a -> 'a Coll -> 'a Coll
    val foldl : (K * 'a * 'b -> 'b) -> 'b -> 'a Coll -> 'b
    val size : 'a Coll -> int
    val fromList : (K * 'a) list -> 'a Coll
    (* TODO: Implement remove etc *)
end

functor Map(Key: ORD) : MAP =
struct
type K = Key.t

datatype Colour = R | B
datatype 'a Tree = E | T of Colour * 'a Tree * (K * 'a) * 'a Tree

type 'a Coll = 'a Tree

val empty = E

fun lookup k E = NONE
  | lookup k (T (_, a, (k2, v), b)) =
    case Key.cmp (k, k2) of
        LESS => lookup k a
      | EQUAL => SOME v
      | GREATER => lookup k b

fun balance (B,T (R,T (R,a,x,b),y,c),z,d) = T(R,T (B,a,x,b),y,T (B,c,z,d))
  | balance (B,T (R,a,x,T (R,b,y,c)),z,d) = T(R,T (B,a,x,b),y,T (B,c,z,d))
  | balance (B,a,x,T (R,T (R,b,y,c),z,d)) = T(R,T (B,a,x,b),y,T (B,c,z,d))
  | balance (B,a,x,T (R,b,y,T (R,c,z,d))) = T(R,T (B,a,x,b),y,T (B,c,z,d))
  | balance body = T body

fun insert k v s =
    let
        val x = (k, v)
        fun ins E = T (R, E, x, E)
          | ins (s as T(colour, a, y as (yk, yv), b)) =
            case Key.cmp (k, yk) of
                LESS => balance (colour, ins a, y, b)
              | GREATER => balance (colour, a, y, ins b)
              | EQUAL => T (colour, a, x, b)
        val (a, y, b) = case ins s of
                            T (_, a, y, b) => (a, y, b)
                         | E => raise Fail "impossible"
    in
        T (B, a, y, b)
    end

fun foldl f acc E = acc
  | foldl f acc (T(_, a, (k, v), b)) =
    let
        val la = foldl f acc a
        val ma = f (k, v, la)
    in
        foldl f ma b
    end

fun size coll = foldl (fn (_, _, n) => n + 1) 0 coll

fun fromList list = List.foldl (fn ((k, v), s) => insert k v s) empty list
end


signature SET =
sig
    type V
    type Coll

    val empty : Coll
    val contains : V -> Coll -> bool
    val insert : V -> Coll -> Coll
    val foldl : (V * 'b -> 'b) -> 'b -> Coll -> 'b

    val intersection : (Coll * Coll) -> Coll
    val union : (Coll * Coll) -> Coll
    val size : Coll -> int
    val fromList : V list -> Coll
end

functor Set(Map: MAP) : SET =
struct
type V = Map.K
type Coll = unit Map.Coll

val empty = Map.empty
fun contains v coll = Option.isSome $ Map.lookup v coll
fun insert v coll = Map.insert v () coll
fun foldl f acc coll = Map.foldl (fn (a, _, b) => f (a, b)) acc coll
fun intersection (a, b) = foldl (fn (x, s) => if contains x b then insert x s else s) empty a
fun union (a, b) = foldl (fn (x, s) => insert x s) a b
val size = Map.size
fun fromList list = List.foldl (fn (v, s) => insert v s) empty list
end

structure CharMap = Map(
    struct
    type t = char
    val cmp = Char.compare
    end)

structure CharSet = Set(CharMap)
