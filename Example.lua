--// LinoriaLib Showcase
--// Full UI feature demonstration for yenkgg/LinoriaLib
--// Requires:
--//   Library.lua
----//   addons/SaveManager.lua
--//   addons/ThemeManager.lua

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/Library.lua"
))()

local ThemeManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/addons/ThemeManager.lua"
))()

local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/addons/SaveManager.lua"
))()

--// Hide the toggle circles in the keybind menu
Library.ShowToggleFrameInKeybinds = false

--// WINDOW
local Window = Library:CreateWindow({
    Title = "LinoriaLib Showcase",
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 1,
})

--// WATERMARK
Library:SetWatermark("LinoriaLib • yenkgg's Fork")
Library:SetWatermarkVisibility(true)


--// MAIN TAB
local MainTab = Window:AddTab("Main")
local MainLeft = MainTab:AddLeftGroupbox("Buttons")
MainLeft:AddLabel("Button Showcase")
MainLeft:AddDivider()

MainLeft:AddButton({
    Text = "Normal Button",
    Func = function()
        Library:Notify({
            Title = "Button",
            Description = "Normal button pressed!",
            Time = 3,
        })
    end,
})

MainLeft:AddButton({
    Text = "Notification",
    Func = function()
        Library:Notify({
            Title = "LinoriaLib",
            Description = "This is a test notification.",
            Time = 4,
        })
    end,
})

MainLeft:AddButton({
    Text = "Success Test",
    Func = function()
        Library:Notify({
            Title = "Success",
            Description = "Everything is working correctly.",
            Time = 3,
        })
    end,
})

MainLeft:AddButton({
    Text = "Warning Test",
    Func = function()
        Library:Notify({
            Title = "Warning",
            Description = "This is a warning notification.",
            Time = 3,
        })
    end,
})

MainLeft:AddButton({
    Text = "Error Test",
    Func = function()
        Library:Notify({
            Title = "Error",
            Description = "This is an error notification.",
            Time = 3,
        })
    end,
})

local MainRight = MainTab:AddRightGroupbox("Labels")
MainRight:AddLabel("This is a normal label.")
MainRight:AddLabel("LinoriaLib Showcase")
MainRight:AddDivider()
MainRight:AddLabel("The UI is fully interactive.")
MainRight:AddBlank(8)
MainRight:AddLabel("Blank spacing was added above.")


--// CONTROLS TAB
local ControlsTab = Window:AddTab("Controls")
local ControlsLeft = ControlsTab:AddLeftGroupbox("Toggles")

ControlsLeft:AddToggle("DemoToggle", {
    Text = "Demo Toggle",
    Default = false,
    Callback = function(Value) print("Demo Toggle:", Value) end,
})

ControlsLeft:AddToggle("SecondToggle", {
    Text = "Second Toggle",
    Default = true,
    Callback = function(Value) print("Second Toggle:", Value) end,
})

ControlsLeft:AddToggle("NotificationsToggle", {
    Text = "Notifications",
    Default = true,
    Callback = function(Value) print("Notifications:", Value) end,
})

local ControlsRight = ControlsTab:AddRightGroupbox("Keybinds")
local KeybindToggle = ControlsRight:AddToggle("KeybindToggle", {
    Text = "Keybind Toggle",
    Default = false,
    Callback = function(Value) print("Keybind Toggle:", Value) end,
})

KeybindToggle:AddKeyPicker("Keybind", {
    Default = Enum.KeyCode.RightShift,
    Text = "Toggle UI",
    Mode = "Toggle",
    Callback = function(Value) print("Keybind:", Value) end,
})

-- Keybind Menu visibility
if Library.KeybindFrame then
    Library.KeybindFrame.Visible = true
    Library.KeybindFrame.Position = UDim2.new(0, 12, 0.5, 40)
end

local KeybindMenuToggle = ControlsRight:AddToggle("KeybindMenu", {
    Text = "Show Keybind Menu",
    Default = true,
    Callback = function(Value)
        if Library.KeybindFrame then
            Library.KeybindFrame.Visible = Value
        end
    end,
})

