
-- UNIVERSAL LUA
-- Notifications Module V3.0

local NotificationModule = {}

function NotificationModule.Notify(message)
    if not message then
        return
    end

    print("[ULT Notification] " .. tostring(message))
end

function NotificationModule.Warning(message)
    warn("[ULT Warning] " .. tostring(message))
end

return NotificationModule
