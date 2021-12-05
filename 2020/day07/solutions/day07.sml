use "../../../lib/util.sml";

local
    structure SS = StringSet
    structure SM = StringMap
in

fun toDigit c = Char.ord c - Char.ord #"0"
fun toRule s =
    let
        val (parent, rawChildClauses) =
            case String.substring (s, 0, String.size s - 1)
                         >> String.fields (fn c => c = #" ")
                         >> splitWith (fn x => x = "contain") of
                [a, b] => (String.concatWith " " a, String.concatWith " " b)
              | _ => raise Fail $ "bad input: " ^ s
        (* sigh *)
        fun clause 0 (#" " :: rest) = clause 0 rest
          | clause 1 (#" " :: name) = SOME (1, (String.implode name) ^ "s")
          | clause n (#" " :: name) = SOME (n, String.implode name)
          | clause n (#"n" :: _) = NONE
          | clause n (x :: rest) = clause (n*10 + toDigit x) rest
          | clause _ _ = NONE

        val childClauses = String.fields (fn c => c = #",") rawChildClauses
                                         >> List.mapPartial (clause 0 o String.explode)
    in
        (parent, childClauses)
    end

fun solve1 clauses =
    let fun consRule s p c = SM.updateWithDefault [] (fn xs => p :: xs) c s
        fun invertRules ((p, cs), s) = List.foldl (fn ((_, c), s) => consRule s p c) s cs
        val rules = List.foldl invertRules SM.empty clauses
        fun dfs n seen [] = n
          | dfs n seen (x :: xs) =
            if SS.contains x seen then
                dfs n seen xs
            else
                let val children = getOpt (SM.lookup x rules, [])
                in
                    dfs (n + 1) (SS.insert x seen) (children @ xs)
                end
    in
        dfs ~1 SS.empty ["shiny gold bags"]
    end

fun solve2 clauses =
    let val rules = SM.fromList clauses
        fun sum ((count, name), acc) = acc + count + count * dfs name
        and dfs k = List.foldl sum 0 $ valOf $ SM.lookup k rules
    in
        dfs "shiny gold bags"
    end

fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.tokens (fn c => c = #"\n")
                                    >> List.map toRule
    in
        println $ Int.toString $ solve1 input;
        println $ Int.toString $ solve2 input
    end
end
