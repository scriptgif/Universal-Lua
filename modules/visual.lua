
-- UNIVERSAL LUA
-- Visual Module V3.0

local VisualModule = {}

VisualModule.Settings = {
    Theme = "BlackRed",
    AccentColor = Color3.fromRGB(220, 35, 35),
    BackgroundColor = Color3.fromRGB(15, 15, 15),
    TextColor = Color3.fromRGB(255, 255, 255)
}

function VisualModule.GetSettings()
    return VisualModule.Settings
end

function VisualModule.SetAccentColor(color)
    if typeof(color) == "Color3" then
        VisualModule.Settings.AccentColor = color
    end
end

return VisualModule