-- Extra keybind examples
local AlwaysKeybind = ControlsRight:AddToggle("AlwaysKeybindDemo", {
    Text = "Always Keybind Demo",
    Default = false,
})
AlwaysKeybind:AddKeyPicker("AlwaysKeybind", {
    Default = Enum.KeyCode.LeftAlt,
    Text = "Always Example",
    Mode = "Always",
    Callback = function(Value) print("Always Keybind:", Value) end,
})

local HoldKeybind = ControlsRight:AddToggle("HoldKeybindDemo", {
    Text = "Hold Keybind Demo",
    Default = false,
})
HoldKeybind:AddKeyPicker("HoldKeybind", {
    Default = Enum.KeyCode.LeftControl,
    Text = "Hold Example",
    Mode = "Hold",
    Callback = function(Value) print("Hold Keybind:", Value) end,
})

ControlsRight:AddDivider()
ControlsRight:AddLabel("The keybind menu lists active keybinds")
ControlsRight:AddLabel("with their key, name, and mode.")


--// SLIDERS TAB
local SlidersTab = Window:AddTab("Sliders")
local SlidersLeft = SlidersTab:AddLeftGroupbox("Basic Sliders")

SlidersLeft:AddSlider("Slider0To100", {
    Text = "0 - 100",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value) print("0-100:", Value) end,
})

SlidersLeft:AddSlider("Slider0To10", {
    Text = "0 - 10",
    Default = 5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value) print("0-10:", Value) end,
})

SlidersLeft:AddSlider("NegativeSlider", {
    Text = "-100 - 100",
    Default = 0,
    Min = -100,
    Max = 100,
    Rounding = 0,
    Callback = function(Value) print("Negative Slider:", Value) end,
})

local SlidersRight = SlidersTab:AddRightGroupbox("Advanced Sliders")
SlidersRight:AddSlider("PercentSlider", {
    Text = "Percentage",
    Default = 75,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(Value) print("Percentage:", Value) end,
})

SlidersRight:AddSlider("DecimalSlider", {
    Text = "Decimal",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value) print("Decimal:", Value) end,
})

SlidersRight:AddSlider("ScaleSlider", {
    Text = "UI Scale",
    Default = 100,
    Min = 75,
    Max = 125,
    Rounding = 0,
    Callback = function(Value)
        Library:SetDPIScale(Value)
        print("DPI Scale:", Value)
    end,
})


--// DROPDOWNS TAB
local DropdownTab = Window:AddTab("Dropdowns")
local DropdownLeft = DropdownTab:AddLeftGroupbox("Dropdowns")

DropdownLeft:AddDropdown("BasicDropdown", {
    Values = { "Option 1", "Option 2", "Option 3", "Option 4", "Option 5" },
    Default = 1,
    Text = "Basic Dropdown",
    Callback = function(Value) print("Dropdown:", Value) end,
})

DropdownLeft:AddDropdown("PlayerDropdown", {
    SpecialType = "Player",
    Text = "Player",
    Callback = function(Value) print("Player:", Value) end,
})

DropdownLeft:AddDropdown("TeamDropdown", {
    SpecialType = "Team",
    Text = "Team",
    Callback = function(Value) print("Team:", Value) end,
})

local DropdownRight = DropdownTab:AddRightGroupbox("Multi Select")
DropdownRight:AddDropdown("MultiDropdown", {
    Values = { "Visuals", "Combat", "Movement", "Misc", "Utility" },
    Default = { "Visuals", "Utility" },
    Multi = true,
    Text = "Multi Dropdown",
    Callback = function(Value) print("Multi Dropdown:", Value) end,
})


--// INPUTS TAB
local InputTab = Window:AddTab("Inputs")
local InputLeft = InputTab:AddLeftGroupbox("Text Inputs")

InputLeft:AddInput("UsernameInput", {
    Default = "",
    Numeric = false,
    Finished = false,
    Text = "Username",
    Placeholder = "Enter username...",
    Callback = function(Value) print("Username:", Value) end,
})

