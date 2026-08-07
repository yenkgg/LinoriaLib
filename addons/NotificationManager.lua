-- NotificationManager.lua
local NotificationManager = {}
local TweenService = game:GetService("TweenService")

-- Configuration
local defaultDuration = 3
local defaultPosition = "bottomright" -- "topleft", "topright", "bottomleft", "bottomright", "center"
local maxVisible = 5

local notifications = {} -- list of active notification objects

function NotificationManager:SetLibrary(library)
    self.Library = library
end

-- Override Library:Notify if desired
function NotificationManager:OverrideLibraryNotify()
    if not self.Library then return end
    self.Library.Notify = function(text, duration, type)
        self:Notify(text, duration or defaultDuration, type or "info")
    end
end

-- Main notification function
function NotificationManager:Notify(text, duration, type, position, clickToDismiss)
    duration = duration or defaultDuration
    type = type or "info"
    position = position or defaultPosition
    clickToDismiss = clickToDismiss or false

    -- Build notification GUI
    local gui = Instance.new("Frame")
    gui.Size = UDim2.new(0, 300, 0, 60)
    gui.BackgroundColor3 = self:GetColorForType(type)
    gui.BackgroundTransparency = 0.2
    gui.BorderSizePixel = 0
    local corner = Instance.new("UICorner", gui)
    corner.CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(1, -20, 1, -10)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamMedium
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left

    -- Position
    gui.Parent = self.Library._gui or game:GetService("CoreGui")
    gui.Visible = false

    -- Click to dismiss
    if clickToDismiss then
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                self:Dismiss(gui)
            end
        end)
    end

    -- Stacking: adjust positions of existing notifications
    self:UpdateStack()

    -- Animate in
    gui.Visible = true
    gui.BackgroundTransparency = 1
    local tween = TweenService:Create(gui, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.2
    })
    tween:Play()

    -- Auto-dismiss
    if not clickToDismiss then
        task.wait(duration)
        self:Dismiss(gui)
    end

    return gui
end

function NotificationManager:GetColorForType(type)
    local colors = {
        info = Color3.fromRGB(52, 152, 219),
        success = Color3.fromRGB(46, 204, 113),
        warning = Color3.fromRGB(241, 196, 15),
        error = Color3.fromRGB(231, 76, 60)
    }
    return colors[type] or colors.info
end

function NotificationManager:UpdateStack()
    -- Move existing notifications to new positions
    local index = 0
    for _, notif in ipairs(notifications) do
        if notif and notif.Parent then
            -- Calculate new position based on stack
            local pos = self:GetPositionFromIndex(index)
            local tween = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Position = pos
            })
            tween:Play()
            index = index + 1
        end
    end
    -- Remove excess notifications
    while #notifications > maxVisible do
        local oldest = table.remove(notifications, 1)
        if oldest and oldest.Parent then
            oldest:Destroy()
        end
    end
end

function NotificationManager:GetPositionFromIndex(index)
    -- Returns a UDim2 for the given stack index based on defaultPosition
    local offset = index * 70
    local pos = UDim2.new()
    if defaultPosition == "bottomright" then
        pos = UDim2.new(1, -320, 1, -offset - 80)
    elseif defaultPosition == "bottomleft" then
        pos = UDim2.new(0, 20, 1, -offset - 80)
    elseif defaultPosition == "topright" then
        pos = UDim2.new(1, -320, 0, offset + 20)
    elseif defaultPosition == "topleft" then
        pos = UDim2.new(0, 20, 0, offset + 20)
    elseif defaultPosition == "center" then
        pos = UDim2.new(0.5, -150, 0.5, offset * 1.5 - 30)
    end
    return pos
end

function NotificationManager:Dismiss(gui)
    if not gui or not gui.Parent then return end
    -- Animate out
    local tween = TweenService:Create(gui, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Wait()
    gui:Destroy()
    -- Remove from list
    for i, notif in ipairs(notifications) do
        if notif == gui then
            table.remove(notifications, i)
            break
        end
    end
    self:UpdateStack()
end

return NotificationManager
