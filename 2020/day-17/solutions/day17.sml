use "../../../lib/util.sml";

structure ILM = Map(
    struct
    type t = int list
    fun cmp ((x :: xs), (y :: ys)) =
        (case Int.compare (x, y) of
             LESS => LESS
           | GREATER => GREATER
           | EQUAL => cmp (xs, ys))
      | cmp _ = EQUAL
    end
)

fun neighbours loc =
    let fun recur [] = []
          | recur [v] = [[v-1], [v], [v+1]]
          | recur (v :: vs) =
            recur vs
                  >> List.map (fn xs => [v - 1 :: xs, v :: xs, v+1 :: xs])
                  >> List.concat
    in
        List.filter (fn x => x <> loc) $ recur loc
    end

fun activeNeighbours m loc =
    let fun sum (SOME true, n) = n + 1
          | sum (_, n) = n
    in
        List.foldl sum 0 $ List.map (fn loc => ILM.lookup loc m) $ neighbours loc
    end

fun step m =
    let fun recur m2 [] = m2
          | recur m2 (loc :: nxt) =
            if ILM.contains m2 loc then
                recur m2 nxt
            else
                let val wasActive = SOME true = ILM.lookup loc m
                    val more = if wasActive then neighbours loc else []
                    val numActive = activeNeighbours m loc
                    val isActive = (wasActive andalso numActive = 2) orelse (numActive = 3)
                in
                    recur (ILM.insert loc isActive m2) (more @ nxt)
                end
        fun startElems (loc, true, locs) = loc :: locs
          | startElems (loc, false, locs) = locs
    in
        recur ILM.empty $ ILM.foldl startElems [] m
    end

val numActive =
    let fun count (_, true, n) = n + 1
          | count (_, false, n) = n
    in
        ILM.foldl count 0
    end

fun iter 0 f v = v
  | iter n f v = iter (n - 1) f (f v)

fun toMap acc suffix y [] = acc
  | toMap acc suffix y (xs :: ys) =
    let fun ins (x, #"#", m) = ILM.insert (x :: y :: suffix) true m
          | ins (_, _, m) = m
    in
        toMap (foldli ins acc xs) suffix (y+1) ys
    end

fun main () =
    let val data = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.map String.explode
        val threeD = toMap ILM.empty [0] 0 data
        val fourD = toMap ILM.empty [0,0] 0 data
    in
        println $ Int.toString $ numActive $ iter 6 step threeD;
        println $ Int.toString $ numActive $ iter 6 step fourD
    end
