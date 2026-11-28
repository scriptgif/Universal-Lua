local Players = game:GetService("Players")
local player = Players.LocalPlayer
local M = {}

local function humanoid()
    local character = player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

function M.Get()
    local h = humanoid()
    return h and {WalkSpeed = h.WalkSpeed, JumpPower = h.JumpPower} or nil
end


function M.Apply(walkSpeed, jumpPower)
    local h = humanoid()
    if not h then return false end
    walkSpeed, jumpPower = tonumber(walkSpeed), tonumber(jumpPower)
    if not walkSpeed or not jumpPower then return false end
    if walkSpeed < 0 or walkSpeed > 100 or jumpPower < 0 or jumpPower > 150 then return false end
    h.WalkSpeed = walkSpeed
    h.JumpPower = jumpPower
    return true
end

function M.Reset()
    return M.Apply(16, 50)
end
return M
