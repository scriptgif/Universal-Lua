-- UNIVERSAL LUA TEST
-- Loader V3.0 - Modular Edition

local BASE_URL = "https://raw.githubusercontent.com/scriptgif/Universal-Lua/refs/heads/main/"

local function LoadModule(path)
    local ok, result = pcall(function()
        local source = game:HttpGet(BASE_URL .. path)
        local chunk, compileError = loadstring(source)
        assert(chunk, compileError or "Falha ao compilar " .. path)
        return chunk()
    end)

    if not ok then
        warn("[ULT] Falha ao carregar " .. path .. ": " .. tostring(result))
        return nil
    end

    return result
end

local Modules = {
    Player = LoadModule("modules/player.lua"),
    Visual = LoadModule("modules/visual.lua"),
    Movement = LoadModule("modules/movement.lua"),
    Settings = LoadModule("modules/settings.lua"),
    Notifications = LoadModule("modules/notifications.lua")
}

for name, module in pairs(Modules) do
    if type(module) ~= "table" then
        warn("[ULT] Módulo inválido ou ausente: " .. name)
        return
    end
end

local interface = LoadModule("interface.lua")
if type(interface) ~= "function" then
    warn("[ULT] interface.lua não retornou uma função")
    return
end

local ok, err = pcall(interface, Modules)
if not ok then
    warn("[ULT] Erro ao iniciar interface: " .. tostring(err))
end
