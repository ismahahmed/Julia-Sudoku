# Function to print out the sudoku board
function printBoard(list)
    for x in 1:9
        for y in 1:9
            println(list[x][y])
        println("")
        end
    end
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
