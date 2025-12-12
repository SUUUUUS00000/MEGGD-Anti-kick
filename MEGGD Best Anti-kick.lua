local p = game:GetService("Players").LocalPlayer

local R = {}

local function F(r)
    if R[r] then
        return true
    end

    local n = r.Name
    if #n == 36 and string.match(n, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        R[r] = true
        return true
    end

    return false
end

local o
o = hookfunction(Instance.new("RemoteEvent").FireServer, function(s, ...)
    local a = {...}
    
    if F(s) then
        return o(s, ...)
    end
    
    for _, v in ipairs(a) do
        if type(v) == "string" and string.find(string.lower(v), "kick") then
            return
        end
    end
    
    return o(s, ...)
end)

local n
n = hookmetamethod(game, "__namecall", function(s, ...)
    if s == p and getnamecallmethod():lower() == "kick" then
        return
    end
    return n(s, ...)
end)

local k
k = hookfunction(p.Kick, function(s, ...)
    if s == p then
        return
    end
    return k(s, ...)
end)

local g = getgc or function() return {} end
local u = debug.getupvalues or getupvalues
local s = debug.setupvalue or setupvalue
local h = hookfunction or replaceclosure
local n = newcclosure or function(f) return f end

local found = false

for _, func in pairs(g()) do
    if type(func) == "function" then
        local upvalues = u(func)
        for i, val in pairs(upvalues) do
            if type(val) == "table" then
                if rawget(val, "namecallInstance") or rawget(val, "indexInstance") then
                    s(func, i, {})
                    found = true
                end
            end
        end
    end
end

for _, v in pairs(g(true)) do
    if type(v) == "table" and rawget(v, "Remote") and rawget(v, "Anti") then
        if v.Remote and v.Remote.Send then
            local originalSend = v.Remote.Send
            h(v.Remote.Send, n(function(...)
                local args = {...}
                local method = tostring(args[2] or "")
                if method:lower():find("detect") or method:lower():find("kick") then
                    return
                end
                return originalSend(...)
            end))
        end
    end
end