
-- UNIVERSAL LUA
-- Loader V3.0

local BASE_URL = "https://raw.githubusercontent.com/scriptgif/Universal-Lua/refs/heads/main/"

local function LoadModule(path)
    local url = BASE_URL .. path

    local success, result = pcall(function()
        local source = game:HttpGet(url)
        return loadstring(source)()
    end)

    if not success then
        warn("[ULT] Erro ao carregar " .. path .. ": " .. tostring(result))
        return nil
    end

    print("[ULT] Carregado: " .. path)
    return result
end

local Interface = LoadModule("interface.lua")

if Interface then
    print("[ULT] Universal Lua iniciado!")
end
