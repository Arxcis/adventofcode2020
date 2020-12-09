use "../../../lib/util.sml";

local
    structure IS = IntSet
in

datatype Op = ACC | JMP | NOP

fun opFromString "acc" = ACC
  | opFromString "jmp" = JMP
  | opFromString "nop" = NOP
  | opFromString s = raise Fail $ "opFromString - bad input: " ^ s

fun toInstruction s =
    case String.tokens (fn c => c = #" ") s of
        [a, b] => (opFromString a, valOf $ Int.fromString b)
      | _  => raise Fail $ "bad input: " ^ s

datatype TerminationReason = STOPPED of int
                           | INF_LOOP of int

fun programResult (STOPPED n) = n
  | programResult (INF_LOOP n) = n

fun run (program : (Op * int) RList.Coll) : TerminationReason =
    let fun go seen pc acc =
            if IS.contains pc seen then
                INF_LOOP acc
            else if RList.size program <= pc then
                STOPPED acc
            else
                let val seen' = IS.insert pc seen
                in
                case RList.get (pc, program) of
                    (ACC, n) => go seen' (pc + 1) (acc + n)
                  | (JMP, n)  => go seen' (pc + n) acc
                  | (NOP, _) => go seen' (pc + 1) acc
                end
    in
        go IS.empty 0 0
    end

fun flip (ACC, n) = NONE
  | flip (JMP, n) = SOME (NOP, n)
  | flip (NOP, n) = SOME (JMP, n)

fun findFlip program i =
    case flip $ RList.get (i, program) of
        NONE => findFlip program (i+1)
      | SOME newOp =>
        case run (RList.set (i, newOp, program)) of
            INF_LOOP _ => findFlip program (i+1)
          | STOPPED n => n

fun main () =
    let val program = TextIO.inputAll TextIO.stdIn
                                      >> String.tokens (fn c => c = #"\n")
                                      >> List.map toInstruction
                                      >> RList.fromList
    in
        println $ Int.toString $ programResult $ run program;
        println $ Int.toString $ findFlip program 0
    end
    handle Subscript => println "boo"
end
