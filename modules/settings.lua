local M = {}
M.Values = {
    Accent = Color3.fromRGB(235, 25, 42),
    Notifications = true,
    Compact = false
}
function M.Get(key) return M.Values[key] end
function M.Set(key, value)
    if M.Values[key] == nil then return false end
    M.Values[key] = value
    return true
end
return M
