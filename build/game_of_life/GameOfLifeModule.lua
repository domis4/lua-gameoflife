GameOfLifeModule = {}

GameOfLifeModule.grid = {}
GameOfLifeModule.CELL_WIDTH = 32
GameOfLifeModule.CELL_HEIGHT = 32
GameOfLifeModule.CELL_MARGIN = 1
GameOfLifeModule.IS_INITIALIZED = false
GameOfLifeModule.MODE = "Start"

local DISPLAY_WIDTH = 960
local DISPLAY_HEIGHT = 544
GameOfLifeModule.CELL_WIDTH_AMOUNT = math.floor((DISPLAY_WIDTH - 128) / GameOfLifeModule.CELL_WIDTH) - 2
GameOfLifeModule.CELL_HEIGHT_AMOUNT = math.floor((DISPLAY_HEIGHT) / GameOfLifeModule.CELL_HEIGHT) - 2

function GameOfLifeModule.initEmptyGrid()
    for i = 1, GameOfLifeModule.CELL_WIDTH_AMOUNT do
        GameOfLifeModule.grid[i] = {}
        for j = 1, GameOfLifeModule.CELL_HEIGHT_AMOUNT do
            GameOfLifeModule.grid[i][j] = 0
        end
    end
    GameOfLifeModule.IS_INITIALIZED = true
end


function GameOfLifeModule.initRandomGrid()
    for i = 1, GameOfLifeModule.CELL_WIDTH_AMOUNT do
        GameOfLifeModule.grid[i] = {}
        for j = 1, GameOfLifeModule.CELL_HEIGHT_AMOUNT do
            local number = math.random()
            if number >= 0.5 then
                GameOfLifeModule.grid[i][j] = 1
            else
                GameOfLifeModule.grid[i][j] = 0
            end
        end
    end
    GameOfLifeModule.IS_INITIALIZED = true
end

function GameOfLifeModule.switchState(x, y)
    local index = GameOfLifeModule.getIndexFromXY(x, y)
    if index[1] <= GameOfLifeModule.CELL_WIDTH_AMOUNT and index[2] <= GameOfLifeModule.CELL_HEIGHT_AMOUNT and index[1] >= 1 and index[2] >= 1then
        if GameOfLifeModule.grid[index[1]][index[2]] == 0 then
            GameOfLifeModule.grid[index[1]][index[2]] = 1
        else
            GameOfLifeModule.grid[index[1]][index[2]] = 0
        end
    end
end

function GameOfLifeModule.getIndexFromXY(x, y)
    local index = {}
    index[1] = math.floor(x / GameOfLifeModule.CELL_WIDTH)
    index[2] = math.floor(y / GameOfLifeModule.CELL_HEIGHT)
    return index
end


function GameOfLifeModule.getCellState(i, j, grid)
    local cellstate = 0
    if i < 1 then
        cellstate = 0
    elseif j < 1 then
        cellstate = 0
    elseif i > GameOfLifeModule.CELL_WIDTH_AMOUNT then
        cellstate = 0
    elseif j > GameOfLifeModule.CELL_HEIGHT_AMOUNT then
        cellstate = 0
    else
        cellstate = grid[i][j]
    end
    return cellstate
end

function GameOfLifeModule.nextStep()
    local tempGrid = copyByValue(GameOfLifeModule.grid)
    for i = 1, GameOfLifeModule.CELL_WIDTH_AMOUNT do
        for j = 1, GameOfLifeModule.CELL_HEIGHT_AMOUNT do
            GameOfLifeModule.updateCell(i, j, tempGrid)
        end
    end
    GameOfLifeModule.grid = copyByValue(tempGrid);
end

function GameOfLifeModule.updateCell(i, j, grid)
    if GameOfLifeModule.getCellState(i, j, grid) == 0 and GameOfLifeModule.countCellNeighbours(i, j) == 3 then
        GameOfLifeModule.changeState(i, j, grid)
    elseif GameOfLifeModule.getCellState(i, j, grid) == 1 and GameOfLifeModule.countCellNeighbours(i, j) > 1 and GameOfLifeModule.countCellNeighbours(i, j) < 4 then
        -- do nothing
    elseif GameOfLifeModule.getCellState(i, j, grid) == 1 and GameOfLifeModule.countCellNeighbours(i, j) < 2 then
        GameOfLifeModule.changeState(i, j, grid)
    elseif GameOfLifeModule.getCellState(i, j, grid) == 1 and GameOfLifeModule.countCellNeighbours(i, j) > 3 then
        GameOfLifeModule.changeState(i, j, grid)
    end
end

function GameOfLifeModule.changeState(i, j, grid)
    if grid[i][j] == 0 then
        grid[i][j] = 1
    else
        grid[i][j] = 0
    end
end

function GameOfLifeModule.countCellNeighbours(i, j)
    local neighbours = 0

    neighbours = neighbours + GameOfLifeModule.getCellState(i-1, j-1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i, j-1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i+1, j-1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i+1, j, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i+1, j+1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i, j+1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i-1, j+1, GameOfLifeModule.grid);
    neighbours = neighbours + GameOfLifeModule.getCellState(i-1, j, GameOfLifeModule.grid);

    return neighbours
end

function copyByValue(array)
    local copy = {}
    for i = 1, GameOfLifeModule.CELL_WIDTH_AMOUNT do
        copy[i] = {}
        for j = 1, GameOfLifeModule.CELL_HEIGHT_AMOUNT do
            copy[i][j] = array[i][j]
        end
    end
    return copy
end