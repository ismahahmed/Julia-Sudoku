# create sudoku struct
struct Sudoku
    board

# populate 9x9 matrix with 0's
    function Sudoku()
        c,r = 3,3
        b = zeros(Int8, c,r)
        new(b)
    end
end

# function that prints out the board/matrix
function printBoard(s::Sudoku)
    display(s.board)
end

# create Sudoku object and print board
s = Sudoku()
printBoard(s)