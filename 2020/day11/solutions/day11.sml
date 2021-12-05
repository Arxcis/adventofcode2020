use "../../../lib/util.sml";

local
    structure A2 = Array2
in

fun id x = x

fun eqA2 a b =
    let
        val range = {base=a,row=0,col=0,nrows=NONE,ncols=NONE}
    in
        A2.foldi A2.RowMajor (fn (y, x, c, v) => v andalso c = A2.sub (b, y, x)) true range
    end

datatype GridElement = Floor | Empty | Occupied

fun geToString Floor = "."
  | geToString Empty = "L"
  | geToString Occupied = "#"

fun findOccupied (SOME 0) (y, x) arr (dy, dx) = false
  | findOccupied n (y, x) arr (dy, dx) =
    let val ny = y + dy
        val nx = x + dx
    in
        if not $ List.exists id [ny < 0, A2.nRows arr <= ny, nx < 0, A2.nCols arr <= nx] then
            case A2.sub (arr, ny, nx) of
                Occupied => true
              | Empty => false
              | Floor => findOccupied (Option.map (fn c => c - 1) n) (ny, nx)  arr (dy, dx)
        else
            false
    end

fun numOccupiedAround maxDist arr (y, x) =
    let val deltas = [(0,1), (1,0), (1,1), (0, ~1), (~1, 0), (1, ~1), (~1, 1), (~1, ~1)]
        fun true2one true = 1
          | true2one false = 0
    in
        listSum $ List.map (true2one o findOccupied maxDist (y, x) arr) deltas
    end

fun a2FromF stepF arr =
    let val (numY, numX) = A2.dimensions arr
    in
        A2.tabulate A2.RowMajor (numY, numX, stepF arr)
    end

fun f1 orig (y, x) =
    case A2.sub (orig, y, x) of
        Floor => Floor
      | Empty => if numOccupiedAround (SOME 1) orig (y, x) = 0 then Occupied else Empty
      | Occupied => if numOccupiedAround (SOME 1) orig (y, x) < 4 then Occupied else Empty

fun f2 orig (y, x) =
    case A2.sub (orig, y, x) of
        Floor => Floor
      | Empty => if numOccupiedAround NONE orig (y, x) = 0 then Occupied else Empty
      | Occupied => if numOccupiedAround NONE orig (y, x) < 5 then Occupied else Empty

fun sumOccupied arr =
    A2.fold A2.RowMajor (fn (s, a) => if s = Occupied then a+1 else a) 0 arr

fun solve f cur =
    let val next = a2FromF f cur
    in
        if eqA2 next cur then
            sumOccupied cur
        else
            solve f next
    end

fun main () =
    let val grid = TextIO.inputAll TextIO.stdIn
                                   >> String.tokens (fn c => c = #"\n")
                                   >> List.map (List.map (fn c => if c = #"L" then Empty else Floor) o String.explode)
                                   >> A2.fromList
    in
        println $ Int.toString $ solve f1 grid;
        println $ Int.toString $ solve f2 grid
    end
end