InputLeft:AddInput("NumberInput", {
    Default = "",
    Numeric = true,
    Finished = true,
    Text = "Number",
    Placeholder = "Enter a number...",
    Callback = function(Value) print("Number:", Value) end,
})

InputLeft:AddInput("ClearInput", {
    Default = "Clear on focus",
    Numeric = false,
    Finished = false,
    Text = "Clear Input",
    ClearTextOnFocus = true,
    Callback = function(Value) print("Input:", Value) end,
})

local InputRight = InputTab:AddRightGroupbox("Input Info")
InputRight:AddLabel("Text inputs support")
InputRight:AddLabel("numeric and normal text.")
InputRight:AddDivider()
InputRight:AddLabel("Try entering different values.")


--// COLORS TAB
local ColorsTab = Window:AddTab("Colors")
local ColorsLeft = ColorsTab:AddLeftGroupbox("Color Pickers")
ColorsLeft:AddLabel("Color picker examples")

local ColorToggle = ColorsLeft:AddToggle("ColorToggle", {
    Text = "Custom Color",
    Default = true,
})
ColorToggle:AddColorPicker("ColorPicker", {
    Default = Color3.fromRGB(115, 145, 255),
    Title = "Accent Color",
    Callback = function(Value) print("Color:", Value) end,
})

local TransparencyToggle = ColorsLeft:AddToggle("TransparencyToggle", {
    Text = "Transparent Color",
    Default = false,
})
TransparencyToggle:AddColorPicker("TransparencyColor", {
    Default = Color3.fromRGB(255, 80, 80),
    Transparency = 0.25,
    Title = "Color + Transparency",
    Callback = function(Value) print("Transparency Color:", Value) end,
})

local ColorsRight = ColorsTab:AddRightGroupbox("Theme Colors")
ColorsRight:AddLabel("Your fork's color")
ColorsRight:AddLabel("system can be previewed")
ColorsRight:AddLabel("using the Theme Manager.")


--// TABBOX TAB
local TabboxTab = Window:AddTab("Tabboxes")
local LeftTabbox = TabboxTab:AddLeftTabbox("Left Tabbox")
local FirstTab = LeftTabbox:AddTab("First")
FirstTab:AddLabel("First tab")
FirstTab:AddToggle("TabboxToggle1", {
    Text = "First Toggle",
    Default = false,
})

