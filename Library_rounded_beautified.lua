local InputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Library = {
    FontColor = Color3.fromRGB(255, 255, 255),
    MainColor = Color3.fromRGB(25, 25, 25),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    AccentColor = Color3.fromRGB(0, 85, 255),
    OutlineColor = Color3.fromRGB(50, 50, 50),
    RiskColor = Color3.fromRGB(255, 50, 50),
    DPIScale = 1
}

local MAX_DROPDOWN_ITEMS = 8

function Library:SafeCallback(f, ...)
    if not f then return end
    local success, err = pcall(f, ...)
    if not success then
        warn("Library Callback Error:", err)
    end
end

function Library:CreateLabel(properties)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Code
    label.TextColor3 = Library.FontColor
    label.TextSize = 14 * Library.DPIScale
    label.TextTransparency = 0 -- FIX: Ensures text is not transparent
    for k, v in pairs(properties) do
        label[k] = v
    end
    return label
end

function Library:CreateWindow(options)
    local Window = {
        Tabs = {},
        ActiveTab = nil
    }
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LinoriaLib"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = Library.MainColor
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = Library.OutlineColor
    MainFrame.Parent = ScreenGui

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.BackgroundColor3 = Library.BackgroundColor
    TabContainer.BorderSizePixel = 1
    TabContainer.BorderColor3 = Library.OutlineColor
    TabContainer.Parent = MainFrame

    local TabContainerLayout = Instance.new("UIListLayout")
    TabContainerLayout.FillDirection = Enum.FillDirection.Horizontal
    TabContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabContainerLayout.Parent = TabContainer

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, 0, 1, -30)
    ContentContainer.Position = UDim2.new(0, 0, 0, 30)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    function Window:AddTab(Name)
        local Tab = {
            Elements = {}
        }
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = Name .. "Tab"
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BackgroundColor3 = Library.BackgroundColor
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.Parent = TabContainer
        
        -- FIX: Add explicit TextTransparency and TextColor3 to prevent transparent tabs
        local TabButtonLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0),
            Text = Name,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 11,
            Parent = TabButton,
            TextTransparency = 0,
            TextColor3 = Library.FontColor
        })

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = Name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 2
        TabContent.Parent = ContentContainer

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.Parent = TabContent

        TabButton.MouseButton1Click:Connect(function()
            if Window.ActiveTab then
                Window.ActiveTab.Content.Visible = false
                Window.ActiveTab.Button.BackgroundColor3 = Library.BackgroundColor
                Window.ActiveTab.Label.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
            
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Library.MainColor
            TabButtonLabel.TextColor3 = Library.AccentColor
            Window.ActiveTab = { Content = TabContent, Button = TabButton, Label = TabButtonLabel }
        end)

        function Tab:AddDropdown(Info)
            local Dropdown = {
                Value = Info.Multi and {} or nil,
                Values = Info.Values or {},
                Callback = Info.Callback or function() end,
                Changed = Info.Changed or function() end
            }

            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
            DropdownFrame.BackgroundTransparency = 1
            DropdownFrame.Parent = TabContent

            local DropdownLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 15),
                Text = Info.Text or "Dropdown",
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = DropdownFrame
            })

            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(1, 0, 0, 20)
            DropdownButton.Position = UDim2.new(0, 0, 0, 15)
            DropdownButton.BackgroundColor3 = Library.BackgroundColor
            DropdownButton.BorderColor3 = Library.OutlineColor
            DropdownButton.Text = "Select..."
            DropdownButton.TextColor3 = Library.FontColor
            DropdownButton.Font = Enum.Font.Code
            DropdownButton.TextSize = 14
            DropdownButton.Parent = DropdownFrame

            local DropdownList = Instance.new("ScrollingFrame")
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 0, 36)
            DropdownList.BackgroundColor3 = Library.MainColor
            DropdownList.BorderColor3 = Library.OutlineColor
            DropdownList.ZIndex = 50
            DropdownList.Visible = false
            DropdownList.ScrollBarThickness = 2
            DropdownList.Parent = DropdownFrame

            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = DropdownList

            local isOpen = false

            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                DropdownList.Visible = isOpen
            end)

            function Dropdown:GetActiveValues()
                if Info.Multi then
                    local count = 0
                    for _, v in pairs(self.Value) do
                        if v then count = count + 1 end
                    end
                    return count
                else
                    return self.Value ~= nil and 1 or 0
                end
            end

            function Dropdown:Display()
                if Info.Multi then
                    local displayStr = ""
                    for k, v in pairs(self.Value) do
                        if v then
                            displayStr = displayStr .. k .. ", "
                        end
                    end
                    displayStr = displayStr ~= "" and displayStr:sub(1, -3) or "Select..."
                    DropdownButton.Text = displayStr
                else
                    DropdownButton.Text = self.Value or "Select..."
                end
            end

            function Dropdown:BuildDropdownList()
                for _, child in ipairs(DropdownList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                local Count = 0
                for _, Value in ipairs(self.Values) do
                    local StringValue = tostring(Value)
                    Count = Count + 1

                    local ItemButton = Instance.new("TextButton")
                    ItemButton.Size = UDim2.new(1, 0, 0, 20)
                    ItemButton.BackgroundColor3 = Library.BackgroundColor
                    ItemButton.BorderSizePixel = 0
                    ItemButton.Text = StringValue
                    ItemButton.TextColor3 = Library.FontColor
                    ItemButton.Font = Enum.Font.Code
                    ItemButton.TextSize = 14
                    ItemButton.ZIndex = 51
                    ItemButton.Parent = DropdownList

                    ItemButton.MouseButton1Click:Connect(function()
                        local Try = Info.Multi and not self.Value[Value] or Value
                        
                        -- FIX: The fixed truncation block you requested
                        if self:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                            -- Prevent deselecting if AllowNull is false and it's the last selected item
                        else
                            if Info.Multi then
                                local Selected = Try
                                if Selected then
                                    self.Value[Value] = true
                                else
                                    self.Value[Value] = nil
                                end
                            else
                                local Selected = Try
                                self.Value = Selected and Value or nil
                                isOpen = false
                                DropdownList.Visible = false
                            end

                            self:Display()
                            Library:SafeCallback(self.Callback, self.Value)
                            Library:SafeCallback(self.Changed, self.Value)
                        end
                    end)
                end

                local listSize = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20)
                DropdownList.Size = UDim2.new(1, 0, 0, listSize)
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, Count * 20)
                DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
            end

            -- Initialize the dropdown items list
            Dropdown:BuildDropdownList()
            
            table.insert(Tab.Elements, Dropdown)
            return Dropdown
        end

        table.insert(Window.Tabs, Tab)
        
        -- Auto-select the first tab
        if #Window.Tabs == 1 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Library.MainColor
            TabButtonLabel.TextColor3 = Library.AccentColor
            Window.ActiveTab = { Content = TabContent, Button = TabButton, Label = TabButtonLabel }
        end
        
        return Tab
    end

    return Window
end

return Library
