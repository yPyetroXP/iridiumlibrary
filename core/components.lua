return function(Iridium)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")

    local function Tween(obj, props, time)
        TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end

    function Iridium:AddButton(section, text, callback)
        local button = Instance.new("TextButton", section)
        button.Size = UDim2.new(1, 0, 0, 30)
        button.Text = text
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.BackgroundColor3 = Iridium.Theme.Accent
        button.TextColor3 = Color3.new(1,1,1)
        button.BorderSizePixel = 0

        button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    function Iridium:AddToggle(section, text, default, callback)
        local holder = Instance.new("Frame", section)
        holder.Size = UDim2.new(1, 0, 0, 30)
        holder.BackgroundTransparency = 1

        local toggle = Instance.new("TextButton", holder)
        toggle.Size = UDim2.new(0, 20, 0, 20)
        toggle.Position = UDim2.new(0, 0, 0.5, -10)
        toggle.BackgroundColor3 = default and Iridium.Theme.Accent or Color3.fromRGB(60, 60, 60)
        toggle.BorderSizePixel = 0
        toggle.Text = ""
        toggle.AutoButtonColor = false

        local label = Instance.new("TextLabel", holder)
        label.Position = UDim2.new(0, 30, 0, 0)
        label.Size = UDim2.new(1, -30, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = Iridium.Theme.Text
        label.Text = text
        label.TextXAlignment = Enum.TextXAlignment.Left

        local state = default

        toggle.MouseButton1Click:Connect(function()
            state = not state
            Tween(toggle, {BackgroundColor3 = state and Iridium.Theme.Accent or Color3.fromRGB(60, 60, 60)})
            pcall(callback, state)
        end)
    end

    function Iridium:AddSlider(section, text, min, max, default, callback)
        local holder = Instance.new("Frame", section)
        holder.Size = UDim2.new(1, 0, 0, 45)
        holder.BackgroundTransparency = 1

        local label = Instance.new("TextLabel", holder)
        label.Size = UDim2.new(1, 0, 0, 20)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = Iridium.Theme.Text
        label.Text = text .. ": " .. default
        label.TextXAlignment = Enum.TextXAlignment.Left

        local bar = Instance.new("Frame", holder)
        bar.Size = UDim2.new(1, 0, 0, 6)
        bar.Position = UDim2.new(0, 0, 1, -10)
        bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        bar.BorderSizePixel = 0

        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
        fill.BackgroundColor3 = Iridium.Theme.Accent
        fill.BorderSizePixel = 0

        local dragging = false

        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local rel = (input.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X
                rel = math.clamp(rel, 0, 1)
                local value = math.floor(min + (max - min) * rel)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                label.Text = text .. ": " .. value
                pcall(callback, value)
            end
        end)
    end

    function Iridium:AddTextbox(section, text, placeholder, callback)
        local box = Instance.new("TextBox", section)
        box.Size = UDim2.new(1, 0, 0, 30)
        box.Text = ""
        box.PlaceholderText = placeholder
        box.Font = Enum.Font.Gotham
        box.TextSize = 14
        box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        box.TextColor3 = Iridium.Theme.Text
        box.BorderSizePixel = 0

        box.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                pcall(callback, box.Text)
            end
        end)
    end

    function Iridium:AddDropdown(section, text, options, callback)
        local holder = Instance.new("Frame", section)
        holder.Size = UDim2.new(1, 0, 0, 30)
        holder.BackgroundTransparency = 1

        local button = Instance.new("TextButton", holder)
        button.Size = UDim2.new(1, 0, 1, 0)
        button.Text = text .. " ▼"
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        button.TextColor3 = Iridium.Theme.Text
        button.BorderSizePixel = 0

        local open = false
        local dropdownItems = {}

        button.MouseButton1Click:Connect(function()
            open = not open
            button.Text = text .. (open and " ▲" or " ▼")

            for _, item in ipairs(dropdownItems) do
                item.Visible = open
            end
        end)

        for _, option in pairs(options) do
            local item = Instance.new("TextButton", section)
            item.Size = UDim2.new(1, 0, 0, 30)
            item.Text = "  " .. option
            item.Font = Enum.Font.Gotham
            item.TextSize = 14
            item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            item.TextColor3 = Iridium.Theme.Text
            item.BorderSizePixel = 0
            item.Visible = false

            item.MouseButton1Click:Connect(function()
                button.Text = text .. ": " .. option
                open = false
                for _, i in ipairs(dropdownItems) do i.Visible = false end
                pcall(callback, option)
            end)

            table.insert(dropdownItems, item)
        end
    end
end
