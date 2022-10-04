-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- AtlantisRP  This is the system bulletin ReWork we worked back on the design to create a special script to do something special out of it please do not leak or else there will be consequences 
-- Created by Tarek#0666
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local notifications = {}

function Send(message, timeout, position, progress, theme, title, subject, icon)

        title = string.upper(title)
        subject = string.upper(subject)

        if message == nil then
            return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
        end

        if type(message) == "number" then
            message = tostring(message)
        end

        if title == nil then
            title = ""
            -- return PrintError("^1BULLETIN ERROR: ^7Notification title is nil")
        end
        
        if subject == nil then
            subject = ""
            -- return PrintError("^1BULLETIN ERROR: ^7Notification subject is nil")
        end    

        if not tonumber(timeout) then
            timeout = Config.Timeout
        end
        
        if position == nil then
            position = Config.Position
        end
        
        if progress == nil then
            progress = false
        end  

        local id = nil
        local duplicateID = DuplicateCheck(message)

        if duplicateID then
            id = duplicateID
        else
            id = uuid(message)
            notifications[id] = message
        end

        AddNotification({
            duplicate   = duplicateID ~= false,
            id          = id,
            type        = "advanced",
            message     = message,
            title       = title,
            subject     = subject,
            icon        = Config.Icons[icon],
            banner      = Config.Pictures["CHAR_ABIGAIL"],
            timeout     = timeout,
            position    = position,
            progress    = progress,
            theme       = theme,
        })
    -- end
end

function SendSuccess(message, timeout, position, progress)
    Send(message, timeout, position, progress, "success")
end

function SendInfo(message, timeout, position, progress)
    Send(message, timeout, position, progress, "info")
end

function SendWarning(message, timeout, position, progress)
    Send(message, timeout, position, progress, "warning")
end

function SendError(message, timeout, position, progress)
    Send(message, timeout, position, progress, "error")
end

function SendAdvanced(message, title, subject, banner, timeout, position, progress, theme, icon)

    -- if exports.zCore:IsAnyMenuOpenned() then
    --     Citizen.CreateThread(function()
    --         while exports.zCore:IsAnyMenuOpenned() do
    --             Wait(100)
    --         end

    --         title = string.upper(title)
    --         subject = string.upper(subject)
        
    --         if message == nil then
    --             return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
    --         end
        
    --         if type(message) == "number" then
    --             message = tostring(message)
    --         end
        
    --         if title == nil then
    --             title = ""
    --             -- return PrintError("^1BULLETIN ERROR: ^7Notification title is nil")
    --         end
            
    --         if subject == nil then
    --             subject = ""
    --             -- return PrintError("^1BULLETIN ERROR: ^7Notification subject is nil")
    --         end
        
    --         if not tonumber(timeout) then
    --             timeout = Config.Timeout
    --         end
            
    --         if position == nil then
    --             position = Config.Position
    --         end
            
    --         if progress == nil then
    --             progress = false
    --         end  
        
    --         local id = nil
    --         local duplicateID = DuplicateCheck(message)
        
    --         if duplicateID then
    --             id = duplicateID
    --         else
    --             id = uuid(message)
    --             notifications[id] = message
    --         end
        
    --         AddNotification({
    --             duplicate   = duplicateID ~= false,
    --             id          = id,
    --             type        = "advanced",
    --             message     = message,
    --             title       = title,
    --             subject     = subject,
    --             icon        = Config.Icons[icon],
    --             banner      = Config.Pictures[banner],
    --             timeout     = timeout,
    --             position    = position,
    --             progress    = progress,
    --             theme       = theme,
    --         })
    --     end)
    -- else
        title = string.upper(title)
        subject = string.upper(subject)

        if message == nil then
            return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
        end

        if type(message) == "number" then
            message = tostring(message)
        end

        if title == nil then
            title = ""
            -- return PrintError("^1BULLETIN ERROR: ^7Notification title is nil")
        end
        
        if subject == nil then
            subject = ""
            -- return PrintError("^1BULLETIN ERROR: ^7Notification subject is nil")
        end

        if not tonumber(timeout) then
            timeout = Config.Timeout
        end
        
        if position == nil then
            position = Config.Position
        end
        
        if progress == nil then
            progress = false
        end  

        local id = nil
        local duplicateID = DuplicateCheck(message)

        if duplicateID then
            id = duplicateID
        else
            id = uuid(message)
            notifications[id] = message
        end

        AddNotification({
            duplicate   = duplicateID ~= false,
            id          = id,
            type        = "advanced",
            message     = message,
            title       = title,
            subject     = subject,
            icon        = Config.Icons[icon],
            banner      = Config.Pictures[banner],
            timeout     = timeout,
            position    = position,
            progress    = progress,
            theme       = theme,
        })
    -- end
end

function SavePosition(position)
    SetResourceKvp("notif_position", position)
    Config.Position = GetResourceKvpString("notif_position")
end

function AddNotification(data)
    data.config = Config
    SendNUIMessage(data)
end

function PrintError(message)
    local s = string.rep("=", string.len(message))
    print(s)
    print(message)
    print(s)  
end

function DuplicateCheck(message)
    for id, msg in pairs(notifications) do
        if msg == message then
            return id
        end
    end

    return false
end

function uuid(message)
    math.randomseed(GetGameTimer() + string.len(message))
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

RegisterNetEvent("bulletin:send")
AddEventHandler("bulletin:send", Send)

RegisterNetEvent("bulletin:sendAdvanced")
AddEventHandler("bulletin:sendAdvanced", SendAdvanced)

RegisterNetEvent("bulletin:sendSuccess")
AddEventHandler("bulletin:sendSuccess", SendSuccess)

RegisterNetEvent("bulletin:sendInfo")
AddEventHandler("bulletin:sendInfo", SendInfo)

RegisterNetEvent("bulletin:sendWarning")
AddEventHandler("bulletin:sendWarning", SendWarning)

RegisterNetEvent("bulletin:sendError")
AddEventHandler("bulletin:sendError", SendError)

RegisterNetEvent("bulletin:savePosition")
AddEventHandler("bulletin:savePosition", SavePosition)

RegisterNUICallback("nui_removed", function(data, cb)
    notifications[data.id] = nil
    cb('ok')
end)