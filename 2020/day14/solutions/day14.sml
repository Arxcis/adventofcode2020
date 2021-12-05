use "../../../lib/util.sml";

local
    structure I = IntInf
    structure IM = IntMap
in

datatype TriState = Zero | One | X

datatype Cmd = MASK of TriState list
             | MEM of int * int

val w = Word.fromInt
val fi = I.fromInt
val ti = I.toInt
fun setBit n bit One = ti $ I.orb (fi n, (I.<< (1, w bit)))
  | setBit n bit Zero = ti $ I.andb (fi n, I.notb (I.<< (1, w bit)))
  | setBit n bit X = n

val sumVals = IM.foldl (fn (_, a, b) => a + b) 0

fun solve1 cmds =
    let fun applyMask mask n
            = #2 $ List.foldl (fn (x, (bit, n)) => (bit + 1, setBit n bit x)) (0, n) mask
        fun go (MASK newM, (m, vs)) = (newM, vs)
          | go (MEM (addr, v), (m, vs)) = (m, IM.insert addr (applyMask m v) vs)
    in
        sumVals $ #2 $ List.foldl go ([], IM.empty) cmds
    end

fun allAddrs [] n = [n]
  | allAddrs (Zero :: xs) n
    = let val m = n mod 2
      in List.map (fn v => v*2 + m) $ allAddrs xs (n div 2) end
  | allAddrs (One :: xs) n =
    List.map (fn v => v*2 + 1) $ allAddrs xs (n div 2)
  | allAddrs (X :: xs) n =
        List.concat $ List.map (fn x => [x*2, x*2+1]) $ allAddrs xs (n div 2)

fun solve2 cmds =
    let fun setVal v (addr, m) = IM.insert addr v m
        fun go (MASK newM, (m, vs)) = (newM, vs)
          | go (MEM (rawAddr, v), (m, vs)) = (m, List.foldl (setVal v) vs $ allAddrs m rawAddr)
    in
        sumVals $ #2 $ List.foldl go ([], IM.empty) cmds
    end

fun parse s =
    let fun toTriState #"X" = X
          | toTriState #"1" = One
          | toTriState #"0" = Zero
          | toTriState x  = raise Fail $ "toTriState " ^ (Char.toString x)
        fun toNum acc [] = acc
          | toNum acc (x :: xs) = toNum (acc*10 + (Char.ord x - Char.ord #"0")) xs
        fun toMem acc (#"]" :: xs) = MEM (acc, toNum 0 $ List.drop (xs, 3))
          | toMem acc (x :: xs) = toMem (acc*10 + (Char.ord x - Char.ord #"0")) xs
          | toMem acc [] = raise Fail "empty toMem"
    in
    case String.isPrefix "mask = " s of
        true => String.extract (s, 7, NONE)
                               >> String.explode
                               >> List.map toTriState
                               >> List.rev
                               >> MASK
      | false => toMem 0 $ String.explode $ String.extract (s, 4, NONE)
    end

fun main () =
    let val cmds = TextIO.inputAll TextIO.stdIn
                                >> String.tokens (fn c => c = #"\n")
                                >> List.map parse
    in
        println $ Int.toString $ solve1 cmds;
        println $ Int.toString $ solve2 cmds
    end
end