local SecondTab = LeftTabbox:AddTab("Second")
SecondTab:AddLabel("Second tab")
SecondTab:AddSlider("TabboxSlider", {
    Text = "Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

local RightTabbox = TabboxTab:AddRightTabbox("Right Tabbox")
local ThirdTab = RightTabbox:AddTab("Controls")
ThirdTab:AddButton({
    Text = "Tabbox Button",
    Func = function() Library:Notify("Tabbox button clicked!", 2) end,
})

local FourthTab = RightTabbox:AddTab("Info")
FourthTab:AddLabel("Tabboxes allow")
FourthTab:AddLabel("multiple sections")
FourthTab:AddLabel("inside one groupbox.")


--// IMAGES TAB
local ImagesTab = Window:AddTab("Images")
local ImagesLeft = ImagesTab:AddLeftGroupbox("Image Showcase")
ImagesLeft:AddLabel("Custom image support")
ImagesLeft:AddImage("ExampleImage", {
    Image = "rbxassetid://9619665977",
    Height = 100,
})

local ImagesRight = ImagesTab:AddRightGroupbox("Image Manager")
if Library.ImageManager then
    ImagesRight:AddButton({
        Text = "Download Cursor Asset",
        Func = function()
            local Success, Error = Library.ImageManager.DownloadAsset("Cursor", true)
            if Success then
                Library:Notify({
                    Title = "Image Manager",
                    Description = "Cursor asset downloaded.",
                    Time = 3,
                })
            else
                Library:Notify({
                    Title = "Image Manager",
                    Description = tostring(Error or "Download failed."),
                    Time = 3,
                })
            end
        end,
    })
    ImagesRight:AddButton({
        Text = "Get Cursor Asset",
        Func = function()
            local Asset = Library.ImageManager.GetAsset("Cursor")
            Library:Notify({
                Title = "Image Manager",
                Description = tostring(Asset),
                Time = 4,
            })
        end,
    })
else
    ImagesRight:AddLabel("ImageManager not available in this build.")
end


--// VIEWPORT TAB
local ViewportTab = Window:AddTab("Viewport")
local ViewportLeft = ViewportTab:AddLeftGroupbox("Viewport")
ViewportLeft:AddLabel("ViewportFrame showcase")

local DemoPart = Instance.new("Part")
DemoPart.Name = "LinoriaDemoPart"
DemoPart.Size = Vector3.new(3, 3, 3)
DemoPart.Anchored = true
DemoPart.Color = Color3.fromRGB(115, 145, 255)

ViewportLeft:AddViewport("DemoViewport", {
    Object = DemoPart,
    Height = 180,
    Clone = true,
})

local ViewportRight = ViewportTab:AddRightGroupbox("Viewport Info")
ViewportRight:AddLabel("Drag to rotate.")
ViewportRight:AddLabel("Use the viewport controls")
ViewportRight:AddLabel("to inspect the object.")


--// UTILITY TAB
local UtilityTab = Window:AddTab("Utility")
local UtilityLeft = UtilityTab:AddLeftGroupbox("Library Controls")
UtilityLeft:AddButton({
    Text = "Show Watermark",
    Func = function() Library:SetWatermarkVisibility(true) end,
})
UtilityLeft:AddButton({
    Text = "Hide Watermark",
    Func = function() Library:SetWatermarkVisibility(false) end,
})
UtilityLeft:AddButton({
    Text = "Change Watermark",
    Func = function() Library:SetWatermark("LinoriaLib • Showcase Mode") end,
})
UtilityLeft:AddButton({
    Text = "Reset Watermark",
    Func = function() Library:SetWatermark("LinoriaLib • yenkgg's Fork") end,
})
UtilityLeft:AddButton({
    Text = "Save",
    Func = function()
        Library:AttemptSave()
        Library:Notify({
            Title = "Config",
            Description = "Save attempted.",
            Time = 3,
        })
    end,
})

local UtilityRight = UtilityTab:AddRightGroupbox("Notifications")
UtilityRight:AddButton({
    Text = "Short Notification",
    Func = function() Library:Notify("Short notification", 2) end,
})
UtilityRight:AddButton({
    Text = "Long Notification",
    Func = function()
        Library:Notify({
            Title = "Long Notification",
            Description = "This notification stays visible longer.",
            Time = 8,
        })
    end,
})
UtilityRight:AddButton({
    Text = "Multiple Notifications",
    Func = function()
        Library:Notify("Notification 1", 2)
        task.wait(0.2)
        Library:Notify("Notification 2", 2)
        task.wait(0.2)
        Library:Notify("Notification 3", 2)
    end,
})


--// SETTINGS TAB
local SettingsTab = Window:AddTab("Settings")
local SettingsLeft = SettingsTab:AddLeftGroupbox("Interface")

SettingsLeft:AddToggle("ShowCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value) Library.ShowCustomCursor = Value end,
})

SettingsLeft:AddToggle("ShowToggleFrame", {
    Text = "Show Toggle Frame",
    Default = false, -- Now false by default to hide circles
    Callback = function(Value) Library.ShowToggleFrameInKeybinds = Value end,
})

SettingsLeft:AddToggle("NotifyErrors", {
    Text = "Notify Errors",
    Default = false,
    Callback = function(Value) Library.NotifyOnError = Value end,
})

local SettingsRight = SettingsTab:AddRightGroupbox("Theme & Config")

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("LinoriaLibSettings")

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("LinoriaLibSettings")

ThemeManager:ApplyToTab(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadAutoloadConfig()


--// FINAL NOTIFICATION
Library:Notify({
    Title = "LinoriaLib Showcase",
    Description = "All showcase components loaded successfully.",
    Time = 5,
})
