local Players = game:GetService("Players")
local player = Players.LocalPlayer
local M = {}

function M.GetInfo()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return {
        DisplayName = player.DisplayName,
        Username = player.Name,
        UserId = player.UserId,
        Health = humanoid and math.floor(humanoid.Health) or 0,
        MaxHealth = humanoid and math.floor(humanoid.MaxHealth) or 0,
        WalkSpeed = humanoid and humanoid.WalkSpeed or 0,
        JumpPower = humanoid and humanoid.JumpPower or 0
    }
end

return M
