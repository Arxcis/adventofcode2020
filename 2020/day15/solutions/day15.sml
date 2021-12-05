use "../../../lib/util.sml";

local
    structure IM = IntMap
in

fun butlast lst = List.take (lst, List.length lst - 1)

fun run init n =
    let val withInit = foldli (fn (i, v, m) => IM.insert v i m) IM.empty $ butlast init
        fun recur k prev m =
            case k + 1 = n of
                true => prev
              | false => let val m2 = IM.insert prev k m
                         in
                             case IM.lookup prev m of
                                 NONE => recur (k + 1) 0 m2
                               | SOME v => recur (k + 1) (k - v) m2
                         end
    in
        recur (List.length init - 1) (List.last init) withInit
    end

fun main () =
    let val init = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.mapPartial Int.fromString
    in
        println $ Int.toString $ run init 2020;
        println $ Int.toString $ run init 30000000
    end
end
