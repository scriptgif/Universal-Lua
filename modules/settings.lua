-- UNIVERSAL LUA TEST
-- Settings Module V3.0

local Settings = {}

Settings.Config = {
    Theme = "BlackRed",
    Notifications = true,
    ShowPlayerInfo = true,
    WindowVisible = true
}

function Settings.Get(key)
    return Settings.Config[key]
end

function Settings.Set(key, value)
    if Settings.Config[key] == nil then
        return false
    end

    Settings.Config[key] = value
    return true
end

function Settings.GetAll()
    return Settings.Config
end

return Settings
