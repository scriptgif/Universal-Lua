-- FENIX HUB V2.0 | interface leve e responsiva
return function(Modules)
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local C = Modules.Visual.Palette
    pcall(function() local old=playerGui:FindFirstChild("FenixHub"); if old then old:Destroy() end end)

    local function make(class, props, parent)
        local o=Instance.new(class); for k,v in pairs(props or {}) do o[k]=v end; o.Parent=parent; return o
    end
    local function corner(o,r) make("UICorner",{CornerRadius=UDim.new(0,r or 9)},o) end
    local function stroke(o,color,t) make("UIStroke",{Color=color or C.Red,Thickness=t or 1,Transparency=.25},o) end
    local function label(parent,txt,size,pos,fs,color)
        return make("TextLabel",{BackgroundTransparency=1,Text=txt,Size=size,Position=pos,Font=Enum.Font.GothamSemibold,TextSize=fs or 13,TextColor3=color or C.White,TextXAlignment=Enum.TextXAlignment.Left},parent)
    end
    local gui=make("ScreenGui",{Name="FenixHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},playerGui)
    local main=make("Frame",{Name="Main",Size=UDim2.fromOffset(760,500),Position=UDim2.new(.5,-380,.5,-250),BackgroundColor3=C.Background,BorderSizePixel=0},gui); corner(main,15); stroke(main,C.Red,1.5)
    local top=make("Frame",{Size=UDim2.new(1,0,0,86),BackgroundColor3=Color3.fromRGB(24,12,17),BorderSizePixel=0},main); corner(top,15)
    label(top,"FENIX HUB",UDim2.fromOffset(280,42),UDim2.fromOffset(22,12),29,C.White)
    label(top,"VOE MAIS ALTO  •  V2.0",UDim2.fromOffset(280,20),UDim2.fromOffset(25,52),11,C.Orange)
    label(top,"✦",UDim2.fromOffset(40,44),UDim2.new(1,-92,0,18),30,C.Orange)
    local close=make("TextButton",{Size=UDim2.fromOffset(34,30),Position=UDim2.new(1,-48,0,12),Text="—",TextSize=20,TextColor3=C.White,BackgroundColor3=Color3.fromRGB(75,22,30)},top); corner(close,7)
    local sidebar=make("Frame",{Position=UDim2.fromOffset(12,98),Size=UDim2.new(0,158,1,-110),BackgroundColor3=C.Panel,BorderSizePixel=0},main); corner(sidebar,10)
    local content=make("Frame",{Position=UDim2.fromOffset(180,98),Size=UDim2.new(1,-192,1,-110),BackgroundColor3=C.Panel,BorderSizePixel=0},main); corner(content,10)
    local title=label(content,"INÍCIO",UDim2.new(1,-24,0,32),UDim2.fromOffset(15,12),20,C.Orange)
    local page=make("ScrollingFrame",{Position=UDim2.fromOffset(12,52),Size=UDim2.new(1,-24,1,-62),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,CanvasSize=UDim2.new()},content)
    local list=make("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},page)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() page.CanvasSize=UDim2.fromOffset(0,list.AbsoluteContentSize.Y+8) end)
    local toast=make("TextLabel",{Size=UDim2.fromOffset(260,36),Position=UDim2.new(.5,-130,1,-48),BackgroundColor3=C.Card,TextColor3=C.White,TextSize=12,Font=Enum.Font.GothamSemibold,Visible=false,Text=""},gui); corner(toast,8); stroke(toast,C.Red)
    local toastId=0
    local function notify(msg)
        if not Modules.Settings.Get("Notifications") then return end
        toastId=toastId+1; local id=toastId; toast.Text=tostring(msg); toast.Visible=true
        task.delay(2,function() if toast.Parent and id==toastId then toast.Visible=false end end)
    end
    Modules.Notifications.SetCallback(notify)
    local function clear() for _,v in ipairs(page:GetChildren()) do if v~=list then v:Destroy() end end end
    local function card(head,desc)
        local f=make("Frame",{Size=UDim2.new(1,-4,0,62),BackgroundColor3=C.Card,BorderSizePixel=0},page); corner(f,8)
        make("Frame",{Size=UDim2.new(0,3,1,-16),Position=UDim2.fromOffset(0,8),BackgroundColor3=C.Red,BorderSizePixel=0},f)
        label(f,head,UDim2.new(1,-24,0,22),UDim2.fromOffset(13,7),13,C.White)
        label(f,desc,UDim2.new(1,-24,0,24),UDim2.fromOffset(13,31),11,C.Muted); return f
    end
    local function button(txt,fn)
        local b=make("TextButton",{Size=UDim2.new(1,-4,0,39),BackgroundColor3=Color3.fromRGB(67,20,29),Text=txt,TextColor3=C.White,TextSize=12,Font=Enum.Font.GothamSemibold},page); corner(b,7); stroke(b,C.Red,1); b.MouseButton1Click:Connect(fn); return b
    end
    local function toggle(txt,default,fn)
        local row=make("Frame",{Size=UDim2.new(1,-4,0,42),BackgroundColor3=C.Card,BorderSizePixel=0},page); corner(row,7)
        label(row,txt,UDim2.new(1,-78,1,0),UDim2.fromOffset(12,0),12,C.White)
        local state=default and true or false
        local b=make("TextButton",{Size=UDim2.fromOffset(48,24),Position=UDim2.new(1,-60,.5,-12),BackgroundColor3=state and C.Red or Color3.fromRGB(72,68,75),Text=state and "ON" or "OFF",TextColor3=C.White,TextSize=10,Font=Enum.Font.GothamBold},row); corner(b,12)
        b.MouseButton1Click:Connect(function() state=not state; b.Text=state and "ON" or "OFF"; b.BackgroundColor3=state and C.Red or Color3.fromRGB(72,68,75); if fn then fn(state) end end)
    end
    local function slider(txt,min,max,value,apply)
        local row=make("Frame",{Size=UDim2.new(1,-4,0,68),BackgroundColor3=C.Card,BorderSizePixel=0},page); corner(row,8)
        local val=math.clamp(tonumber(value) or min,min,max)
        label(row,txt,UDim2.new(1,-70,0,22),UDim2.fromOffset(12,6),12,C.White)
        local number=label(row,tostring(math.floor(val)),UDim2.fromOffset(48,22),UDim2.new(1,-58,0,6),12,C.Orange); number.TextXAlignment=Enum.TextXAlignment.Right
        local bar=make("Frame",{Position=UDim2.fromOffset(12,42),Size=UDim2.new(1,-24,0,7),BackgroundColor3=Color3.fromRGB(65,58,66),BorderSizePixel=0},row); corner(bar,5)
        local fill=make("Frame",{Size=UDim2.new((val-min)/(max-min),0,1,0),BackgroundColor3=C.Red,BorderSizePixel=0},bar); corner(fill,5)
        local knob=make("Frame",{Size=UDim2.fromOffset(15,15),AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new((val-min)/(max-min),0,.5,0),BackgroundColor3=C.Orange,BorderSizePixel=0},bar); corner(knob,8)
        local hit=make("TextButton",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,31),BackgroundTransparency=1,Text="",TextTransparency=1},row)
        local dragging=false
        local function setAt(x)
            local pct=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); val=math.floor(min+(max-min)*pct+.5)
            fill.Size=UDim2.new(pct,0,1,0); knob.Position=UDim2.new(pct,0,.5,0); number.Text=tostring(val)
        end
        hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; setAt(i.Position.X) end end)
        UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setAt(i.Position.X) end end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
        return function() return val end
    end
    local floating
    local function show(tab)
        clear(); title.Text=tab
        if tab=="INÍCIO" then
            card("Bem-vindo ao FENIX HUB","Uma interface leve, organizada e feita para evoluir.")
            card("Aviso importante","Use somente em experiências próprias ou com autorização. Ferramentas não autorizadas podem gerar punições.")
            card("Novidades V2.0","Interface renovada, controles de movimento por slider e configurações reunidas.")
            button("Ver informações do jogador",function() show("CONFIGURAÇÕES") end)
        elseif tab=="REDES SOCIAIS" then
            card("Comunidade FENIX","Acesse os canais oficiais da comunidade.")
            button("Abrir Discord",function() local ok=pcall(function() if setclipboard then setclipboard("https://discord.gg/Vm9DxuDmJm") end end); notify(ok and "Convite copiado, abra seu navegador/Discord" or "Convite: discord.gg/Vm9DxuDmJm") end)
            card("Convite","discord.gg/Vm9DxuDmJm")
        elseif tab=="MOVIMENTO" then
            card("Controles locais","Somente para experiências próprias ou ambientes autorizados.")
            local current=Modules.Movement.Get() or {WalkSpeed=16,JumpPower=50}
            local getWS=slider("Velocidade",0,100,current.WalkSpeed)
            local getJP=slider("Força do pulo",0,150,current.JumpPower)
            button("APLICAR ALTERAÇÕES",function() local ok=Modules.Movement.Apply(getWS(),getJP()); notify(ok and "Movimento aplicado" or "Não foi possível aplicar") end)
            button("RESTAURAR PADRÃO",function() Modules.Movement.Reset(); show("MOVIMENTO"); notify("Valores padrão restaurados") end)
        elseif tab=="COMBAT" then
            card("Área de testes","Ferramentas de interface para desenvolvimento autorizado.")
            toggle("Mostrar círculo FOV (visual)",false,function(v) notify(v and "Indicador visual ativado" or "Indicador visual desativado") end)
            toggle("Informações de alvo (demo)",false,function(v) notify(v and "Painel demonstrativo ligado" or "Painel demonstrativo desligado") end)
            card("Limite","Sem mira automática, seleção de vítimas ou automação de combate em jogos de terceiros.")
        elseif tab=="VISUAL" then
            card("Personalização","Opções visuais leves da interface.")
            toggle("Notificações",Modules.Settings.Get("Notifications"),function(v) Modules.Settings.Set("Notifications",v) end)
            toggle("Modo compacto",Modules.Settings.Get("Compact"),function(v) Modules.Settings.Set("Compact",v); notify("Preferência salva nesta sessão") end)
            card("Recursos visuais","ESP e marcações de jogadores exigem implementação no código da experiência própria; não são ativados como cheat universal.")
        elseif tab=="CONFIGURAÇÕES" then
            local info=Modules.Player.GetInfo()
            card("Jogador",info.DisplayName.."  ( @"..info.Username.." )")
            card("Identificação","User ID: "..tostring(info.UserId))
            card("Personagem","Vida: "..info.Health.."/"..info.MaxHealth.."  •  Velocidade: "..tostring(info.WalkSpeed))
            button("ATUALIZAR INFORMAÇÕES",function() show("CONFIGURAÇÕES"); notify("Informações atualizadas") end)
            toggle("Contador de FPS",false,function(v) if v then
                local fpsLabel=label(gui,"FPS: --",UDim2.fromOffset(100,22),UDim2.new(1,-112,0,12),12,C.Orange)
                local frames,last=0,os.clock(); local conn; conn=RunService.RenderStepped:Connect(function(dt) if not fpsLabel.Parent then conn:Disconnect(); return end; frames=frames+1; if os.clock()-last>=1 then fpsLabel.Text="FPS: "..frames; frames=0; last=os.clock() end end)
            else for _,o in ipairs(gui:GetChildren()) do if o:IsA("TextLabel") and o.Text:match("^FPS:") then o:Destroy() end end end end)
            button("MINIMIZAR HUB",function() main.Visible=false; floating.Visible=true end)
            button("RESTAURAR POSIÇÃO",function() main.Position=UDim2.new(.5,-380,.5,-250); notify("Posição restaurada") end)
        end
    end
    floating=make("TextButton",{Name="FenixButton",Size=UDim2.fromOffset(54,54),Position=UDim2.new(0,16,.5,-27),BackgroundColor3=C.Background,Text="🔥",TextSize=27,TextColor3=C.White,Visible=false},gui); corner(floating,27); stroke(floating,C.Red,2)
    local tabs={"INÍCIO","REDES SOCIAIS","COMBAT","MOVIMENTO","VISUAL","CONFIGURAÇÕES"}
    for i,name in ipairs(tabs) do
        local b=make("TextButton",{Name=name,Size=UDim2.new(1,-14,0,42),Position=UDim2.fromOffset(7,9+(i-1)*49),BackgroundColor3=C.Card,Text=name,TextColor3=C.White,TextSize=10,Font=Enum.Font.GothamSemibold},sidebar); corner(b,7)
        b.MouseButton1Click:Connect(function() show(name) end)
    end
    close.MouseButton1Click:Connect(function() main.Visible=false; floating.Visible=true end)
    floating.MouseButton1Click:Connect(function() main.Visible=true; floating.Visible=false end)
    local dragging,dragStart,startPos=false,nil,nil
    top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; dragStart=i.Position; startPos=main.Position end end)
    UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-dragStart; main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
    local function resize()
        local cam=workspace.CurrentCamera; if not cam then return end; local v=cam.ViewportSize
        local w=math.min(760,math.max(310,v.X-20)); local h=math.min(500,math.max(300,v.Y-30))
        main.Size=UDim2.fromOffset(w,h); main.Position=UDim2.new(.5,-w/2,.5,-h/2)
        local side=math.clamp(math.floor(w*.21),104,158); sidebar.Size=UDim2.new(0,side,1,-110); content.Position=UDim2.fromOffset(side+22,98); content.Size=UDim2.new(1,-side-34,1,-110)
    end
    resize(); if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize) end
    show("INÍCIO"); notify("FENIX HUB V2.0 carregado")
end
