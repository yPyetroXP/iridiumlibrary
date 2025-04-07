local HttpService = game:GetService("HttpService")

local Iridium = {
    Theme = {
        Background = Color3.fromRGB(25, 25, 25),
        Accent = Color3.fromRGB(0, 170, 255),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

function Iridium:CreateWindow(options)
    local title = options.Title or "Iridium UI"
    print("[Iridium] Janela criada: " .. title)

    local Window = {}

    function Window:AddTab(name)
        print("[Iridium] Aba adicionada: " .. name)

        local Tab = {}

        function Tab:AddSection(sectionName)
            print("[Iridium] Seção adicionada: " .. sectionName)

            -- Aqui você criaria o container visual da seção
            local Section = Instance.new("Frame")
            Section.Name = sectionName
            Section.Size = UDim2.new(1, 0, 0, 100)
            Section.BackgroundTransparency = 1

            return Section
        end

        return Tab
    end

    return Window
end

-- Carrega components.lua, se disponível
local success, components = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/yPyetroXP/iridiumlibrary/main/components.lua"))()
end)

if success and components then
    components(Iridium)
else
    warn("[Iridium] Falha ao carregar components.lua: HTTP 404 (Not Found)")
end

return Iridium
