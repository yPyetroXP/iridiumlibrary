local Iridium = {}
Iridium.__index = Iridium

-- Cria uma nova janela (Window)
function Iridium:CreateWindow(config)
    local Window = setmetatable({}, Iridium)
    Window.Title = config.Title or "Iridium"
    Window.Tabs = {}
    
    -- Aqui você pode adicionar lógica de criação real da UI, se desejar.
    print("[Iridium] Janela criada:", Window.Title)

    return Window
end

-- Cria uma nova Tab
function Iridium:AddTab(tabName)
    local tab = {
        Name = tabName,
        Elements = {}
    }
    table.insert(self.Tabs, tab)
    print("[Iridium] Aba adicionada:", tabName)
    return tab
end

-- Carrega os componentes
local success, components = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/yPyetroXP/iridiumlibrary/main/components.lua"))()
end)

if success and type(components) == "function" then
    components(Iridium)
else
    warn("[Iridium] Falha ao carregar components.lua:", components)
end

return Iridium
