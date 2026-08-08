# LinoriaLib — yenkgg Fork

A customized and visually enhanced fork of LinoriaLib for Roblox scripting.

This fork keeps the familiar LinoriaLib API while adding a softer, more modern UI style, rounded controls, mobile support, custom theme handling, UI sounds, and a built-in ESP Preview.

> **Note:** This is a customized fork. Some behavior, styling, and APIs may differ from upstream LinoriaLib.

---

## Features

### Custom UI

* Rounded groupboxes
* Rounded buttons
* Rounded toggles
* Rounded sliders
* Rounded dropdowns
* Softer borders and spacing
* Custom theme colors
* Improved visual consistency
* Theme-aware custom components

### Mobile Support

The fork includes dedicated mobile UI functionality for supported devices.

Mobile features include:

* UI toggle controls
* Touch-friendly interactions
* UI dragging controls
* UI lock/unlock controls
* Rounded touch-friendly components
* Device-aware default sizing

Custom UI should avoid assuming a fixed desktop resolution.

### Built-in ESP Preview

The library includes a built-in ESP Preview that can be synchronized with your ESP settings.

Supported preview elements include:

* Box
* Name
* Health
* Distance
* Tracer

Example:

```lua
Library:SetESPPreviewVisible(true)

Library:SetESPPreviewOption("Box", true)
Library:SetESPPreviewOption("Name", true)
Library:SetESPPreviewOption("Health", true)
Library:SetESPPreviewOption("Distance", true)
Library:SetESPPreviewOption("Tracer", true)
```

The preview follows the library's visual style and is designed to integrate with the rest of the UI.

---

## Installation

Load the library directly from GitHub:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/Library.lua"
))()
```

The library also exposes itself globally through:

```lua
getgenv().Linoria
```

and, by default:

```lua
getgenv().Library
```

If you do not want the `Library` global:

```lua
getgenv().skip_getgenv_linoria = true
```

Set this before loading the library.

---

## Quick Start

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/Library.lua"
))()

local Window = Library:CreateWindow({
    Title = "My Script",
    Center = true,
    AutoShow = true,
})

local Tab = Window:AddTab("Main")
local Box = Tab:AddLeftGroupbox("Settings")

Box:AddLabel("Hello!")

Box:AddButton({
    Text = "Click Me",
    Func = function()
        print("Clicked!")
    end,
})

Box:AddToggle("Enabled", {
    Text = "Enable Feature",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})

Box:AddSlider("Speed", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

Box:AddDropdown("Mode", {
    Values = {
        "Normal",
        "Fast",
        "Extreme",
    },

    Default = 1,
    Text = "Mode",
})

Box:AddInput("Username", {
    Text = "Username",
    Default = "",
    Placeholder = "Enter username...",
})

Library:Notify("Loaded!", 3)
```

---

## Creating a Window

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Size = UDim2.fromOffset(600, 500),
    Center = true,
    AutoShow = true,
    NotifySide = "Right",
})
```

Supported options include:

| Option                 | Description                   |
| ---------------------- | ----------------------------- |
| `Title`                | Window title                  |
| `AutoShow`             | Automatically show the window |
| `Position`             | Starting position             |
| `Size`                 | Window size                   |
| `AnchorPoint`          | Window anchor point           |
| `TabPadding`           | Tab spacing                   |
| `MenuFadeTime`         | UI fade timing                |
| `NotifySide`           | Notification position         |
| `ShowCustomCursor`     | Enable custom cursor          |
| `UnlockMouseWhileOpen` | Allow mouse use while open    |
| `Center`               | Center the window             |
| `Resizable`            | Enable resizing               |

Short form:

```lua
local Window = Library:CreateWindow("My Script", true)
```

---

## Tabs and Groupboxes

Create a tab:

```lua
local MainTab = Window:AddTab("Main")
```

Create groupboxes:

```lua
local Left = MainTab:AddLeftGroupbox("Settings")
local Right = MainTab:AddRightGroupbox("Information")
```

Example:

```lua
Left:AddLabel("Settings")
Right:AddLabel("Information")
```

---

## Controls

### Label

```lua
Groupbox:AddLabel("Hello World")
```

Wrapped:

```lua
Groupbox:AddLabel(
    "This is a longer piece of text that can wrap.",
    true
)
```

---

### Divider

```lua
Groupbox:AddDivider()
```

or:

```lua
Groupbox:AddDivider("Advanced")
```

---

### Button

```lua
Groupbox:AddButton({
    Text = "Test",
    Func = function()
        print("Button clicked")
    end,
})
```

Short form:

```lua
Groupbox:AddButton("Test", function()
    print("Button clicked")
end)
```

---

### Toggle

```lua
local Toggle = Groupbox:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        print(Value)
    end,
})
```

Methods:

```lua
Toggle:SetValue(true)
Toggle:SetText("New Text")
Toggle:SetVisible(false)
Toggle:SetDisabled(true)

