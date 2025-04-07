local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Iridium = {}

Iridium.Theme = {
    Background = Color3.fromRGB(24, 24, 24),
    TabInactive = Color3.fromRGB(40, 40, 40),
    TabActive = Color3.fromRGB(60, 60, 60),
    Accent = Color3.fromRGB(0, 120, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

local function Tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

function Iridium:CreateWindow(title)
    local screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
    screen.Name = "IridiumUI_" .. title

    local main = Instance.new("Frame", screen)
    main.Size = UDim2.new(0, 500, 0, 350)
    main.Position = UDim2.new(0.5, -250, 0.5, -175)
    main.BackgroundColor3 = self.Theme.Background
    main.BorderSizePixel = 0
    main.Name = "Main"
    main.AnchorPoint = Vector2.new(0.5, 0.5)

    local titleBar = Instance.new("TextLabel", main)
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.Text = title
    titleBar.Font = Enum.Font.GothamBold
    titleBar.TextSize = 16
    titleBar.TextColor3 = self.Theme.Text
    titleBar.BackgroundColor3 = self.Theme.Accent
    titleBar.BorderSizePixel = 0
    titleBar.Name = "TitleBar"

    local tabHolder = Instance.new("Frame", main)
    tabHolder.Size = UDim2.new(0, 120, 1, -35)
    tabHolder.Position = UDim2.new(0, 0, 0, 35)
    tabHolder.BackgroundColor3 = self.Theme.TabInactive
    tabHolder.BorderSizePixel = 0
    tabHolder.Name = "TabHolder"

    local pageHolder = Instance.new("Frame", main)
    pageHolder.Size = UDim2.new(1, -120, 1, -35)
    pageHolder.Position = UDim2.new(0, 120, 0, 35)
    pageHolder.BackgroundTransparency = 1
    pageHolder.Name = "PageHolder"

    local tabList = Instance.new("UIListLayout", tabHolder)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 4)

    function Iridium:CreateTab(tabName)
        local tabButton = Instance.new("TextButton", tabHolder)
        tabButton.Size = UDim2.new(1, 0, 0, 30)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = self.Theme.TabInactive
        tabButton.TextColor3 = self.Theme.Text
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.BorderSizePixel = 0

        local page = Instance.new("ScrollingFrame", pageHolder)
        page.Visible = false
        page.Size = UDim2.new(1, 0, 1, 0)
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollBarThickness = 6
        page.ScrollBarImageColor3 = self.Theme.Accent
        page.BackgroundTransparency = 1
        page.Name = tabName

        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        tabButton.MouseButton1Click:Connect(function()
            for _, v in ipairs(pageHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            for _, b in ipairs(tabHolder:GetChildren()) do
                if b:IsA("TextButton") then
                    Tween(b, {BackgroundColor3 = self.Theme.TabInactive})
                end
            end
            Tween(tabButton, {BackgroundColor3 = self.Theme.TabActive})
            page.Visible = true
        end)

        function page:CreateSection(sectionTitle)
            local section = Instance.new("Frame")
            section.Size = UDim2.new(1, -20, 0, 0)
            section.Position = UDim2.new(0, 10, 0, 10)
            section.BackgroundTransparency = 1
            section.BorderSizePixel = 0
            section.Parent = page

            local layout = Instance.new("UIListLayout", section)
            layout.Padding = UDim.new(0, 6)
            layout.SortOrder = Enum.SortOrder.LayoutOrder

            local label = Instance.new("TextLabel", section)
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Text = sectionTitle
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.TextColor3 = Iridium.Theme.Text
            label.BackgroundTransparency = 1
            label.TextXAlignment = Enum.TextXAlignment.Left

            section.Size = UDim2.new(1, -20, 0, 25)

            function section:_UpdateHeight()
                local total = 0
                for _, c in pairs(section:GetChildren()) do
                    if c:IsA("GuiObject") then
                        total = total + c.AbsoluteSize.Y + layout.Padding.Offset
                    end
                end
                section.Size = UDim2.new(1, -20, 0, total)
            end

            return setmetatable({}, {
                __index = function(_, key)
                    return Iridium["Add" .. key] and function(_, ...)
                        Iridium["Add" .. key](Iridium, section, ...)
                        section:_UpdateHeight()
                    end
                end
            })
        end

        return page
    end

    return setmetatable({}, {
        __index = function(_, key)
            return Iridium[key]
        end
    })
end

return Iridium
