-- [[ SERVIÇOS E VARIÁVEIS ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPConfig = {
    Highlight = false,
    Box = false,
    Info = false, -- Nome + Distância
    Tracer = false,
    MenuVisible = true
}

local DrawingsCache = {}

-- [[ INTERFACE ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MultiESPMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 205)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -102)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = MainFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.9, 0, 0, 28)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "ESP MULTI-TIPOS"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 6)
TitleCorner.Parent = Title

local function CreateToggle(labelText, configKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 15
    btn.Text = labelText .. ": OFF"
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        local active = ESPConfig[configKey]
        btn.Text = labelText .. ": " .. (active and "ON" or "OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 130, 65) or Color3.fromRGB(45, 45, 45)
    end)
end

CreateToggle("ESP Highlight", "Highlight")
CreateToggle("ESP Box", "Box")
CreateToggle("ESP Info/Dist", "Info")
CreateToggle("ESP Tracer", "Tracer")

-- [[ GERENCIAMENTO DE DRAWING POR JOGADOR ]]
local function GetOrCreateDrawing(player)
    if DrawingsCache[player] then
        return DrawingsCache[player]
    end

    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Color = Color3.fromRGB(255, 70, 70)
    box.Filled = false
    box.Visible = false

    local info = Drawing.new("Text")
    info.Size = 14
    info.Center = true
    info.Outline = true
    info.Color = Color3.fromRGB(255, 255, 255)
    info.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1.5
    tracer.Color = Color3.fromRGB(0, 220, 255)
    tracer.Visible = false

    DrawingsCache[player] = {
        Box = box,
        Info = info,
        Tracer = tracer
    }
    return DrawingsCache[player]
end

local function HidePlayerDrawings(data)
    if not data then return end
    data.Box.Visible = false
    data.Info.Visible = false
    data.Tracer.Visible = false
end

local function RemovePlayerESP(player)
    local data = DrawingsCache[player]
    if data then
        pcall(function() data.Box:Remove() end)
        pcall(function() data.Info:Remove() end)
        pcall(function() data.Tracer:Remove() end)
        DrawingsCache[player] = nil
    end
    if player.Character then
        local hl = player.Character:FindFirstChild("CustomHighlightESP")
        if hl then hl:Destroy() end
    end
end

Players.PlayerRemoving:Connect(RemovePlayerESP)

-- [[ LOOP PRINCIPAL DE ATUALIZAÇÃO ]]
RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local viewportSize = Camera.ViewportSize

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")

            -- 1. ESP Highlight
            if char then
                local hl = char:FindFirstChild("CustomHighlightESP")
                if ESPConfig.Highlight and hum and hum.Health > 0 then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "CustomHighlightESP"
                        hl.FillColor = Color3.fromRGB(255, 50, 50)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        hl.Parent = char
                    end
                elseif hl then
                    hl:Destroy()
                end
            end

            -- 2. ESP Box, Info e Tracer (Drawing API)
            local data = GetOrCreateDrawing(player)
            if root and head and hum and hum.Health > 0 and (ESPConfig.Box or ESPConfig.Info or ESPConfig.Tracer) then
                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)

                if onScreen then
                    local topPos = Camera:WorldToViewportPoint((head.CFrame * CFrame.new(0, 0.6, 0)).Position)
                    local bottomPos = Camera:WorldToViewportPoint((root.CFrame * CFrame.new(0, -3, 0)).Position)
                    local height = math.max(10, math.abs(topPos.Y - bottomPos.Y))
                    local width = height * 0.6

                    if ESPConfig.Box then
                        data.Box.Size = Vector2.new(width, height)
                        data.Box.Position = Vector2.new(rootPos.X - width / 2, topPos.Y)
                        data.Box.Visible = true
                    else
                        data.Box.Visible = false
                    end

                    if ESPConfig.Info then
                        local distText = ""
                        if myRoot then
                            local studs = math.floor((myRoot.Position - root.Position).Magnitude)
                            distText = " [" .. studs .. "m]"
                        end
                        data.Info.Text = player.Name .. distText
                        data.Info.Position = Vector2.new(rootPos.X, topPos.Y - 18)
                        data.Info.Visible = true
                    else
                        data.Info.Visible = false
                    end

                    if ESPConfig.Tracer then
                        data.Tracer.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                        data.Tracer.To = Vector2.new(rootPos.X, bottomPos.Y)
                        data.Tracer.Visible = true
                    else
                        data.Tracer.Visible = false
                    end
                else
                    HidePlayerDrawings(data)
                end
            else
                HidePlayerDrawings(data)
            end
        end
    end
end)

-- [[ ATALHO INSERT PARA ESCONDER/MOSTRAR MENU ]]
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Insert then
        ESPConfig.MenuVisible = not ESPConfig.MenuVisible
        MainFrame.Visible = ESPConfig.MenuVisible
    end
end)
