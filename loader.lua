-- FENIX HUB | Loader
local BASE_URL = "https://raw.githubusercontent.com/scriptgif/Universal-Lua/refs/heads/main/"

local function loadModule(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(BASE_URL .. path))()
    end)
    if not ok then
        warn("[FENIX] Falha ao carregar " .. path .. ": " .. tostring(result))
        return nil
    end
    return result
end

local modules = {
    Player = loadModule("modules/player.lua"),
    Settings = loadModule("modules/settings.lua"),
    Movement = loadModule("modules/movement.lua"),
    Visual = loadModule("modules/visual.lua"),
    Notifications = loadModule("modules/notifications.lua")
}
for name, value in pairs(modules) do
    if not value then
        warn("[FENIX] Módulo ausente: " .. name)
        return
    end
end

local start = loadModule("interface.lua")
if type(start) == "function" then
    start(modules)
else
    warn("[FENIX] interface.lua não retornou uma função.")
end
