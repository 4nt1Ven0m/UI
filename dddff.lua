local UI = {}

function UI.newFrame(parent, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor
    frame.Parent = parent
    return frame
end

function UI.newTextButton(parent, size, position, text, textColor, backgroundColor)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = text
    button.TextColor3 = textColor
    button.BackgroundColor3 = backgroundColor
    button.Parent = parent
    return button
end

function UI.newToggle(parent, size, position, onChange)
    local toggle = Instance.new("TextButton")
    toggle.Size = size
    toggle.Position = position
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    toggle.Parent = parent

    toggle.MouseButton1Click:Connect(function()
        if toggle.Text == "OFF" then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.new(0, 0.7, 0)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
        end
        onChange(toggle.Text == "ON")
    end)

    return toggle
end

function UI.newTabContainer(parent, size, position)
    local container = Instance.new("Frame")
    container.Size = size
    container.Position = position
    container.Parent = parent

    local tabButtons = {}
    local tabContents = {}

    function container.newTabButton(name, tabSize, tabPosition)
        local button = UI.newTextButton(container, tabSize, tabPosition, name, Color3.new(1, 1, 1), Color3.new(0.2, 0.2, 0.2))
        table.insert(tabButtons, button)
        return button
    end

    function container.newTabContent()
        local content = UI.newFrame(container, UDim2.new(1, 0, 1, -30), UDim2.new(0, 0, 0, 30), Color3.new(0.4, 0.4, 0.4))
        table.insert(tabContents, content)
        return content
    end

    function container.selectTab(index)
        for i, button in ipairs(tabButtons) do
            button.BackgroundColor3 = (i == index) and Color3.new(0.4, 0.4, 0.4) or Color3.new(0.2, 0.2, 0.2)
        end
        for i, content in ipairs(tabContents) do
            content.Visible = (i == index)
        end
    end

    return container
end

return UI
