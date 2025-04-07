local Http = game:HttpGet
local repo = "https://raw.githubusercontent.com/yPyetroXP/iridiumlibrary/main/"

local Core = loadstring(Http(repo .. "core/main.lua"))()
loadstring(Http(repo .. "core/components.lua"))(Core)

return Core
