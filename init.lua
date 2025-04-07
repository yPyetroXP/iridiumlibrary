local Core = {}
Core.Theme = {
    Accent = Color3.fromRGB(100, 0, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/yPyetroXP/iridiumlibrary/main/core/main.lua"))()(Core)

return Core
