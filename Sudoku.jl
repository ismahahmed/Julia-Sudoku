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

# Print board function the gets recent input and puts it in color
function printBoard2(list, r, c) 
    n = 0
    p = 0
    for i in 1:9
        if n%3==0
            printstyled("  -  -  -  -  -  -  -  -  \n"; color = :magenta) # https://www.geeksforgeeks.org/printing-output-on-screen-in-julia/ 
        end
        for j in 1:9
            if p%3 == 0
                printstyled("| "; color = :magenta)
            end
            p = p +1
            if i == r && j == c
                printstyled(list[i][j]; color = :red)
            else
                print(list[i][j])
            end
            print(" ")
        end
        n = n + 1
        printstyled("|"; color = :magenta)
        print("\n")
    end
    printstyled("  -  -  -  -  -  -  -  -  \n"; color = :magenta)
end 

# Function to get row section of board
function getBlock(grid, n)
    gridBlock = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 2, 5 => 2, 6 => 2, 7 => 3, 8 => 3, 9 => 3)
    blockg = Dict(1 => [1, 2, 3], 2 => [4, 5, 6], 3 => [7, 8, 9])
    r = gridBlock[n]
    return blockg[r]
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
    if n > 9 || n < 0
        return false
    end
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
    r = getBlock(grid, row)
    c = getBlock(grid, col)
    for x in r
        for y in c
            if grid[x][y] == n
                return false
            end
        end
    end
    return true
end

# Getting Input
function input(grid, r, c, n)
    if canPlace(grid, r, c, n) == true
        grid[r][c] = n
    end
    display(grid)
end

# Solving Sudoku Board
function solving(grid)
    empty = findEmpty(grid) # find empty value location
    if empty == false # if empty is false, then the board is solved. Return false
        return(true)
    else 
        r, c = empty # get row and column location of empty value location
    end

    for y in 1:9 # loop through number 1-9 
        if canPlace(grid, r, c, y) # check to see if that number can be placed in r c location
            grid[r][c] = y 
            # backtracking: https://www.geeksforgeeks.org/backtracking-introduction/ 
            if solving(grid) == true 
                return true 
            end
            grid[r][c] = 0 # if solving(grid) does not solve with previous input, replace value with 0
            #printBoard(grid)
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
    print("\nInsert Board Values\n")
    printBoard(user_board)
    for r in 1:9
        for c in 1:9
            print("Enter Value for row: ", r, " and col: ", c)
            print("\nIf the cell is empty, enter 0\n")
            v = false 
            while v == false
                val = parse(Int64, readline())
                if val == 0
                    user_board[r][c] = val
                    printBoard2(user_board, r, c)
                    v = true
                end
                if val != 0
                    if canPlace(user_board, r, c, val) == true
                        user_board[r][c] = val
                        printBoard2(user_board, r, c)
                        v = true
                    else
                            print("Invalid input, try again\n")
                            print("Enter Value for row: ", r, " and col: ", c, "\n")
                            print("If the cell is empty, enter 0\n")
                    end
                end
            end
         end
    end     
    return(user_board)
end
 
# Introduction to program
function intro()
    printstyled("- - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"; color = :blue)
    print("Hello! This program solves (solvable) sudoku boards! \n")
    printstyled("- - - - - - - - - - - - - - - - - - - - - - - - - - - - \n\n"; color = :blue)
    print("Options: Enter 1 to solve user board. Enter 2 to exit program ")
    u = parse(Int64, readline())
    if u == 1
        u = getBoard()
        #solving(u)
        if solving(u)
            printstyled("\n- - - - - - - - - - - - - - - - - - - - - - - - - - - -\n\n"; color = :blue)
            print("SOLVED BOARD: \n")
            printstyled("\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - \n\n"; color = :blue)
            printBoard(u)
        else
            printstyled("\n- - - - - - - - - - - - - - - - - - - - - - - - - - - -\n\n"; color = :blue)
            print("BOARD UNSOLVABLE\n")
            printstyled("\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - \n\n"; color = :blue)
        end
    else
        print("\n Goodbye")
    end
end
