
-- UNIVERSAL LUA TEST
-- Version 1.0
-- Black & Red Interface

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "UniversalLuaTest"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(480, 320)
main.Position = UDim2.new(0.5, -240, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(220, 25, 35)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 45)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "UNIVERSAL LUA TEST"
title.TextColor3 = Color3.fromRGB(255, 45, 55)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35, 35)
close.Position = UDim2.new(1, -40, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(180, 25, 35)
close.Font = Enum.Font.GothamBold
close.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 115, 1, -55)
sidebar.Position = UDim2.fromOffset(10, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
sidebar.Parent = main

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -140, 1, -60)
content.Position = UDim2.fromOffset(130, 50)
content.BackgroundTransparency = 1
content.Parent = main

local function clearContent()
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
end

local function addButton(name, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 38)
    b.Position = UDim2.fromOffset(5, y)
    b.BackgroundColor3 = Color3.fromRGB(150, 25, 35)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.Parent = content

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b

    if callback then
        b.MouseButton1Click:Connect(callback)
    end

    return b
end

local function showTab(tab)
    clearContent()

    if tab == "Player" then
        addButton("Nome: " .. player.Name, 5)
        addButton("User ID: " .. player.UserId, 50)

    elseif tab == "Visual" then
        addButton("ESP - ferramenta de teste", 5)
        addButton("Visual Debug", 50)

    elseif tab == "Movement" then
        addButton("Fly - ambiente de teste", 5)
        addButton("Speed - ambiente de teste", 50)

    elseif tab == "Settings" then
        addButton("Universal Lua Test v1.0", 5)
        addButton("Fechar painel", 50, function()
            main.Visible = false
        end)
    end
end

local tabs = {"Player", "Visual", "Movement", "Settings"}

for i, tab in ipairs(tabs) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Position = UDim2.fromOffset(5, 5 + (i-1)*45)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = tab
    b.Font = Enum.Font.GothamBold
    b.Parent = sidebar

    b.MouseButton1Click:Connect(function()
        showTab(tab)
    end)
end

close.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Arrastar com mouse ou toque
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging then
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

showTab("Player")
