use "../../../lib/util.sml";

datatype Orientation = N | S | E | W

fun rotLeft E = N
  | rotLeft N = W
  | rotLeft W = S
  | rotLeft S = E

datatype Cmd = ABS of Orientation | F | L | R

fun cmdFromChar #"F" = F
  | cmdFromChar #"L" = L
  | cmdFromChar #"R" = R
  | cmdFromChar #"N" = ABS N
  | cmdFromChar #"S" = ABS S
  | cmdFromChar #"E" = ABS E
  | cmdFromChar #"W" = ABS W
  | cmdFromChar x = raise Fail $ "bad cmdFromChar " ^ Char.toString x

fun step1 ((ABS N, dy), (y, x, orient)) = (y + dy, x, orient)
  | step1 ((ABS S, dy), (y, x, orient)) = (y - dy, x, orient)
  | step1 ((ABS E, dx), (y, x, orient)) = (y, x + dx, orient)
  | step1 ((ABS W, dx), (y, x, orient)) = (y, x - dx, orient)
  | step1 ((F, dy), (y, x, N)) = (y + dy, x, N)
  | step1 ((F, dy), (y, x, S)) = (y - dy, x, S)
  | step1 ((F, dx), (y, x, E)) = (y, x + dx, E)
  | step1 ((F, dx), (y, x, W)) = (y, x - dx, W)
  | step1 ((L, 0), (y, x, orient)) = (y, x, orient)
  | step1 ((L, n), (y, x, orient)) = step1 ((L, n - 90), (y, x, rotLeft orient))
  | step1 ((R, n), state) = step1 ((L, 360 - n), state)

fun solve1 cmds =
    let val (y, x, _) = List.foldl step1 (0, 0, E) cmds
    in
        abs y + abs x
    end

fun step2 ((ABS N, dy), (y, x, wy, wx)) = (y, x, wy + dy, wx)
  | step2 ((ABS S, dy), (y, x, wy, wx)) = (y, x, wy - dy, wx)
  | step2 ((ABS E, dx), (y, x, wy, wx)) = (y, x, wy, wx + dx)
  | step2 ((ABS W, dx), (y, x, wy, wx)) = (y, x, wy, wx - dx)
  | step2 ((F, n), (y, x, wy, wx)) = (y + wy*n, x + wx*n, wy, wx)
  | step2 ((L, 0), state) = state
  | step2 ((L, n), (y, x, wy, wx)) = step2 ((L, n - 90), (y, x, wx, ~wy))
  | step2 ((R, n), state) = step2 ((L, 360 - n), state)

fun solve2 cmds =
    let val (y, x, _, _) = List.foldl step2 (0, 0, 1, 10) cmds
    in
        abs y + abs x
    end

fun parseCmd s =
    let val cmd = cmdFromChar $ String.sub (s, 0)
    in
        (cmd, valOf $ Int.fromString $ String.extract (s, 1, NONE))
    end

fun main () =
    let val cmds = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.map parseCmd
    in
        println $ Int.toString $ solve1 cmds;
        println $ Int.toString $ solve2 cmds
    end
