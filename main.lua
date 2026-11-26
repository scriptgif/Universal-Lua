
-- UNIVERSAL LUA TEST
-- Version 2.0 - Interface Edition
-- Black & Red UI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove versão anterior
pcall(function()
    local old = CoreGui:FindFirstChild("UniversalLuaTest")
    if old then old:Destroy() end
    old = playerGui:FindFirstChild("UniversalLuaTest")
    if old then old:Destroy() end
end)

-- Cores
local BG = Color3.fromRGB(13, 13, 17)
local PANEL = Color3.fromRGB(21, 21, 27)
local CARD = Color3.fromRGB(29, 29, 37)
local RED = Color3.fromRGB(220, 35, 55)
local WHITE = Color3.fromRGB(245, 245, 250)
local MUTED = Color3.fromRGB(145, 145, 160)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "UniversalLuaTest"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success = pcall(function()
    gui.Parent = CoreGui
end)

if not success then
    gui.Parent = playerGui
end

-- Funções visuais
local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or RED
    s.Thickness = thickness or 1
    s.Transparency = 0.35
    s.Parent = obj
    return s
end

local function tween(obj, props, duration)
    TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad),
        props
    ):Play()
end

-- Botão flutuante
local floating = Instance.new("TextButton")
floating.Name = "FloatingButton"
floating.Size = UDim2.fromOffset(54, 54)
floating.Position = UDim2.new(0, 18, 0.5, -27)
floating.BackgroundColor3 = BG
floating.Text = "ULT"
floating.TextColor3 = WHITE
floating.TextSize = 17
floating.Font = Enum.Font.GothamBold
floating.AutoButtonColor = false
floating.Visible = false
floating.Parent = gui
corner(floating, 18)
stroke(floating, RED, 2)

-- Janela principal
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(560, 370)
main.Position = UDim2.new(0.5, -280, 0.5, -185)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui
corner(main, 12)
stroke(main, Color3.fromRGB(85, 30, 40), 1)

-- Ajuste para celular e PC
local scale = Instance.new("UIScale")
scale.Parent = main

local camera = workspace.CurrentCamera

local function updateScale()
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.clamp(
        math.min(viewport.X / 590, viewport.Y / 410),
        0.55,
        1
    )
end

updateScale()
camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- Barra superior
local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 52)
top.BackgroundColor3 = PANEL
top.BorderSizePixel = 0
top.Parent = main
corner(top, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.fromOffset(18, 0)
title.BackgroundTransparency = 1
title.Text = "UNIVERSAL LUA"
title.TextColor3 = WHITE
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local version = Instance.new("TextLabel")
version.Size = UDim2.fromOffset(75, 20)
version.Position = UDim2.new(0, 160, 0.5, -10)
version.BackgroundTransparency = 1
version.Text = "V2.0"
version.TextColor3 = RED
version.TextSize = 11
version.Font = Enum.Font.GothamBold
version.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 30)
close.Position = UDim2.new(1, -45, 0, 11)
close.BackgroundColor3 = Color3.fromRGB(65, 25, 32)
close.Text = "×"
close.TextColor3 = WHITE
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.AutoButtonColor = false
close.Parent = top
corner(close, 7)

-- Área lateral
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(12, 65)
sidebar.Size = UDim2.new(0, 135, 1, -78)
sidebar.BackgroundColor3 = PANEL
sidebar.BorderSizePixel = 0
sidebar.Parent = main
corner(sidebar, 9)

local sideTitle = Instance.new("TextLabel")
sideTitle.Size = UDim2.new(1, -20, 0, 30)
sideTitle.Position = UDim2.fromOffset(10, 8)
sideTitle.BackgroundTransparency = 1
sideTitle.Text = "MENU"
sideTitle.TextColor3 = MUTED
sideTitle.TextSize = 11
sideTitle.Font = Enum.Font.GothamBold
sideTitle.TextXAlignment = Enum.TextXAlignment.Left
sideTitle.Parent = sidebar

-- Conteúdo
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(158, 65)
content.Size = UDim2.new(1, -170, 1, -78)
content.BackgroundColor3 = PANEL
content.BorderSizePixel = 0
content.Parent = main
corner(content, 9)

local pageTitle = Instance.new("TextLabel")
pageTitle.Position = UDim2.fromOffset(16, 12)
pageTitle.Size = UDim2.new(1, -32, 0, 30)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = "Player"
pageTitle.TextColor3 = WHITE
pageTitle.TextSize = 19
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = content

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(16, 42)
subtitle.Size = UDim2.new(1, -32, 0, 22)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Universal Lua interface"
subtitle.TextColor3 = MUTED
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = content

local pageArea = Instance.new("Frame")
pageArea.Position = UDim2.fromOffset(12, 75)
pageArea.Size = UDim2.new(1, -24, 1, -87)
pageArea.BackgroundTransparency = 1
pageArea.Parent = content

