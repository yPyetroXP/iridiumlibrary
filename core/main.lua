local TweenService = game:GetService("TweenService")

local Iridium = {}

local function CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "IridiumUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Iridium"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local TabsContainer = Instance.new("Frame")
    TabsContainer.Position = UDim2.new(0, 0, 0, 40)
    TabsContainer.Size = UDim2.new(0, 150, 1, -40)
    TabsContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.Parent = MainFrame

    local TabList = Instance.new("UIListLayout", TabsContainer)
    TabList.Padding = UDim.new(0, 5)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Position = UDim2.new(0, 150, 0, 40)
    ContentFrame.Size = UDim2.new(1, -150, 1, -40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ClipsDescendants = true
    ContentFrame.Parent = MainFrame

    local Tabs = {}

    local function CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.Parent = TabsContainer

        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = ContentFrame

        Tabs[name] = TabContent

        TabButton.MouseButton1Click:Connect(function()
            for tabName, content in pairs(Tabs) do
                content.Visible = (tabName == name)
            end
        end)

        local Components = require(script.Parent:WaitForChild("components"))
        return Components.CreateSection(TabContent)
    end

    return {
        CreateTab = CreateTab
    }
end

-- 🔧 Correção: expõe o método CreateWindow na tabela Iridium
Iridium.CreateWindow = CreateWindow
return Iridium
