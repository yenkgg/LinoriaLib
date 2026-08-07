-- AnimatedTransitions.lua
-- Patches LinoriaLib to add smooth animations

local TweenService = game:GetService("TweenService")
local Library = ... -- you'll need to reference the Library instance

local function patchTabSwitching(Library)
    -- Store original method
    local originalSetTab = Library.SetTab
    Library.SetTab = function(self, tab)
        if self.ActiveTab == tab then return end
        local oldTab = self.ActiveTab
        -- Fade out old tab content
        if oldTab and oldTab.Content then
            local tween = TweenService:Create(oldTab.Content, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            })
            tween:Play()
            tween.Completed:Wait()
            oldTab.Content.Visible = false
        end
        -- Call original
        originalSetTab(self, tab)
        -- Fade in new tab content
        if tab and tab.Content then
            tab.Content.BackgroundTransparency = 1
            tab.Content.Visible = true
            local tween = TweenService:Create(tab.Content, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            })
            tween:Play()
        end
    end
end

-- You can also patch notification creation if you use NotificationManager
local function patchNotifications(NotificationManager)
    local originalNotify = NotificationManager.Notify
    NotificationManager.Notify = function(self, ...)
        -- The existing NotificationManager already uses tweens, so we just need to ensure they are called.
        return originalNotify(self, ...)
    end
end

-- Apply patches
function AnimatedTransitions:Apply(Library, NotificationManager)
    if Library then
        patchTabSwitching(Library)
    end
    if NotificationManager then
        patchNotifications(NotificationManager)
    end
end

return AnimatedTransitions
