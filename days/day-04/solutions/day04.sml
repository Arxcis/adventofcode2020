local
    structure SS = Substring
in

infix 1 >> fun x >> f = f x
infixr 1 $ fun f $ x = f x

val product = List.foldl (op *) 1
fun println x = print $ x ^ "\n"
fun bimap f (a, b) = (f a, f b)
fun oneof xs x = List.exists (fn candidate => x = candidate) xs

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

fun passportFields lines =
    let fun split s =
            case String.tokens (fn c => c = #":") s of
                [a, b] => (a, b)
              | _ => raise Fail ("# of : <> 1 in " ^ s)
    in
    String.concatWith " " lines
                      >> String.tokens (fn c => c = #" ")
                      >> List.map split
    end

fun validInt numDigits low high s =
    numDigits = String.size s andalso
    case Int.fromString s of
        NONE => false
      | SOME n => low <= n andalso n <= high

fun validField ("byr", s) = validInt 4 1920 2002 s
  | validField ("iyr", s) = validInt 4 2010 2020 s
  | validField ("eyr", s) = validInt 4 2020 2030 s
  | validField ("hgt", s) =
    let fun hgtCheck (x, "cm") = validInt 3 150 193 x
          | hgtCheck (x, "in") = validInt 2 59 76 x
          | hgtCheck (x, y) = false
        val ssize = String.size s
    in
        hgtCheck $ bimap SS.string $ SS.splitAt (SS.full s, Int.max(0, ssize - 2))
    end
  | validField ("hcl", s) =
    (case String.explode s of
         [#"#",a,b,c,d,e,f] => List.all (fn c => Char.isDigit c orelse (Char.isLower c andalso Char.isHexDigit c))
                                        [a,b,c,d,e,f]
       | _ => false)
  | validField ("ecl", s) = oneof ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] s
  | validField ("pid", s) = validInt 9 0 999999999 s
  | validField (_, _) = true

val requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
fun hasRequiredFields pass =
    7 = (List.length $ List.filter (oneof requiredFields o #1) pass)

fun validPassport pass =
    hasRequiredFields pass andalso
    List.all validField pass

fun main () =
    let val input = TextIO.inputAll TextIO.stdIn
                                    >> String.fields (fn c => c = #"\n")
                                    >> splitWith (fn c => c = "")
                                    >> List.map passportFields
    in
        println $ Int.toString $ List.length $ List.filter hasRequiredFields input;
        println $ Int.toString $ List.length $ List.filter validPassport input
    end
end