Toggle:OnChanged(function(Value)
    print(Value)
end)
```

---

### Keybind

Keybinds can be attached to toggles:

```lua
Toggle:AddKeyPicker("ToggleKey", {
    Default = Enum.KeyCode.LeftAlt,
    Text = "Toggle Key",
    Mode = "Toggle",
})
```

Supported modes:

```text
Toggle
Hold
Always
Press
```

Sync with a toggle:

```lua
Toggle:AddKeyPicker("ToggleKey", {
    Default = Enum.KeyCode.X,
    Text = "Toggle Key",
    Mode = "Toggle",
    SyncToggleState = true,
})
```

---

### Slider

```lua
local Slider = Groupbox:AddSlider("Speed", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
})
```

Decimal values:

```lua
Groupbox:AddSlider("Multiplier", {
    Text = "Multiplier",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 2,
})
```

Methods:

```lua
Slider:SetValue(75)
Slider:SetMin(10)
Slider:SetMax(200)
Slider:SetPrefix("")
Slider:SetSuffix(" studs")
```

---

### Dropdown

```lua
local Dropdown = Groupbox:AddDropdown("Mode", {
    Values = {
        "Normal",
        "Fast",
        "Extreme",
    },

    Default = 1,
    Text = "Mode",

    Callback = function(Value)
        print(Value)
    end,
})
```

Multi-select:

```lua
Groupbox:AddDropdown("Features", {
    Values = {
        "ESP",
        "Aimbot",
        "Speed",
        "Fly",
    },

    Default = {
        "ESP",
        "Speed",
    },

    Multi = true,
    Text = "Features",
})
```

Player dropdown:

```lua
Groupbox:AddDropdown("Player", {
    SpecialType = "Player",
    Searchable = true,
    Text = "Player",
})
```

Team dropdown:

```lua
Groupbox:AddDropdown("Team", {
    SpecialType = "Team",
    Searchable = true,
    Text = "Team",
})
```

---

### Text Input

```lua
Groupbox:AddInput("Username", {
    Text = "Username",
    Default = "",
    Placeholder = "Enter username...",

    Callback = function(Value)
        print(Value)
    end,
})
```

Numeric input:

```lua
Groupbox:AddInput("Number", {
    Text = "Number",
    Default = "",
    Numeric = true,
    Finished = true,
})
```

---

### Color Picker

```lua
local Toggle = Groupbox:AddToggle("CustomColor", {
    Text = "Custom Color",
    Default = true,
})

local ColorPicker = Toggle:AddColorPicker("Color", {
    Default = Color3.fromRGB(115, 145, 255),
    Title = "Accent Color",

    Callback = function(Color, Transparency)
        print(Color, Transparency)
    end,
})
```

Transparency is supported:

```lua
Toggle:AddColorPicker("Color", {
    Default = Color3.fromRGB(255, 80, 80),
    Transparency = 0.25,
})
```

---

## Tabboxes

Create a tabbox:

```lua
local Tabbox = MainTab:AddLeftTabbox("Options")
```

Create inner tabs:

```lua
local First = Tabbox:AddTab("First")
local Second = Tabbox:AddTab("Second")
```

Then use controls normally:

```lua
First:AddLabel("First tab")

Second:AddToggle("Example", {
    Text = "Example",
    Default = false,
})
```

---

## Images

```lua
Groupbox:AddImage("Image", {
    Image = "rbxassetid://9619665977",
    Height = 100,
})
```

---

## Videos

```lua
Groupbox:AddVideo("Video", {
    Video = "rbxassetid://VIDEO_ID",
    Height = 200,
    Looped = true,
    Playing = true,
    Volume = 1,
})
```

---

## ViewportFrames

```lua
local Part = Instance.new("Part")
Part.Size = Vector3.new(3, 3, 3)
Part.Anchored = true

