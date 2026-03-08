local a1 = getfenv().getgc or getgc
local b1 = getfenv().hookfunction or hookfunction
local c1 = getfenv().newcclosure or function(f) return f end
local d1 = getfenv().hookmetamethod or hookmetamethod
local e1 = debug.getinfo or getfenv().getinfo
local f1 = debug.getconstants or getfenv().getconstants
local g1 = getfenv().iscclosure or function() return false end
local h1 = getfenv().getnamecallmethod or getnamecallmethod

local i1
i1 = b1(setmetatable, c1(function(j1, k1)
    if type(k1) == "table" then
        local l1 = 0
        local m1 = nil
        for n1, o1 in pairs(k1) do
            if type(n1) == "string" and string.sub(n1, 1, 2) == "__" and type(o1) == "function" then
                if not m1 then m1 = o1 end
                if m1 == o1 then l1 = l1 + 1 end
            end
        end
        if l1 >= 4 then
            for n1, o1 in pairs(k1) do
                if type(n1) == "string" and string.sub(n1, 1, 2) == "__" then
                    k1[n1] = c1(function() end)
                end
            end
        end
    end
    return i1(j1, k1)
end))

local function p1(q1)
    if type(q1) ~= "function" or g1(q1) then return false end
    local r1, s1 = pcall(e1, q1)
    if not r1 or not s1 then return false end
    if s1.nups == 0 and s1.numparams == 0 then
        local t1, u1 = pcall(f1, q1)
        if t1 and type(u1) == "table" and #u1 == 0 then return true end
    end
    return false
end

local function v1(q1)
    if p1(q1) then return c1(function() end) end
    return q1
end

local w1
w1 = b1(task.spawn, c1(function(q1, ...)
    q1 = type(q1) == "thread" and q1 or v1(q1)
    return w1(q1, ...)
end))

local x1
x1 = b1(task.defer, c1(function(q1, ...)
    q1 = type(q1) == "thread" and q1 or v1(q1)
    return x1(q1, ...)
end))

local y1
y1 = b1(task.delay, c1(function(z1, q1, ...)
    q1 = type(q1) == "thread" and q1 or v1(q1)
    return y1(z1, q1, ...)
end))

local A1
A1 = b1(coroutine.create, c1(function(q1)
    return A1(v1(q1))
end))

local B1
B1 = b1(coroutine.wrap, c1(function(q1)
    return B1(v1(q1))
end))

local C1
C1 = b1(d1(game, "__namecall", c1(function(self, ...)
    local D1 = h1()
    local E1 = {...}
    if (D1 == "Connect" or D1 == "connect") and type(E1[1]) == "function" then
        E1[1] = v1(E1[1])
        return C1(self, unpack(E1))
    end
    return C1(self, ...)
end)), c1(function() end))

task.spawn(function()
    for _, F1 in a1(true) do
        if type(F1) == "function" and p1(F1) then
            b1(F1, c1(function() end))
        end
    end
end)

local p = game:GetService("Players").LocalPlayer
local R = {}

local function F(r)
    if R[r] then return true end
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
    if F(s) then return o(s, ...) end
    for _, v in ipairs(a) do
        if type(v) == "string" and string.find(string.lower(v), "kick") then return end
    end
    return o(s, ...)
end)

local n
n = hookmetamethod(game, "__namecall", function(s, ...)
    if s == p and getnamecallmethod():lower() == "kick" then return end
    return n(s, ...)
end)

local k
k = hookfunction(p.Kick, newcclosure(function(self, ...)
    if not checkcaller() then
        if typeof(self) ~= "Instance" or self.ClassName ~= "Player" then return k(self, ...) end
        if self == p then return end
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
                            if c == "detected" or c == "logerror" then return end
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
end)
