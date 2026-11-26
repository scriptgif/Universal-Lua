
-- Universal Lua Test
-- Projeto de aprendizado para Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local character = getCharacter()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- Interface
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UniversalLuaTest"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 190)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "Universal Lua Test"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
title.Parent = frame

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -20, 0, 60)
info.Position = UDim2.new(0, 10, 0, 40)
info.TextColor3 = Color3.new(1, 1, 1)
info.BackgroundTransparency = 1
info.TextWrapped = true
info.Parent = frame

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, -20, 0, 35)
speedButton.Position = UDim2.new(0, 10, 0, 105)
speedButton.Text = "Velocidade: 16"
speedButton.Parent = frame

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(1, -20, 0, 30)
hideButton.Position = UDim2.new(0, 10, 0, 150)
hideButton.Text = "Esconder painel"
hideButton.Parent = frame

local speed = 16

speedButton.MouseButton1Click:Connect(function()
    speed = speed == 16 and 32 or 16

    humanoid.WalkSpeed = speed
    speedButton.Text = "Velocidade: " .. speed
end)

hideButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Atualiza informações do jogador
task.spawn(function()
    while screenGui.Parent do
        character = getCharacter()
        humanoid = character:WaitForChild("Humanoid")
        root = character:WaitForChild("HumanoidRootPart")

        info.Text = "Jogador: " .. player.Name
            .. "\nVelocidade: " .. humanoid.WalkSpeed
            .. "\nPosição: " .. tostring(root.Position)

        task.wait(1)
    end
end)
