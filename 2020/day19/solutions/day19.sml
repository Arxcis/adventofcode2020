use "../../../lib/util.sml";

local
    structure IS = IntSet
    structure IM = IntMap
in

datatype Leaf = ID of int
              | LIT of char

(* still poor man's parser combinator, but CPS style this time around *)
datatype State = S of char list * IS.Coll * (State -> bool) list * (unit -> bool)

fun lit l (S ([], is, ps, q)) = q ()
  | lit l (S (cs, is, [], q)) = q ()
  | lit l (S (c :: cs, is, p :: ps, q)) = if l = c then p $ S (cs, IS.empty, ps, q) else q ()

fun alt [] (S (cs, is, ps, q)) = q ()
  | alt (f :: fs) (S (cs, is, ps, q)) = f (S(cs, is, ps, (fn () => alt fs $ S (cs, is, ps, q))))

fun cat [] (S (cs, is, [], q)) = q ()
  | cat [] (S (cs, is, (p :: ps), q)) = p (S (cs, is, ps, q))
  | cat (f :: fs) (S (cs, is, ps, q)) = f (S (cs, is, fs @ ps, q))

fun finish (S ([], is, [], _)) = true
  | finish (S (_, _, _, q)) = q ()

fun tag id (S (cs, is, [], q)) = q ()
  | tag id (S (cs, is, (p :: ps), q)) =
    case IS.contains id is of
        true => q ()
      | false => p (S (cs, IS.insert id is, ps, q))

fun walk ruleset ruleID s =
    let fun goTerminal (LIT l) = lit l
          | goTerminal (ID n) = walk ruleset n
        fun goCat cats = cat $ map goTerminal cats
        val rule = valOf $ IM.lookup ruleID ruleset
    in
        cat [tag ruleID, alt $ map goCat rule] s
    end

fun match ruleset str = walk ruleset 0 (S (String.explode str, IS.empty, [finish], fn () => false))

fun solve ruleset strs = length $ List.filter (match ruleset) strs

(* should be rather easy to left factor this for significant perf improvements *)
fun parseRule s =
    let fun parseAlt s = map parseCat $ sensibleStringFields " | " s
        and parseCat s = map parseTerminal $ String.tokens (fn x => x = #" ") s
        and parseTerminal s = case String.isPrefix "\"" s of
                                  false => ID $ valOf $ Int.fromString s
                                | true => LIT $ String.sub (s, 1)
    in
    case sensibleStringFields ": " s of
        [id, alts] => (valOf $ Int.fromString id, parseAlt alts)
      | xs => raise Fail $ "parseRule: " ^ (PolyML.makestring xs)
    end

fun parse [rules, strs] =
    let val rules = map parseRule rules
                             >> foldl (fn ((id, alts), m) => IM.insert id alts m) IM.empty
    in
        (rules, strs)
    end
  | parse xs = raise Fail $ "parse: " ^ PolyML.makestring xs

fun main () =
    let val (ruleset, strs) = TextIO.inputAll TextIO.stdIn
                                              >> sensibleStringFields "\n\n"
                                              >> map (String.tokens (fn x => x = #"\n"))
                                              >> parse
        val ruleset2 = ruleset
                           >> IM.insert 8 [[ID 42],[ID 42, ID 8]]
                           >> IM.insert 11 [[ID 42, ID 31], [ID 42, ID 11, ID 31]]
    in
        println $ Int.toString $ solve ruleset strs;
        println $ Int.toString $ solve ruleset2 strs
    end
end
