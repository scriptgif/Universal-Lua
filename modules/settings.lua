
-- UNIVERSAL LUA
-- Settings Module V3.0

local Settings = {}

Settings.Config = {
    Theme = "BlackRed",
    Notifications = true,
    ShowPlayerInfo = true,
    WindowVisible = true,
    WindowPosition = UDim2.new(0.5, -250, 0.5, -175)
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
