local M = {}
local callback
function M.SetCallback(fn) callback = fn end
function M.Notify(message)
    if callback then callback(tostring(message)) else print("[FENIX] " .. tostring(message)) end
end
return M
