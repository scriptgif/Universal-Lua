-- UNIVERSAL LUA TEST
-- Notifications Module V3.0

local NotificationModule = {}
local handler

function NotificationModule.SetHandler(callback)
    if type(callback) == "function" then
        handler = callback
    end
end

function NotificationModule.Notify(message)
    if handler then
        handler(tostring(message))
    else
        print("[ULT Notification] " .. tostring(message))
    end
end

function NotificationModule.Warning(message)
    warn("[ULT Warning] " .. tostring(message))
end

return NotificationModule
