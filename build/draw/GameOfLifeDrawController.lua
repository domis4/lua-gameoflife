dofile("app0:/game_of_life/GameOfLifeModule.lua")

local GREY = Color.new(128, 128, 128)

GameOfLifeDrawController = {}

function GameOfLifeDrawController.pipeline()
    if GameOfLifeModule.IS_INITIALIZED == true then
        for i = 1, GameOfLifeModule.CELL_WIDTH_AMOUNT do
            for j = 1, GameOfLifeModule.CELL_HEIGHT_AMOUNT do
                if GameOfLifeModule.grid[i][j] == 1 then
                    Graphics.fillRect(i * GameOfLifeModule.CELL_WIDTH + GameOfLifeModule.CELL_MARGIN,
                        i * GameOfLifeModule.CELL_WIDTH + GameOfLifeModule.CELL_WIDTH - GameOfLifeModule.CELL_MARGIN,
                        j * GameOfLifeModule.CELL_HEIGHT + GameOfLifeModule.CELL_MARGIN,
                        j * GameOfLifeModule.CELL_HEIGHT + GameOfLifeModule.CELL_HEIGHT - GameOfLifeModule.CELL_MARGIN,
                        GREY)
                end
            end
        end
    end
end