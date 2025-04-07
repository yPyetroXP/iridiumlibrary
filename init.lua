-- Iridium Library - Init
local Core = {}

-- Tema padrão (pode ser modificado pelo usuário)
Core.Theme = {
    Accent = Color3.fromRGB(100, 0, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

-- Carrega o arquivo principal da library
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/yPyetroXP/iridiumlibrary/main/core/main.lua"))()
end)

if success and type(result) == "function" then
    result(Core) -- passa o Core para ser preenchido pela main.lua
else
    warn("[Iridium] Falha ao carregar main.lua:", result)
end

return Core
