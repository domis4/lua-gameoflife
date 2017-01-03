dofile("app0:/draw/CursorDrawController.lua")
dofile("app0:/draw/FPSDrawController.lua")
dofile("app0:/draw/GameOfLifeDrawController.lua")
dofile("app0:/draw/HUDDrawController.lua")

local DISPLAY_WIDTH = 960
local DISPLAY_HEIGHT = 544
local WHITE = Color.new(255, 255, 255)
DrawModule = {}

function DrawModule.draw()
    Graphics.initBlend()
    Screen.clear()
    DrawModule.drawBackground()
    DrawModule.drawPipelines()
    Graphics.termBlend()
    Screen.flip()
end

function DrawModule.drawPipelines()
    GameOfLifeDrawController.pipeline()
    HUDDrawController.pipeline()
    CursorDrawController.pipeline()
    FPSDrawController.pipeline()
end

function DrawModule.drawBackground()
    Graphics.fillRect(0, DISPLAY_WIDTH, 0, DISPLAY_HEIGHT, WHITE)
end