local pageLayout = Instance.new("UIListLayout")
pageLayout.Padding = UDim.new(0, 9)
pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
pageLayout.Parent = pageArea

-- Mensagem de interação
local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 220, 0, 38)
notification.Position = UDim2.new(0.5, -110, 1, -55)
notification.BackgroundColor3 = CARD
notification.TextColor3 = WHITE
notification.TextSize = 12
notification.Font = Enum.Font.GothamSemibold
notification.Text = ""
notification.Visible = false
notification.Parent = gui
corner(notification, 8)
stroke(notification, RED, 1)

local function notify(message)
    notification.Text = message
    notification.Visible = true
    notification.TextTransparency = 0
    task.delay(2, function()
        tween(notification, {TextTransparency = 1}, 0.3)
        task.wait(0.3)
        notification.Visible = false
        notification.TextTransparency = 0
    end)
end

-- Limpar página
local function clearPage()
    for _, child in ipairs(pageArea:GetChildren()) do
        if child:IsA("GuiObject") and child ~= pageLayout then
            child:Destroy()
        end
    end
end

-- Cartão informativo
local function addCard(name, description)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 65)
    card.BackgroundColor3 = CARD
    card.BorderSizePixel = 0
    card.Parent = pageArea
    corner(card, 8)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 1, -18)
    accent.Position = UDim2.fromOffset(0, 9)
    accent.BackgroundColor3 = RED
    accent.BorderSizePixel = 0
    accent.Parent = card
    corner(accent, 3)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Position = UDim2.fromOffset(14, 9)
    nameLabel.Size = UDim2.new(1, -25, 0, 22)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = WHITE
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = card

    local desc = Instance.new("TextLabel")
    desc.Position = UDim2.fromOffset(14, 32)
    desc.Size = UDim2.new(1, -25, 0, 20)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = MUTED
    desc.TextSize = 10
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = card
end

-- Botão de ação visual
local function addAction(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 42)
    button.BackgroundColor3 = CARD
    button.Text = "   " .. name
    button.TextColor3 = WHITE
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.Parent = pageArea
    corner(button, 7)

    button.MouseEnter:Connect(function()
        tween(button, {BackgroundColor3 = Color3.fromRGB(55, 27, 34)}, 0.15)
    end)

    button.MouseLeave:Connect(function()
        tween(button, {BackgroundColor3 = CARD}, 0.15)
    end)

    button.MouseButton1Click:Connect(callback)
end

-- Abas
local tabs = {"Player", "Visual", "Movement", "Settings"}
local selectedTab

local function showTab(tabName)
    selectedTab = tabName
    clearPage()

    pageTitle.Text = tabName

    if tabName == "Player" then
        subtitle.Text = "Player section"
        addCard("Player tools", "Área reservada para ferramentas do jogador")
        addAction("Player information", function()
            notify("Interface de Player selecionada")
        end)

    elseif tabName == "Visual" then
        subtitle.Text = "Visual section"
        addCard("Visual settings", "Área reservada para opções visuais")
        addAction("Visual options", function()
            notify("Opções visuais em desenvolvimento")
        end)

    elseif tabName == "Movement" then
        subtitle.Text = "Movement section"
        addCard("Movement settings", "Área reservada para configurações de movimento")
        addAction("Movement options", function()
            notify("Opções de movimento em desenvolvimento")
        end)

    elseif tabName == "Settings" then
        subtitle.Text = "Interface customization"
        addCard("Universal Lua Test", "Version 2.0 - Interface Edition")
        addAction("Hide interface", function()
            main.Visible = false
            floating.Visible = true
        end)
        addAction("Reset interface position", function()
            main.Position = UDim2.new(0.5, -280, 0.5, -185)
            notify("Posição restaurada")
        end)
    end

    for _, item in ipairs(sidebar:GetChildren()) do
        if item:IsA("TextButton") then
            local active = item.Name == tabName
            tween(item, {
                BackgroundColor3 = active and Color3.fromRGB(75, 25, 35) or PANEL,
                TextColor3 = active and WHITE or MUTED
            }, 0.15)
        end
    end
end

for index, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Name = tabName
    button.Size = UDim2.new(1, -16, 0, 38)
    button.Position = UDim2.fromOffset(8, 43 + (index - 1) * 46)
    button.BackgroundColor3 = PANEL
    button.Text = "   " .. tabName
    button.TextColor3 = MUTED
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.Parent = sidebar
    corner(button, 7)

    button.MouseButton1Click:Connect(function()
        showTab(tabName)
    end)
end

-- Minimizar e abrir
close.MouseButton1Click:Connect(function()
    main.Visible = false
    floating.Visible = true
end)

floating.MouseButton1Click:Connect(function()
    main.Visible = true
    floating.Visible = false
end)

-- Arrastar janela
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
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

-- Iniciar
showTab("Player")
notify("Universal Lua carregado!")
