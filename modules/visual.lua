-- UNIVERSAL LUA TEST
-- Visual Module V3.0

local VisualModule = {}

VisualModule.Settings = {
    Theme = "BlackRed",
    AccentColor = Color3.fromRGB(220, 35, 55),
    BackgroundColor = Color3.fromRGB(13, 13, 17),
    TextColor = Color3.fromRGB(245, 245, 250)
}

function VisualModule.GetSettings()
    return VisualModule.Settings
end

function VisualModule.SetAccentColor(color)
    if typeof(color) ~= "Color3" then
        return false
    end

    VisualModule.Settings.AccentColor = color
    return true
end

return VisualModule
