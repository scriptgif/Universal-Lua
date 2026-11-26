return function(Modules)
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local C = Modules.Visual.Palette

    pcall(function()
        local old = playerGui:FindFirstChild("FenixHub")
        if old then old:Destroy() end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "FenixHub"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = playerGui

    local function make(class, props, parent)
        local obj = Instance.new(class)
        for k,v in pairs(props or {}) do obj[k] = v end
        obj.Parent = parent
        return obj
    end
    local function round(obj, radius)
        make("UICorner", {CornerRadius = UDim.new(0, radius or 9)}, obj)
    end
    local function outline(obj, color, thickness)
        make("UIStroke", {Color = color or C.Red, Thickness = thickness or 1, Transparency = 0.2}, obj)
    end
    local function label(parent, text, size, pos, fontSize, color)
        return make("TextLabel", {
            BackgroundTransparency = 1, Text = text, Size = size, Position = pos,
            Font = Enum.Font.GothamSemibold, TextSize = fontSize or 13,
            TextColor3 = color or C.White, TextXAlignment = Enum.TextXAlignment.Left
        }, parent)
    end

    local floating = make("TextButton", {
        Name = "FenixButton", Size = UDim2.fromOffset(64,64),
        Position = UDim2.new(0,22,0.5,-32), BackgroundColor3 = C.Background,
        Text = "🔥", TextSize = 30, TextColor3 = C.White, Visible = false
    }, gui)
    round(floating, 32); outline(floating, C.Red, 2)

    local main = make("Frame", {
        Name = "Main", Size = UDim2.fromOffset(760,500),
        Position = UDim2.new(0.5,-380,0.5,-250),
        BackgroundColor3 = C.Background, BorderSizePixel = 0
    }, gui)
    round(main, 14); outline(main, C.Red, 2)

    local top = make("Frame", {Size=UDim2.new(1,0,0,112), BackgroundColor3=Color3.fromRGB(25,10,15), BorderSizePixel=0}, main)
    round(top, 14)
    label(top, "FENIX HUB", UDim2.new(0,260,0,48), UDim2.fromOffset(24,18), 32, C.White)
    label(top, "VOE MAIS ALTO", UDim2.new(0,240,0,24), UDim2.fromOffset(28,66), 13, C.Orange)
    label(top, "🔥", UDim2.fromOffset(90,70), UDim2.new(0.5,-45,0,20), 48, C.Orange)
    local close = make("TextButton", {Size=UDim2.fromOffset(38,34), Position=UDim2.new(1,-50,0,14), Text="×", TextSize=26, TextColor3=C.White, BackgroundColor3=Color3.fromRGB(80,20,28)}, top)
    round(close, 7)

    local sidebar = make("Frame", {Position=UDim2.fromOffset(12,124), Size=UDim2.new(0,155,1,-136), BackgroundColor3=C.Panel, BorderSizePixel=0}, main)
    round(sidebar, 10)
    local content = make("Frame", {Position=UDim2.fromOffset(178,124), Size=UDim2.new(1,-190,1,-136), BackgroundColor3=C.Panel, BorderSizePixel=0}, main)
    round(content, 10)
    local pageTitle = label(content, "Player", UDim2.new(1,-28,0,32), UDim2.fromOffset(16,12), 21, C.Red)
    local page = make("ScrollingFrame", {Position=UDim2.fromOffset(12,54), Size=UDim2.new(1,-24,1,-66), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=4, CanvasSize=UDim2.new()}, content)
    local layout = make("UIListLayout", {Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder}, page)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 8)
    end)

    local notifyLabel = make("TextLabel", {Size=UDim2.fromOffset(260,38), Position=UDim2.new(0.5,-130,1,-52), BackgroundColor3=C.Card, TextColor3=C.White, TextSize=12, Font=Enum.Font.GothamSemibold, Visible=false, Text=""}, gui)
    round(notifyLabel, 8); outline(notifyLabel, C.Red)
    local function notify(msg)
        if not Modules.Settings.Get("Notifications") then return end
        notifyLabel.Text = tostring(msg); notifyLabel.Visible = true
        task.delay(2, function() if notifyLabel.Parent then notifyLabel.Visible = false end end)
    end
    Modules.Notifications.SetCallback(notify)

    local function clear()
        for _, child in ipairs(page:GetChildren()) do
            if child ~= layout then child:Destroy() end
        end
    end
    local function card(title, desc)
        local f = make("Frame", {Size=UDim2.new(1,-4,0,58), BackgroundColor3=C.Card, BorderSizePixel=0}, page)
        round(f,8)
        make("Frame", {Size=UDim2.new(0,3,1,-16), Position=UDim2.fromOffset(0,8), BackgroundColor3=C.Red, BorderSizePixel=0}, f)
        label(f,title,UDim2.new(1,-26,0,22),UDim2.fromOffset(14,7),13,C.White)
        label(f,desc,UDim2.new(1,-26,0,20),UDim2.fromOffset(14,30),11,C.Muted)
        return f
    end
    local function button(text, fn)
        local b = make("TextButton", {Size=UDim2.new(1,-4,0,40), BackgroundColor3=Color3.fromRGB(65,18,27), Text=text, TextColor3=C.White, TextSize=12, Font=Enum.Font.GothamSemibold, AutoButtonColor=true}, page)
        round(b,7); outline(b,C.Red,1)
        b.MouseButton1Click:Connect(fn)
        return b
    end
    local function toggle(text, default, changed)
        local row = make("Frame", {Size=UDim2.new(1,-4,0,42), BackgroundColor3=C.Card, BorderSizePixel=0}, page)
        round(row,7)
        label(row,text,UDim2.new(1,-85,1,0),UDim2.fromOffset(12,0),12,C.White)
        local state = default
        local b = make("TextButton", {Size=UDim2.fromOffset(48,24), Position=UDim2.new(1,-60,0.5,-12), BackgroundColor3=state and C.Red or Color3.fromRGB(75,70,78), Text=state and "ON" or "OFF", TextColor3=C.White, TextSize=10, Font=Enum.Font.GothamBold}, row)
        round(b,12)
        b.MouseButton1Click:Connect(function()
            state = not state
            b.Text = state and "ON" or "OFF"
            b.BackgroundColor3 = state and C.Red or Color3.fromRGB(75,70,78)
            if changed then changed(state) end
        end)
    end
    local function show(tab)
        clear(); pageTitle.Text = tab
        if tab == "Player" then
            local info = Modules.Player.GetInfo()
            card("Nome", info.DisplayName)
            card("Usuário", "@" .. info.Username)
            card("User ID", tostring(info.UserId))
            card("Vida", info.Health .. " / " .. info.MaxHealth)
            card("WalkSpeed", tostring(info.WalkSpeed))
            button("Atualizar informações", function() show("Player"); notify("Informações atualizadas") end)
        elseif tab == "Visual" then
            card("Personalização", "Opções visuais da interface")
            toggle("Notificações", Modules.Settings.Get("Notifications"), function(v) Modules.Settings.Set("Notifications",v) end)
            toggle("Realce de teste (visual local)", false, function(v) notify(v and "Realce de teste ativado" or "Realce de teste desativado") end)
        elseif tab == "Movement" then
            local current = Modules.Movement.Get() or {WalkSpeed=16,JumpPower=50}
            card("Controles de movimento", "Para experiências próprias/autorizadas")
            local ws = current.WalkSpeed
            local jp = current.JumpPower
            card("WalkSpeed atual", tostring(ws))
            button("WalkSpeed +2", function() ws = math.min(ws+2,100); notify("WalkSpeed definido: "..ws) end)
            button("WalkSpeed -2", function() ws = math.max(ws-2,0); notify("WalkSpeed definido: "..ws) end)
            button("JumpPower +5", function() jp = math.min(jp+5,150); notify("JumpPower definido: "..jp) end)
            button("Aplicar movimento", function()
                if Modules.Movement.Apply(ws,jp) then notify("Movimento aplicado") else notify("Não foi possível aplicar") end
            end)
            button("Restaurar padrão", function()
                ws,jp=16,50
                Modules.Movement.Reset()
                notify("Valores padrão restaurados")
            end)
        elseif tab == "Combat" then
            card("Ferramentas de teste", "Controles demonstrativos; sem automação de combate")
            toggle("Modo de treino (visual)", false, function(v) notify(v and "Modo de treino ligado" or "Modo de treino desligado") end)
            toggle("Indicador de alvo (demonstração)", false, function(v) notify(v and "Indicador ligado" or "Indicador desligado") end)
        elseif tab == "Settings" then
            card("FENIX HUB", "V1.0 • REBORN")
            button("Ocultar interface", function() main.Visible=false; floating.Visible=true end)
            button("Restaurar posição", function() main.Position=UDim2.new(0.5,-380,0.5,-250); notify("Posição restaurada") end)
            button("Notificação de teste", function() notify("FENIX carregado com sucesso!") end)
        elseif tab == "Notifications" then
            card("Central de notificações", "Teste os avisos do FENIX")
            button("Enviar notificação", function() notify("Tudo funcionando!") end)
        end
    end

    local tabs = {"Player","Visual","Movement","Combat","Settings","Notifications"}
    for i, name in ipairs(tabs) do
        local b = make("TextButton", {Name=name, Size=UDim2.new(1,-14,0,42), Position=UDim2.fromOffset(7,10+(i-1)*49), BackgroundColor3=C.Card, Text=name, TextColor3=C.White, TextSize=12, Font=Enum.Font.GothamSemibold, AutoButtonColor=true}, sidebar)
        round(b,7)
        b.MouseButton1Click:Connect(function() show(name) end)
    end

    close.MouseButton1Click:Connect(function() main.Visible=false; floating.Visible=true end)
    floating.MouseButton1Click:Connect(function() main.Visible=true; floating.Visible=false end)

    local dragging, dragStart, startPos = false, nil, nil
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos = true, input.Position, main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)

    show("Player")
    notify("FENIX carregado com sucesso!")
end
