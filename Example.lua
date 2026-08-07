--// Library UI Test
--// Requires Library (1).lua to be available as "Library"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "UI Test",
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    TabPadding = 1,
})

--// MAIN TAB
local MainTab = Window:AddTab("Main")

local MainLeft = MainTab:AddLeftGroupbox("Main")

MainLeft:AddToggle("TestToggle", {
    Text = "Test Toggle",
    Default = false,

    Callback = function(Value)
        print("Test Toggle:", Value)
    end,
})

MainLeft:AddButton({
    Text = "Test Button",

    Func = function()
        Library:Notify("Test Button clicked!", 2)
    end,
})

MainLeft:AddDropdown("TestDropdown", {
    Values = {
        "Option 1",
        "Option 2",
        "Option 3",
    },

    Default = 1,
    Text = "Test Dropdown",

    Callback = function(Value)
        print("Selected:", Value)
    end,
})

MainLeft:AddSlider("TestSlider", {
    Text = "Test Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,

    Callback = function(Value)
        print("Slider:", Value)
    end,
})

local MainRight = MainTab:AddRightGroupbox("Extra")

MainRight:AddToggle("SecondToggle", {
    Text = "Second Toggle",
    Default = true,

    Callback = function(Value)
        print("Second Toggle:", Value)
    end,
})

MainRight:AddButton({
    Text = "Notify",

    Func = function()
        Library:Notify({
            Title = "Test",
            Description = "This is a test notification.",
            Time = 3,
        })
    end,
})

--// SETTINGS TAB
local SettingsTab = Window:AddTab("Settings")

local SettingsLeft = SettingsTab:AddLeftGroupbox("Settings")

SettingsLeft:AddToggle("TestSetting", {
    Text = "Test Setting",
    Default = true,

    Callback = function(Value)
        print("Setting:", Value)
    end,
})

SettingsLeft:AddDropdown("ThemeTest", {
    Values = {
        "Default",
        "Blue",
        "Purple",
        "Red",
    },

    Default = 1,
    Text = "Theme",

    Callback = function(Value)
        print("Theme:", Value)
    end,
})

local SettingsRight = SettingsTab:AddRightGroupbox("Interface")

SettingsRight:AddToggle("ShowNotifications", {
    Text = "Notifications",
    Default = true,

    Callback = function(Value)
        print("Notifications:", Value)
    end,
})

SettingsRight:AddSlider("UIScale", {
    Text = "UI Scale",
    Default = 100,
    Min = 75,
    Max = 125,
    Rounding = 0,

    Callback = function(Value)
        print("UI Scale:", Value)
    end,
})