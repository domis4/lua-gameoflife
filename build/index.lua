-- INJECT start dependencies
dofile("app0:/common/FPSController.lua")
dofile("app0:/input/InputModule.lua")
dofile("app0:/draw/DrawModule.lua")
-- INJECT end dependencies

while true do
    DrawModule.draw()
    InputModule.update()
    FPSController.limit()
end
