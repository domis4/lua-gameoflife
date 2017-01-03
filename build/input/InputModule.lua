dofile("app0:/common/FPSController.lua")
dofile("app0:/game_of_life/GameOfLifeModule.lua")

local cursorPosition = {}
local init = true
local inputTimer = Timer.new()
cursorPosition[0] = 0
cursorPosition[1] = 0

InputModule = {}
function InputModule.update()
    InputModule.updateGameOfLifeModule()
    InputModule.updateCursorPosition()
    InputModule.updateFPSLimiter()
end

function InputModule.updateCursorPosition()
    if Controls.check(Controls.read(), SCE_CTRL_DOWN) then
        cursorPosition[1] = cursorPosition[1] + 5 * FPSController.getDelta()
    end
    if Controls.check(Controls.read(), SCE_CTRL_UP) then
        cursorPosition[1] = cursorPosition[1] - 5 * FPSController.getDelta()
    end
    if Controls.check(Controls.read(), SCE_CTRL_LEFT) then
        cursorPosition[0] = cursorPosition[0] - 5 * FPSController.getDelta()
    end
    if Controls.check(Controls.read(), SCE_CTRL_RIGHT) then
        cursorPosition[0] = cursorPosition[0] + 5 * FPSController.getDelta()
    end
end

function InputModule.updateFPSLimiter()
    if Controls.check(Controls.read(), SCE_CTRL_SELECT) and Timer.getTime(inputTimer) >= 500 then
        FPSController.switchFPSLimiter()
        Timer.reset(inputTimer)
    end
end

function InputModule.getCursorPosition()
    return cursorPosition
end

function InputModule.updateGameOfLifeModule()
    if init == true then
        GameOfLifeModule.initRandomGrid()
        init = false
    end

    if Controls.check(Controls.read(), SCE_CTRL_RTRIGGER) and Timer.getTime(inputTimer) >= 500 then
        init = true
        GameOfLifeModule.initRandomGrid()
        init = false
    end

    if Controls.check(Controls.read(), SCE_CTRL_LTRIGGER) and Timer.getTime(inputTimer) >= 500 then
        init = true
        GameOfLifeModule.initEmptyGrid()
        init = false
    end

    if Controls.check(Controls.read(), SCE_CTRL_CROSS) and Timer.getTime(inputTimer) >= 500 then
        GameOfLifeModule.switchState(cursorPosition[0], cursorPosition[1])
        Timer.reset(inputTimer)
    end

    if Controls.check(Controls.read(), SCE_CTRL_START) and Timer.getTime(inputTimer) >= 500 then
        if GameOfLifeModule.MODE == "Start" then
            GameOfLifeModule.MODE = "Stop"
        else
            GameOfLifeModule.MODE = "Start"
        end
        Timer.reset(inputTimer)
    end

    if GameOfLifeModule.MODE == "Stop" then
        GameOfLifeModule.nextStep()
    end
end

