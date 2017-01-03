dofile("app0:/common/FPSController.lua")
dofile("app0:/input/InputModule.lua")

local WHITE = Color.new(255, 255, 255)
local BLACK = Color.new(0, 0, 0)

FPSDrawController = {}

function FPSDrawController.pipeline()
    Graphics.debugPrint(5, 5, "FPS: " .. FPSController.getFPS(), BLACK)
    Graphics.debugPrint(5, 524, "DELTA: " .. FPSController.getDelta() .. "         CURSOR: " .. math.floor(cursorPosition[0]) .. ", " .. math.floor(cursorPosition[1]), BLACK)
    Graphics.debugPrint(780, 524, "2017 by domis4", BLACK)
end
