
-- Universal Lua Test
-- Interface de teste para Roblox Studio
-- Mobile + PC

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remover interface antiga
local oldGui = playerGui:FindFirstChild("UniversalLuaTest")
if oldGui then
    oldGui:Destroy()
end

-- Criar GUI
local gui = Instance.new("ScreenGui")
gui.Name = "UniversalLuaTest"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Botão flutuante
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(55, 55)
openButton.Position = UDim2.new(0, 15, 0.5, 0)
openButton.BackgroundColor3 = Color3.fromRGB(20, 120, 255)
openButton.Text = "ULT"
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.TextSize = 18
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openButton

-- Painel principal
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.75, 0, 0.65, 0)
main.Position = UDim2.new(0.125, 0, 0.175, 0)
main.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
main.Visible = false
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

-- Limitar tamanho em telas grandes
local sizeLimit = Instance.new("UISizeConstraint")
sizeLimit.MinSize = Vector2.new(280, 250)
sizeLimit.MaxSize = Vector2.new(600, 450)
sizeLimit.Parent = main

-- Adaptar a interface
local scale = Instance.new("UIScale")
scale.Scale = 1
scale.Parent = main

local function updateScale()
    local camera = workspace.CurrentCamera
    if camera then
        local viewport = camera.ViewportSize
        scale.Scale = math.clamp(
            math.min(viewport.X / 700, viewport.Y / 500),
            0.65,
            1
        )
    end
end

updateScale()

-- Cabeçalho
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -45, 0, 45)
header.Position = UDim2.fromOffset(10, 0)
header.BackgroundTransparency = 1
header.Text = "UNIVERSAL LUA TEST"
header.TextColor3 = Color3.fromRGB(70, 160, 255)
header.TextSize = 16
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

-- Botão fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(35, 35)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 43, 55)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = main

-- Área das abas
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, -55)
sidebar.Position = UDim2.fromOffset(10, 45)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = sidebar

-- Área de conteúdo
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -130, 1, -60)
content.Position = UDim2.fromOffset(120, 50)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab

local function clearContent()
    for _, item in ipairs(content:GetChildren()) do
        item:Destroy()
    end
end

local function createTab(name, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 38)
    button.Position = UDim2.fromOffset(5, y)
    button.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 13
    button.Font = Enum.Font.Gotham
    button.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    return button
end

local function createInfo(text, y)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 35)
    label.Position = UDim2.fromOffset(5, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 225, 240)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
end

local function createTestButton(text, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 38)
    button.Position = UDim2.fromOffset(5, y)
    button.BackgroundColor3 = Color3.fromRGB(35, 90, 160)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 13
    button.Font = Enum.Font.GothamBold
    button.Parent = content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    return button
end

local function showTab(name)
    currentTab = name
    clearContent()

    if name == "Player" then
        createInfo("Jogador: " .. player.Name, 5)
        createInfo("User ID: " .. player.UserId, 40)
        createInfo("Dispositivo: " ..
            (UserInputService.TouchEnabled and "Mobile" or "PC"), 75)

    elseif name == "Visual" then
        createInfo("Ferramentas visuais de teste", 5)
        createTestButton("ESP de teste", 45)
        createInfo("Use em um ambiente autorizado.", 90)

    elseif name == "Movement" then
        createInfo("Testes de movimento", 5)
        createTestButton("Fly - teste", 45)
        createTestButton("Speed - teste", 90)

    elseif name == "Settings" then
        createInfo("Configurações da interface", 5)
        createTestButton("Fechar painel", 45)
    end
end

local playerTab = createTab("Player", 5)
local visualTab = createTab("Visual", 48)
local movementTab = createTab("Movement", 91)
local settingsTab = createTab("Settings", 134)

playerTab.MouseButton1Click:Connect(function()
    showTab("Player")
end)

visualTab.MouseButton1Click:Connect(function()
    showTab("Visual")
end)

movementTab.MouseButton1Click:Connect(function()
    showTab("Movement")
end)

settingsTab.MouseButton1Click:Connect(function()
    showTab("Settings")
end)

openButton.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Arrastar painel com mouse ou toque
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Aba inicial
showTab("Player")
