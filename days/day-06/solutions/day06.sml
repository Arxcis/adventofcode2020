use "../../../util.sml";

fun solve operand =
    listSum o List.map (CharSet.size o foldl' operand)

fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.fields (fn c => c = #"\n")
                                    >> List.map String.explode
                                    >> splitWith (fn xs => xs = [])
                                    >> List.map (List.map CharSet.fromList)
    in
        println $ Int.toString $ solve CharSet.union input;
        println $ Int.toString $ solve CharSet.intersection input
    end