Groupbox:AddViewport("Preview", {
    Object = Part,
    Height = 180,
    Clone = true,
})
```

---

## Dependencies

Create a dependency box:

```lua
local Enabled = Groupbox:AddToggle("Enabled", {
    Text = "Enable Advanced",
    Default = false,
})

local Advanced = Groupbox:AddDependencyBox()

Advanced:AddSlider("Power", {
    Text = "Power",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

Advanced:SetupDependencies({
    { Toggles.Enabled, true }
})
```

Dependency groupboxes are also supported:

```lua
Groupbox:AddDependencyGroupbox()
```

---

## Notifications

Simple:

```lua
Library:Notify("Hello!", 2)
```

Structured:

```lua
Library:Notify({
    Title = "Success",
    Description = "The operation completed.",
    Time = 3,
})
```

---

## Watermark

Show:

```lua
Library:SetWatermarkVisibility(true)
```

Hide:

```lua
Library:SetWatermarkVisibility(false)
```

Set text:

```lua
Library:SetWatermark("My Script • v1.0")
```

---

## UI Scaling

Change the UI scale:

```lua
Library:SetDPIScale(100)
```

Examples:

```lua
Library:SetDPIScale(75)
Library:SetDPIScale(100)
Library:SetDPIScale(125)
```

---

## Opening and Closing

Toggle:

```lua
Library:Toggle()
```

Explicitly open:

```lua
Library:Toggle(true)
```

Explicitly close:

```lua
Library:Toggle(false)
```

You can also toggle the window directly:

```lua
Window:Toggle(true)
Window:Toggle(false)
```

---

## ESP Preview

The fork includes a built-in ESP Preview.

Create it manually if needed:

```lua
Library:CreateESPPreview()
```

Show:

```lua
Library:SetESPPreviewVisible(true)
```

Hide:

```lua
Library:SetESPPreviewVisible(false)
```

Change individual options:

```lua
Library:SetESPPreviewOption("Box", true)
Library:SetESPPreviewOption("Name", true)
Library:SetESPPreviewOption("Health", true)
Library:SetESPPreviewOption("Distance", true)
Library:SetESPPreviewOption("Tracer", true)
```

Disable an option:

```lua
Library:SetESPPreviewOption("Tracer", false)
```

### ESP Example

```lua
local ESPTab = Window:AddTab("ESP")
local ESP = ESPTab:AddLeftGroupbox("ESP Settings")

ESP:AddToggle("Enabled", {
    Text = "Enabled",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewVisible(Value)
    end,
})

ESP:AddToggle("Box", {
    Text = "Box",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Box", Value)
    end,
})

ESP:AddToggle("Name", {
    Text = "Name",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Name", Value)
    end,
})

ESP:AddToggle("Health", {
    Text = "Health",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Health", Value)
    end,
})

ESP:AddToggle("Distance", {
    Text = "Distance",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Distance", Value)
    end,
})

ESP:AddToggle("Tracer", {
    Text = "Tracer",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Tracer", Value)
    end,
})
```

The ESP Preview is intended to represent your ESP configuration, while your actual ESP renderer should remain separate.

---

## Theme System

The fork provides several theme colors:

```lua
Library.FontColor
Library.MainColor
Library.BackgroundColor
Library.AccentColor
Library.DisabledAccentColor
Library.OutlineColor
Library.DisabledOutlineColor
Library.DisabledTextColor
Library.RiskColor
Library.Black
```

When creating custom components, use the existing theme instead of introducing another palette.

Example:

```lua
Frame.BackgroundColor3 = Library.MainColor
Frame.BorderColor3 = Library.OutlineColor
Label.TextColor3 = Library.FontColor
```

---

## Theme Registry

Theme-dependent instances should use the registry:

```lua
Library:AddToRegistry(MyFrame, {
    BackgroundColor3 = "MainColor",
    BorderColor3 = "OutlineColor",
})
```

This allows the component to automatically follow theme changes.

Avoid hardcoding colors for theme-dependent components:

```lua
-- Avoid
MyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
```

Prefer:

```lua
-- Recommended
Library:AddToRegistry(MyFrame, {
    BackgroundColor3 = "MainColor",
})
```

---

## Custom UI Styling

When extending the fork, follow its existing visual language:

* Small corner radii for controls
* Larger radii for containers
* Thin borders
* Soft surfaces
* Consistent spacing
* Library theme colors
* Existing typography
* Existing hover behavior
* Registry-based theme support

The goal is for custom components to look native to the library rather than appearing as separate UI elements.

---

## UI Sounds

Play a UI sound:

```lua
Library:PlayUISound(SoundId, Volume, Speed)
```

Example:

```lua
Library:PlayUISound(123456789, 0.5, 1)
```

Tab sound:

```lua
Library:PlayTabSound()
```

Config sound:

```lua
Library:PlayConfigSound()
```

---

## Unloading

Unload the library:

```lua
Library:Unload()
```

Register an unload callback:

```lua
Library:OnUnload(function()
    print("Library unloaded")
end)
```

If your script creates connections or instances outside the library, clean those up yourself.

---

## Recommended Script Structure

For larger scripts, keep the UI and feature logic separate:

```text
Script
│
├── Load Library
│
├── Create Window
│
├── Main
│   ├── General
│   ├── Movement
│   └── Misc
│
├── Visuals
│   ├── ESP
│   ├── Chams
│   └── Other Visuals
│
├── Combat
│   ├── Aimbot
│   └── Targeting
│
├── Settings
│   ├── UI
│   ├── Keybinds
│   └── Configuration
│
└── Cleanup
```

Example:

```lua
local ESPState = {
    Enabled = false,
    Box = true,
    Name = true,
    Health = true,
    Distance = true,
    Tracer = true,
}

local function UpdateESP()
    -- Actual ESP implementation.
end

local ESPTab = Window:AddTab("ESP")
local Groupbox = ESPTab:AddLeftGroupbox("ESP")

Groupbox:AddToggle("ESPEnabled", {
    Text = "Enabled",
    Default = ESPState.Enabled,

    Callback = function(Value)
        ESPState.Enabled = Value

        UpdateESP()

        Library:SetESPPreviewVisible(Value)
    end,
})
```

This keeps the UI layer and feature implementation separate and easier to maintain.

---

## API Reference

### Library

```lua
Library:CreateWindow(...)
Library:Toggle(...)
Library:Notify(...)
Library:SetWatermark(...)
Library:SetWatermarkVisibility(...)
Library:SetNotifySide(...)
Library:SetDPIScale(...)
Library:PlayUISound(...)
Library:PlayTabSound(...)
Library:PlayConfigSound(...)
Library:CreateESPPreview(...)
Library:SetESPPreviewVisible(...)
Library:SetESPPreviewOption(...)
Library:Unload(...)
Library:OnUnload(...)
```

### Window

```lua
Window:AddTab(...)
Window:Toggle(...)
```

### Tab

```lua
Tab:AddLeftGroupbox(...)
Tab:AddRightGroupbox(...)
Tab:AddLeftTabbox(...)
Tab:AddRightTabbox(...)
Tab:AddTabbox(...)
Tab:ShowTab()
Tab:HideTab()
Tab:SetName(...)
Tab:SetLayoutOrder(...)
Tab:GetSides()
```

### Groupbox

```lua
Groupbox:AddLabel(...)
Groupbox:AddDivider(...)
Groupbox:AddButton(...)
Groupbox:AddToggle(...)
Groupbox:AddSlider(...)
Groupbox:AddDropdown(...)
Groupbox:AddInput(...)
Groupbox:AddImage(...)
Groupbox:AddViewport(...)
Groupbox:AddVideo(...)
Groupbox:AddUIPassthrough(...)
Groupbox:AddTabbox(...)
Groupbox:AddDependencyBox(...)
Groupbox:AddDependencyGroupbox(...)
```

### Toggle

```lua
Toggle:SetValue(...)
Toggle:OnChanged(...)
Toggle:SetVisible(...)
Toggle:SetDisabled(...)
Toggle:SetText(...)
Toggle:AddKeyPicker(...)
Toggle:AddColorPicker(...)
```

### Slider

```lua
Slider:SetValue(...)
Slider:OnChanged(...)
Slider:SetMin(...)
Slider:SetMax(...)
Slider:SetVisible(...)
Slider:SetDisabled(...)
Slider:SetText(...)
Slider:SetPrefix(...)
Slider:SetSuffix(...)
```

### Dropdown

```lua
Dropdown:SetValue(...)
Dropdown:OnChanged(...)
Dropdown:SetValues(...)
Dropdown:AddValues(...)
Dropdown:SetDisabledValues(...)
Dropdown:AddDisabledValues(...)
Dropdown:SetVisible(...)
Dropdown:SetDisabled(...)
Dropdown:OpenDropdown()
Dropdown:CloseDropdown()
Dropdown:GetActiveValues()
Dropdown:SetText(...)
```

### KeyPicker

```lua
KeyPicker:SetValue(...)
KeyPicker:GetState()
KeyPicker:OnClick(...)
KeyPicker:OnChanged(...)
KeyPicker:DoClick()
KeyPicker:SetModePickerVisibility(...)
KeyPicker:GetModePickerVisibility(...)
```

### ColorPicker

```lua
ColorPicker:SetValue(...)
ColorPicker:SetValueRGB(...)
ColorPicker:SetHSVFromRGB(...)
ColorPicker:OnChanged(...)
ColorPicker:Show()
ColorPicker:Hide()
```

---

## Common Mistakes

### Reusing IDs

Controls such as toggles, sliders, dropdowns, and inputs should have unique IDs.

Incorrect:

```lua
Groupbox:AddToggle("Example", {
    Text = "First",
})

Groupbox:AddToggle("Example", {
    Text = "Second",
})
```

Correct:

```lua
Groupbox:AddToggle("FirstToggle", {
    Text = "First",
})

Groupbox:AddToggle("SecondToggle", {
    Text = "Second",
})
```

### Missing Slider Fields

A slider should normally include:

```lua
Default
Min
Max
Rounding
Text
```

Example:

```lua
Groupbox:AddSlider("Example", {
    Text = "Example",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})
```

### Missing Dropdown Values

A dropdown requires:

```lua
Values = {...}
```

Example:

```lua
Groupbox:AddDropdown("Example", {
    Values = {
        "A",
        "B",
        "C",
    },

    Default = 1,
    Text = "Example",
})
```

### Invalid Button Callback

Incorrect:

```lua
Groupbox:AddButton({
    Text = "Test",
    Func = "hello",
})
```

Correct:

```lua
Groupbox:AddButton({
    Text = "Test",
    Func = function()
        print("hello")
    end,
})
```

### Rebuilding the Theme

Do not create an unrelated color system for custom components.

Use:

```lua
Library.MainColor
Library.BackgroundColor
Library.OutlineColor
Library.AccentColor
Library.FontColor
```

and the registry system where appropriate.

### Replacing the ESP Preview

The built-in ESP Preview already exists.

Use:

```lua
Library:SetESPPreviewVisible(...)
Library:SetESPPreviewOption(...)
```

instead of creating a second preview window.

---

## Fork Differences

This fork is not an untouched upstream LinoriaLib build.

Custom additions and changes include:

* Rounded groupboxes
* Rounded controls
* Rounded dropdowns
* Rounded buttons
* Rounded toggles
* Rounded sliders
* Custom theme colors
* Custom image handling
* Mobile UI controls
* Built-in ESP Preview
* ESP Preview option synchronization
* UI sound helpers
* Custom cursor support
* Watermark controls
* Additional visual polish
* Theme registry support for custom components
* UI scaling improvements

When extending the library, preserve these conventions.

In particular, custom components should use the same:

* `MainColor`
* `BackgroundColor`
* `OutlineColor`
* `AccentColor`
* `FontColor`
* Corner-radius philosophy
* Typography
* Spacing
* Hover behavior
* Theme registry

This keeps new components visually consistent with the rest of the fork.

---

## Documentation

For the complete API and usage guide, see:

`Instructions.md`

The documentation covers:

* Windows
* Tabs
* Groupboxes
* Labels
* Buttons
* Toggles
* Keybinds
* Sliders
* Dropdowns
* Inputs
* Color pickers
* Tabboxes
* Images
* Viewports
* Videos
* Dependencies
* Notifications
* Watermarks
* UI scaling
* Mobile support
* ESP Preview
* Theme handling
* UI sounds
* Cleanup
* API reference

---

## Credits

This project is a customized fork of LinoriaLib.

Original LinoriaLib functionality and concepts belong to their respective original authors.

Custom modifications, styling, features, and fork-specific functionality are maintained by **yenkgg**.

If you have any features or bugs report in the discord server: https://discord.gg/V4GzTxZvYn

---

## License

Open Source 👍

---

## Repository

**LinoriaLib — yenkgg Fork**

A customized LinoriaLib experience focused on modern styling, rounded UI, mobile support, and additional built-in functionality.
