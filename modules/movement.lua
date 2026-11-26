
-- UNIVERSAL LUA
-- Movement Module V3.0

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local MovementModule = {}

function MovementModule.GetWalkSpeed()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    return humanoid and humanoid.WalkSpeed or 0
end

function MovementModule.SetWalkSpeed(speed)
    speed = tonumber(speed)

    if not speed or speed < 0 or speed > 100 then
        return false
    end

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
        return false
    end

    humanoid.WalkSpeed = speed
    return true
end

return MovementModule
