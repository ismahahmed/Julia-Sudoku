# Function to print out the sudoku board
function printBoard(list)
    n = 0
    p = 0
    for i in 1:9
        if n%3==0
            print("  -  -  -  -  -  -  -  -  - \n")
        end
        for j in 1:9
            if p%3 == 0
                print(" | ")
            end
            p = p +1
            print(list[i][j])
            print(" ")
        end
        n = n + 1
        print(" |")
        print("\n")
    end
    print("  -  -  -  -  -  -  -  -  - \n")
end

# Function to get row section of board
function getRowBlock(grid, row)
    rowBlock = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2, 6 => 2, 7 => 3, 8 => 3, 9 => 3)
    blockr = Dict(1 => [1, 2, 3], 2 => [4, 5, 6], 3 => [7, 8, 9])
    r = rowBlock[row]
    return blockr[r]
end

# Function to get column section of board
function getColBlock(grid, col)
    colBlock = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2, 6 => 2, 7 => 3, 8 => 3, 9 => 3)
    blockc = Dict(1 => [1, 2, 3], 2 => [4, 5, 6], 3 => [7, 8, 9])
    c = colBlock[col] 
    return blockc[c]
end

function findEmpty(grid)    
    for i in 1:9
        for x in 1:9
            if grid[i][x] == 0
                return i, x
            end
        end
    end
    return false
end

# Check to see if you can place number 
function canPlace(grid, row, col, n)
    if grid[row][col]!= 0
        return false
    end
    for x in 1:9
        if grid[row][x] == n
            return false 
        end
    end
    for y in 1:9
        if grid[y][col] == n
            return false
        end
    end
    r = getRowBlock(grid, row)
    c = getRowBlock(grid, col)
    for x in r
        for y in c
            if grid[x][y] == n
                return false
            end
        end
    end
    return true
end

function input(grid, r, c, n)
    if canPlace(grid, r, c, n) == true
        grid[r][c] = n
    end
    display(grid)
end

function solving(grid)
    empty = findEmpty(grid)
    if empty == false
        return(true)
    else
        r, c = empty
    end

    for y in 1:9
        if canPlace(grid, r, c, y)
            grid[r][c] = y
            if solving(grid) == true # backtracking
                return true
            end
            grid[r][c] = 0
        end
    end
    return false
end

# Getting User Input
function getBoard()
    user_board =[[0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    print("- - - - - - - - - - - - - - - - - - - - - - - - - - - -")
    print("Hello! This program solves (solvable) sudoku boards! ")
    print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - \n")
    print("Insert Board Values")
    printBoard(user_board)
    for r in 1:9
        for c in 1:9
            print("Enter Value for row: ", r, " and col: ", c)
            print("If the cell is empty, enter 0")
            val = parse(Int64, readline())
            user_board[r][c] = val
            printBoard(user_board)
        end
    end
    if solving(user_board)
        print("Solved: \n")
        printBoard(user_board)
    else
        print("Board Unsolvable")
    end
end

