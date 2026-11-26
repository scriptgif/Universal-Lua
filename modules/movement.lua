-- UNIVERSAL LUA TEST
-- Movement Module V3.0 (read-only information)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local MovementModule = {}

function MovementModule.GetWalkSpeed()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.WalkSpeed or 0
end

return MovementModule
