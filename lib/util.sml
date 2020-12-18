infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

fun println x = print $ x ^ "\n"

fun splitWith pred list =
    let
        fun acc done [] [] = done
          | acc done last [] = List.rev last :: done
          | acc done last (x :: xs) =
            if pred x then
                acc (List.rev last :: done) [] xs
            else
                acc done (x :: last) xs
    in
        List.rev $ acc [] [] list
    end

local
    structure S = Substring
in
fun sensibleStringFields subs s =
    let fun go acc rest =
            if S.isEmpty rest then
                List.rev $ List.map S.string acc
            else
                let val (front, back) = S.position subs rest
                    val rest = if S.isEmpty back
                               then back
                               else S.slice (back, String.size subs, NONE)
                in
                    go (front :: acc) rest
                end
    in
        go [] $ S.full s
    end
end

fun foldl' f (x :: xs) = List.foldl f x xs
  | foldl' f [] = raise Fail "empty list to foldl'"

fun foldli f init l =
    #2 $ List.foldl (fn (v, (i, acc)) => (i+1, f (i, v, acc))) (0, init) l

(** from https://github.com/kfl/mosml/blob/f529b33bb891ff1df4aab198edad376f9ff64d28/src/mosmllib/Listsort.sml **)
fun sort ordr []          = []
  | sort ordr (xs as [_]) = xs
  | sort ordr (xs as [x1, x2]) =
    (case ordr(x1, x2) of
         GREATER => [x2, x1]
       | _       => xs)
  | sort ordr xs =
    let fun merge []       ys = ys
          | merge (x1::xr) ys =
            let fun take x1 xr []       = x1 :: xr
                  | take x1 xr (y1::yr) =
                    (case ordr(x1, y1) of
                         LESS    => x1 :: take y1 yr xr
                       | _       => y1 :: take x1 xr yr)
            in take x1 xr ys end
        fun mergepairs l1  []              k = [l1]
          | mergepairs l1 (ls as (l2::lr)) k =
            if k mod 2 = 1 then l1::ls
            else mergepairs (merge l1 l2) lr (k div 2)
        fun nextrun run []      = (run, [])
          | nextrun run (xs as (x::xr)) =
            if ordr(x, List.hd run) = LESS then (run, xs)
            else nextrun (x::run) xr
        fun sorting []      ls r = List.hd(mergepairs [] ls 0)
          | sorting (x::xs) ls r =
            let val (revrun, tail) = nextrun [x] xs
            in sorting tail (mergepairs (List.rev revrun) ls (r+1)) (r+1) end
    in sorting xs [] 0 end



val listSum = List.foldl (op +) 0
val listProduct = List.foldl (op *) 1
fun listMinBy f = foldl' (fn (a, b) => if f a > f b then b else a)
fun listMaxBy f = foldl' (fn (a, b) => if f a < f b then b else a)
val listMax = listMaxBy (fn x => x)

fun indexedMap f xs =
    let fun recur acc i [] = acc
          | recur acc i (x :: xs) = recur (f (i, x) :: acc) (i + 1) xs
    in
        List.rev $ recur [] 0 xs
    end



signature ORD =
sig
    eqtype t

    val cmp : t * t -> order
end

signature MAP =
sig
    type K
    type 'a Coll

    val empty : 'a Coll
    val lookup : K -> 'a Coll -> 'a option
    val contains : 'a Coll -> K -> bool
    val insert : K -> 'a -> 'a Coll -> 'a Coll
    val remove : K -> 'a Coll -> 'a Coll
    val update : ('a option -> 'a) -> K -> 'a Coll -> 'a Coll
    val updateWithDefault : 'a -> ('a -> 'a) -> K -> 'a Coll -> 'a Coll
    val foldl : (K * 'a * 'b -> 'b) -> 'b -> 'a Coll -> 'b
    val size : 'a Coll -> int
    val fromList : (K * 'a) list -> 'a Coll
    val max : 'a Coll -> (K * 'a) option
    val min : 'a Coll -> (K * 'a) option
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

fun contains s k = isSome $ lookup k s

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

fun update f k coll =
    insert k (f $ lookup k coll) coll

fun updateWithDefault default f k coll =
    update (fn v => f $ getOpt (v, default)) k coll


fun foldl f acc E = acc
  | foldl f acc (T(_, a, (k, v), b)) =
    let
        val la = foldl f acc a
        val ma = f (k, v, la)
    in
        foldl f ma b
    end

(* Linear, but I can't be bothered to implement removal for RB-trees right now *)
fun remove k s =
    foldl (fn (k2, v, s2) => if k <> k2 then insert k2 v s2 else s2) empty s

fun size coll = foldl (fn (_, _, n) => n + 1) 0 coll

fun fromList list = List.foldl (fn ((k, v), s) => insert k v s) empty list

fun max E = NONE
  | max (T (_, _, x, E)) = SOME x
  | max (T (_, _, _, t)) = max t

fun min E = NONE
  | min (T (_, E, x, _)) = SOME x
  | min (T (_, t, _, _)) = min t
end

signature SET =
sig
    type V
    type Coll

    val empty : Coll
    val contains : V -> Coll -> bool
    val insert : V -> Coll -> Coll
    val remove : V -> Coll -> Coll
    val foldl : (V * 'b -> 'b) -> 'b -> Coll -> 'b

    val intersection : (Coll * Coll) -> Coll
    val union : (Coll * Coll) -> Coll
    val size : Coll -> int
    val fromList : V list -> Coll
    val max : Coll -> V option
    val min : Coll -> V option
end

functor Set(Map: MAP) : SET =
struct
type V = Map.K
type Coll = unit Map.Coll

val empty = Map.empty
fun contains v coll = Option.isSome $ Map.lookup v coll
fun insert v coll = Map.insert v () coll
fun remove v coll = Map.remove v coll
fun foldl f acc coll = Map.foldl (fn (a, _, b) => f (a, b)) acc coll
fun intersection (a, b) = foldl (fn (x, s) => if contains x b then insert x s else s) empty a
fun union (a, b) = foldl (fn (x, s) => insert x s) a b
val size = Map.size
fun fromList list = List.foldl (fn (v, s) => insert v s) empty list
fun max coll = Option.map #1 $ Map.max coll
fun min coll = Option.map #1 $ Map.min coll
end

structure UncountedRList =
struct
datatype 'a Tree = Leaf of 'a | Node of 'a * 'a Tree * 'a Tree
type 'a Coll = (int * 'a Tree) list

val empty = []
fun isEmpty ts = null ts

fun cons (x, ts as (w1, t1) :: (w2, t2) :: ts') =
    if w1 = w2 then
        (1 + w1 + w2, Node (x, t1, t2)) :: ts'
    else
        (1, Leaf x) :: ts
  | cons (x, ts) = (1, Leaf x) :: ts

fun head ((1, Leaf x) :: _) = x
  | head ((_, Node (x, _, _)) :: _) = x
  | head _ = raise Empty

fun tail ((1, Leaf _) :: ts) = ts
  | tail ((w, Node (x, t1, t2)) :: ts) = (w div 2, t1) :: (w div 2, t2) :: ts
  | tail _ = raise Empty

fun getTree (1, 0, Leaf x) = x
  | getTree (w, i, Leaf x) = raise Subscript
  | getTree (w, 0, Node (x, t1, t2)) = x
  | getTree (w, i, Node (x, t1, t2)) =

    if i <= w div 2 then
        getTree (w div 2, i - 1, t1)
    else
        getTree (w div 2, i - 1 - w div 2, t2)

fun setTree (1, 0, y, Leaf x) = Leaf y
  | setTree (w, i, y, Leaf x) = raise Subscript
  | setTree (w, 0, y, Node (x, t1, t2)) = Node (y, t1, t2)
  | setTree (w, i, y, Node (x, t1, t2)) =
    if i <= w div 2 then
        Node (x, setTree (w div 2, i - 1, y, t1), t2)
    else
        Node (x, t1, setTree (w div 2, i - 1 - w div 2, y, t2))

fun get (i, []) = raise Subscript
  | get (i, (w, t) :: ts) =
    if i < w then
        getTree (w, i, t)
    else
        get (i - w, ts)

fun set (i, y, []) = raise Subscript
  | set (i, y, (w, t) :: ts) =
    if i < w then
        (w, setTree (w, i, y, t)) :: ts
    else
        (w, t) :: set (i - w, y, ts)
end

structure RList =
struct
type 'a Coll = (int * 'a UncountedRList.Coll)

val empty = (0, UncountedRList.empty)
fun isEmpty (0, _) = true
  | isEmpty _ = false
fun size (n, _) = n

fun cons (x, (n, s)) = (n+1, UncountedRList.cons (x, s))
fun head (_, s) = UncountedRList.head s
fun tail (n, s) = (n - 1, UncountedRList.tail s)
fun get (i, (n, s)) = UncountedRList.get (i, s)
fun set (i, y, (n, s)) = (n, UncountedRList.set (i, y, s))
fun fromList list = List.foldr cons empty list
end

structure CharMap = Map(
    struct
    type t = char
    val cmp = Char.compare
    end)

structure CharSet = Set(CharMap)

structure StringMap = Map(
    struct
    type t = string
    val cmp = String.compare
    end)

structure StringSet = Set(StringMap)

structure IntMap = Map(
    struct
    type t = int
    val cmp = Int.compare
    end)

structure IntSet = Set(IntMap)
