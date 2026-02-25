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

local hookfunction = hookfunction or replaceclosure
local newcclosure = newcclosure or function(f) return f end
local getgc = getgc or function() return {} end

local k
k = hookfunction(p.Kick, newcclosure(function(self, ...)
    if not checkcaller() then
        if typeof(self) ~= "Instance" or self.ClassName ~= "Player" then
            return k(self, ...)
        end
        if self == p then
            return
        end
    end
    return k(self, ...)
end))

pcall(function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" then
            pcall(function()
                if rawget(v, "Send") and type(rawget(v, "Send")) == "function" and rawget(v, "Get") and rawget(v, "Encrypt") then
                    local s_send
                    s_send = hookfunction(v.Send, newcclosure(function(cmd, ...)
                        if type(cmd) == "string" then
                            local c = string.lower(cmd)
                            if c == "detected" or c == "logerror" then
                                return
                            end
                        end
                        return s_send(cmd, ...)
                    end))
                end
                
                if rawget(v, "Kill") and type(rawget(v, "Kill")) == "function" and rawget(v, "Disconnect") then
                    hookfunction(v.Kill, newcclosure(function(...) return end))
                    hookfunction(v.Disconnect, newcclosure(function(...) return end))
                end
            end)
        end
    end
end)            if type(val) == "table" then
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
