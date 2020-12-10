use "../../../lib/util.sml";

local
    structure AS = ArraySlice
in

val N = 25;

fun solve1 xs =
    let fun hasPair vals z =
            if AS.length vals <= 1 then
                false
            else
                let val x = AS.sub (vals, 0)
                    val y = z - x
                in
                    if x <> y andalso AS.exists (fn c => y = c) vals then
                        true
                    else
                        hasPair (AS.subslice (vals, 1, NONE)) z
                end
        fun go i =
            let val subArr = AS.slice (xs, i - N, SOME N)
                val z = Array.sub (xs, i)
            in
                if hasPair subArr z then
                    go (i + 1)
                else
                    z
            end
    in
        go N
    end

val asum = AS.foldl (op +) 0
fun amax xs = AS.foldl Int.max (AS.sub (xs, 0)) xs
fun amin xs = AS.foldl Int.min (AS.sub (xs, 0)) xs

(** naive scan, presumably a sliding window solution would be faster **)
fun solve2 xs target =
    let
        val alen = Array.length xs
        fun go i dj =
            if alen <= i + dj then
                go (i+1) 2
            else
                let val subXs = AS.slice (xs, i, SOME dj)
                in
                    if asum subXs = target then
                        amax subXs + amin subXs
                    else
                        go i (dj + 1)
                end
    in
        go 0 2
    end

fun main () =
    let val nums = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.mapPartial Int.fromString
                                   >> Array.fromList

        val ans1 = solve1 nums
    in
        println $ Int.toString ans1;
        println $ Int.toString $ solve2 nums ans1
    end
end
