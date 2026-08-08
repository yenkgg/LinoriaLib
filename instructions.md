# LinoriaLib Fork — Library (5).lua Instructions

This document explains how to use **`Library (5).lua`**, the custom LinoriaLib fork.

The library exposes a Linoria-style API for creating windows, tabs, groupboxes, controls, keybinds, color pickers, notifications, the built-in ESP Preview, and utility features.

---

## 1. Loading the Library

`Library (5).lua` returns the `Library` table.

Typical usage:

```lua
local Library = loadstring(game:HttpGet("YOUR_LIBRARY_URL_HERE"))()
```

If you already have the library source available locally in your script environment, load it using whatever loader your environment uses.

The library also exposes itself globally:

```lua
getgenv().Linoria
```

and, by default:

```lua
getgenv().Library
```

The `getgenv().Library` assignment can be disabled by setting:

```lua
getgenv().skip_getgenv_linoria = true
```

before loading the library.

---

# 2. Creating a Window

The main entry point is:

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Size = UDim2.fromOffset(550, 600),
    Center = true,
    AutoShow = false,
})
```

You can also use the short form:

```lua
local Window = Library:CreateWindow("My Script", true)
```

The second argument in the short form controls `AutoShow`.

## Window options

Supported window options include:

| Option | Description |
|---|---|
| `Title` | Window title |
| `AutoShow` | Automatically show the window after creation |
| `Position` | Starting `UDim2` position |
| `Size` | Window size |
| `AnchorPoint` | Window anchor point |
| `TabPadding` | Spacing between tabs |
| `MenuFadeTime` | Window fade timing |
| `NotifySide` | Notification side, such as `"Left"` or `"Right"` |
| `ShowCustomCursor` | Whether the custom cursor is shown |
| `UnlockMouseWhileOpen` | Allows mouse use while the UI is open |
| `Center` | Centers the window automatically |

Example:

```lua
local Window = Library:CreateWindow({
    Title = "Example",
    Size = UDim2.fromOffset(600, 500),
    Center = true,
    AutoShow = true,
    NotifySide = "Right",
})
```

If no size is supplied, the library selects a default size based on the device.

---

# 3. Tabs

Create a tab with:

```lua
local MainTab = Window:AddTab("Main")
```

Then create groupboxes inside it:

```lua
local LeftGroup = MainTab:AddLeftGroupbox("Settings")
local RightGroup = MainTab:AddRightGroupbox("Information")
```

The left and right groupboxes let you organize controls into the two columns of the window.

Example:

```lua
local MainTab = Window:AddTab("Main")

local Settings = MainTab:AddLeftGroupbox("Settings")
local Info = MainTab:AddRightGroupbox("Information")

Settings:AddLabel("Settings go here.")
Info:AddLabel("Information goes here.")
```

---

# 4. Labels

Use:

```lua
Groupbox:AddLabel("Hello world")
```

For a wrapped label:

```lua
Groupbox:AddLabel("A longer description that can wrap onto multiple lines.", true)
```

You can also give a label an ID:

```lua
local Label = Groupbox:AddLabel({
    Text = "Status: Ready",
    DoesWrap = false,
    Idx = "StatusLabel",
})
```

Change its text later:

```lua
Label:SetText("Status: Running")
```

---

# 5. Dividers

Simple divider:

```lua
Groupbox:AddDivider()
```

Text divider:

```lua
Groupbox:AddDivider("Advanced")
```

Or:

```lua
Groupbox:AddDivider({
    Text = "Advanced",
    MarginTop = 2,
    MarginBottom = 9,
})
```

Dividers are useful for separating related settings.

---

# 6. Buttons

Basic button:

```lua
Groupbox:AddButton({
    Text = "Click Me",
    Func = function()
        print("Clicked")
    end,
})
```

You can also use the short form:

```lua
Groupbox:AddButton("Click Me", function()
    print("Clicked")
end)
```

The callback must be a function.

## Button variants

The library also supports button variants through the button information table where supported by the current build.

For example:

```lua
Groupbox:AddButton({
    Text = "Dangerous Action",
    Func = function()
        print("Danger action")
    end,
    Variant = "Destructive",
})
```

Do not depend on a variant unless your current `Library (5).lua` build exposes it; the normal button API is always the safest choice.

---

# 7. Toggles

Basic toggle:

```lua
local Toggle = Groupbox:AddToggle("MyToggle", {
    Text = "Enable Feature",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})
```

Set it later:

```lua
Toggle:SetValue(true)
```

Change the displayed text:

```lua
Toggle:SetText("Enable ESP")
```

Hide/show it:

```lua
Toggle:SetVisible(false)
Toggle:SetVisible(true)
```

Disable/enable it:

```lua
Toggle:SetDisabled(true)
Toggle:SetDisabled(false)
```

## Toggle callbacks

The main callback is:

```lua
Callback = function(Value)
    -- Value is true/false
end
```

You can also attach a changed callback after creation:

```lua
Toggle:OnChanged(function(Value)
    print("Changed:", Value)
end)
```

---

# 8. Keybinds

Keybinds are normally attached to a toggle:

```lua
local Toggle = Groupbox:AddToggle("Feature", {
    Text = "Feature",
    Default = false,
})

Toggle:AddKeyPicker("FeatureKey", {
    Default = Enum.KeyCode.LeftAlt,
    Text = "Feature Key",
    Mode = "Toggle",

    Callback = function(Value)
        print("Keybind state:", Value)
    end,
})
```

## Keybind modes

Supported modes include:

- `Toggle`
- `Hold`
- `Always`
- `Press`

Example:

```lua
Toggle:AddKeyPicker("HoldKey", {
    Default = Enum.KeyCode.LeftControl,
    Text = "Hold Key",
    Mode = "Hold",
})
```

### Syncing a keybind with a toggle

```lua
Toggle:AddKeyPicker("FeatureKey", {
    Default = Enum.KeyCode.X,
    Text = "Feature Key",
    Mode = "Toggle",
    SyncToggleState = true,
})
```

This makes the keybind and toggle state work together.

---

# 9. Sliders

Basic slider:

```lua
local Slider = Groupbox:AddSlider("Speed", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,

    Callback = function(Value)
        print("Speed:", Value)
    end,
})
```

Decimal slider:

```lua
Groupbox:AddSlider("Multiplier", {
    Text = "Multiplier",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 2,
})
```

Percentage suffix:

```lua
Groupbox:AddSlider("Opacity", {
    Text = "Opacity",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
})
```

Prefix:

```lua
Groupbox:AddSlider("Distance", {
    Text = "Distance",
    Default = 100,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Prefix = "",
    Suffix = " studs",
})
```

Change values later:

```lua
Slider:SetValue(75)
Slider:SetMin(10)
Slider:SetMax(200)
Slider:SetPrefix("")
Slider:SetSuffix(" studs")
```

---

# 10. Dropdowns

Basic dropdown:

```lua
local Dropdown = Groupbox:AddDropdown("Mode", {
    Values = {
        "Normal",
        "Aggressive",
        "Defensive",
    },

    Default = 1,
    Text = "Mode",

    Callback = function(Value)
        print("Selected:", Value)
    end,
})
```

The default can also be the selected value where appropriate.

## Multi-select dropdown

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

    Callback = function(Value)
        print(Value)
    end,
})
```

## Searchable dropdown

```lua
Groupbox:AddDropdown("Players", {
    SpecialType = "Player",
    Searchable = true,
    Text = "Player",
})
```

The library has built-in special dropdown support for:

```lua
SpecialType = "Player"
```

and:

```lua
SpecialType = "Team"
```

Player/team dropdowns update as players and teams change.

## Dropdown methods

Useful methods include:

```lua
Dropdown:SetValue(Value)
Dropdown:SetValues(NewValues)
Dropdown:AddValues(NewValues)
Dropdown:SetDisabledValues(Values)
Dropdown:AddDisabledValues(Values)
Dropdown:SetVisible(true)
Dropdown:SetDisabled(true)
Dropdown:OpenDropdown()
Dropdown:CloseDropdown()
Dropdown:GetActiveValues()
Dropdown:SetText("New Text")
```

---

# 11. Text Inputs

Basic text input:

```lua
Groupbox:AddInput("Username", {
    Text = "Username",
    Default = "",
    Placeholder = "Enter username...",

    Callback = function(Value)
        print("Username:", Value)
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

    Callback = function(Value)
        print("Number:", Value)
    end,
})
```

Clear the field when focused:

```lua
Groupbox:AddInput("Search", {
    Text = "Search",
    Default = "Search...",
    ClearTextOnFocus = true,
})
```

---

# 12. Color Pickers

Color pickers are normally attached to toggles or other supported controls.

Example:

```lua
local Toggle = Groupbox:AddToggle("CustomColor", {
    Text = "Custom Color",
    Default = true,
})

Toggle:AddColorPicker("ColorPicker", {
    Default = Color3.fromRGB(115, 145, 255),
    Title = "Accent Color",

    Callback = function(Color, Transparency)
        print(Color, Transparency)
    end,
})
```

Transparency:

```lua
Toggle:AddColorPicker("ColorPicker", {
    Default = Color3.fromRGB(255, 80, 80),
    Transparency = 0.25,
    Title = "Color + Transparency",
})
```

Useful methods:

```lua
ColorPicker:SetValueRGB(Color3.fromRGB(255, 0, 0), 0)
ColorPicker:SetValue(HSV, Transparency)
ColorPicker:SetHSVFromRGB(Color)
ColorPicker:Show()
ColorPicker:Hide()
```

---

# 13. Tabboxes

A tabbox allows multiple smaller tabs inside a groupbox.

Create one:

```lua
local Tabbox = MainTab:AddLeftTabbox("Options")
```

Then:

```lua
local First = Tabbox:AddTab("First")
local Second = Tabbox:AddTab("Second")
```

Add controls normally:

```lua
First:AddLabel("First tab")
First:AddToggle("FirstToggle", {
    Text = "Toggle",
    Default = false,
})

Second:AddLabel("Second tab")
Second:AddSlider("SecondSlider", {
    Text = "Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})
```

Right-side tabbox:

```lua
local Tabbox = MainTab:AddRightTabbox("Options")
```

---

# 14. Images

The library supports images inside groupboxes.

```lua
Groupbox:AddImage("ExampleImage", {
    Image = "rbxassetid://9619665977",
    Height = 100,
})
```

`Height` controls the displayed image height.

The library also contains a custom image manager for built-in assets such as:

- Cursor
- DropdownArrow
- Checker
- CheckerLong
- SaturationMap

---

# 15. ViewportFrames

Create a viewport:

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

`Clone = true` makes the viewport use a clone of the supplied object where supported.

---

# 16. Videos

The library has video support through:

```lua
Groupbox:AddVideo("Video", {
    Video = "rbxassetid://VIDEO_ID",
    Height = 200,
    Looped = true,
    Playing = true,
    Volume = 1,
})
```

Use only valid Roblox video assets supported by the environment.

---

# 17. UI Passthrough

The library supports a UI passthrough element:

```lua
Groupbox:AddUIPassthrough("Passthrough", {
    Instance = SomeGuiObject,
    Height = 24,
})
```

This is useful when an existing Roblox GUI object needs to occupy space inside the library without being recreated as a normal Linoria control.

---

# 18. Dependency Boxes

For controls that should only appear when another option is enabled, use a dependency box.

Example:

```lua
local Enabled = Groupbox:AddToggle("Enabled", {
    Text = "Enable Advanced Settings",
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

The exact dependency structure should follow the existing dependency methods exposed by the current library build.

The library also supports dependency **groupboxes** through:

```lua
Groupbox:AddDependencyGroupbox()
```

---

# 19. Notifications

Simple notification:

```lua
Library:Notify("Hello!", 2)
```

The second argument is the display time.

Structured notification:

```lua
Library:Notify({
    Title = "Success",
    Description = "The operation completed.",
    Time = 3,
})
```

You can also use:

```lua
Library:Notify({
    Title = "Information",
    Description = "Something happened.",
    Time = 4,
})
```

Notifications use the library's current theme and styling.

---

# 20. Watermark

Show the watermark:

```lua
Library:SetWatermarkVisibility(true)
```

Hide it:

```lua
Library:SetWatermarkVisibility(false)
```

Change the text:

```lua
Library:SetWatermark("My Script")
```

Example:

```lua
Library:SetWatermark("My Script • v1.0")
Library:SetWatermarkVisibility(true)
```

---

# 21. UI Scaling

Change the library's DPI/UI scale:

```lua
Library:SetDPIScale(100)
```

Typical values:

```lua
Library:SetDPIScale(75)
Library:SetDPIScale(100)
Library:SetDPIScale(125)
```

A value around `100` represents the normal scale.

This is useful for smaller or larger displays.

---

# 22. Opening and Closing the UI

The library can toggle the window with:

```lua
Library:Toggle()
```

You can explicitly choose a state:

```lua
Library:Toggle(true)
```

or:

```lua
Library:Toggle(false)
```

The window also has its own toggle method:

```lua
Window:Toggle(true)
Window:Toggle(false)
```

By default, the library listens for its standard keyboard toggle behavior. The current build also supports a configurable toggle key through the library's keybind system.

---

# 23. Mobile Support

The library contains dedicated mobile UI controls.

On supported mobile devices it provides controls for:

- Opening/toggling the UI
- Locking/unlocking UI dragging
- Touch interaction
- Touch-friendly rounded controls

Do not remove or replace these controls when modifying the library.

When creating custom UI around the library, avoid fixed positions that assume a desktop-sized viewport.

---

# 24. Dragging and Resizing

The main window is draggable.

The library internally uses:

```lua
Library:MakeDraggable(...)
```

and supports resizing through:

```lua
Library:MakeResizable(...)
```

Window resizing is enabled through the window's configuration when supported by the current build.

Example:

```lua
local Window = Library:CreateWindow({
    Title = "Resizable UI",
    Resizable = true,
})
```

The library also has minimum-size handling for resizable windows.

---

# 25. Built-in ESP Preview

This fork includes a built-in ESP Preview.

The library creates it automatically when the main window is created.

You normally do **not** need to manually recreate the preview.

The API is:

```lua
Library:CreateESPPreview()
Library:SetESPPreviewVisible(Value)
Library:SetESPPreviewOption(Name, Value)
```

## Show/hide the preview

```lua
Library:SetESPPreviewVisible(true)
```

Hide it:

```lua
Library:SetESPPreviewVisible(false)
```

## Control preview elements

Supported preview options include:

```lua
Library:SetESPPreviewOption("Box", true)
Library:SetESPPreviewOption("Name", true)
Library:SetESPPreviewOption("Health", true)
Library:SetESPPreviewOption("Distance", true)
Library:SetESPPreviewOption("Tracer", true)
```

Disable one:

```lua
Library:SetESPPreviewOption("Tracer", false)
```

The preview is tied to the ESP tab in the library's built-in behavior. When the `"ESP"` tab is active, the preview is shown; when another tab is active, it is hidden.

The preview is designed to match the library's existing Linoria visual system rather than acting as a separate UI framework.

---

# 26. ESP Preview Example

A simple ESP tab can look like:

```lua
local ESPTab = Window:AddTab("ESP")
local ESPSettings = ESPTab:AddLeftGroupbox("ESP Settings")

local ESPEnabled = ESPSettings:AddToggle("ESPEnabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        Library:SetESPPreviewVisible(Value)
    end,
})

local Box = ESPSettings:AddToggle("ESPBox", {
    Text = "Box",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Box", Value)
    end,
})

local Name = ESPSettings:AddToggle("ESPName", {
    Text = "Name",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Name", Value)
    end,
})

local Health = ESPSettings:AddToggle("ESPHealth", {
    Text = "Health",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Health", Value)
    end,
})

local Distance = ESPSettings:AddToggle("ESPDistance", {
    Text = "Distance",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Distance", Value)
    end,
})

local Tracer = ESPSettings:AddToggle("ESPTracer", {
    Text = "Tracer",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Tracer", Value)
    end,
})
```

If your actual ESP system has its own rendering code, keep that system separate and use the preview API only to synchronize the preview.

---

# 27. Recommended ESP Architecture

If you are building an actual ESP system around this library, keep these responsibilities separate:

```text
Linoria Library
    |
    +-- ESP Preview
    |     +-- Box
    |     +-- Name
    |     +-- Health
    |     +-- Distance
    |     +-- Tracer
    |
    +-- ESP Settings
          +-- Enabled
          +-- Box
          +-- Name
          +-- Health
          +-- Distance
          +-- Tracer
          +-- Max Distance
```

The preview should represent the settings, while the real ESP renderer handles actual players.

For example:

```lua
local function SetESPOption(Name, Value)
    ESPState[Name] = Value

    -- Update your actual ESP objects here.

    -- Keep the library preview synchronized.
    Library:SetESPPreviewOption(Name, Value)
end
```

This prevents the preview and the real ESP from becoming inconsistent.

---

# 28. Theme Colors

The library has an internal theme/color system.

Important color fields include:

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

The default values in this build are defined by the library itself.

When creating custom components, prefer these values instead of inventing a separate palette.

Example:

```lua
Frame.BackgroundColor3 = Library.MainColor
Frame.BorderColor3 = Library.OutlineColor
Label.TextColor3 = Library.FontColor
Highlight.BackgroundColor3 = Library.AccentColor
```

If a component needs to respond to theme changes, register its properties with the library's registry system instead of permanently hardcoding colors.

---

# 29. Theme Registry

The library uses a registry for theme-aware UI elements.

The internal method is:

```lua
Library:AddToRegistry(Instance, Properties)
```

Example:

```lua
Library:AddToRegistry(MyFrame, {
    BackgroundColor3 = "MainColor",
    BorderColor3 = "OutlineColor",
})
```

This allows the library to update the component when its theme values change.

Avoid doing this:

```lua
MyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
```

for a theme-dependent component when a library theme value is available.

Prefer:

```lua
Library:AddToRegistry(MyFrame, {
    BackgroundColor3 = "MainColor",
})
```

---

# 30. Rounded Styling

This fork uses rounded UI throughout its controls.

The internal helper used by the library is:

```lua
ApplySoftStyle(Instance, Radius, OutlineColorName)
```

When adding custom components, follow the existing visual language:

- Small corner radii for controls
- Slightly larger radii for containers
- Thin/subtle borders
- `MainColor` for inner surfaces
- `BackgroundColor` for outer shells
- `OutlineColor` for borders
- `AccentColor` for active/highlighted elements

Do not introduce a second unrelated UI framework or palette.

---

# 31. Tooltips

Many controls support:

```lua
Tooltip = "Description"
```

Example:

```lua
Groupbox:AddToggle("Example", {
    Text = "Example",
    Default = false,
    Tooltip = "Turns the example feature on or off.",
})
```

Disabled tooltips can also be supplied where supported:

```lua
DisabledTooltip = "This option is currently unavailable."
```

---

# 32. Disabling Controls

Many controls support:

```lua
Disabled = true
```

Example:

```lua
Groupbox:AddToggle("Example", {
    Text = "Example",
    Default = false,
    Disabled = true,
})
```

Controls that already exist can generally be disabled with their object method:

```lua
Toggle:SetDisabled(true)
```

and re-enabled:

```lua
Toggle:SetDisabled(false)
```

---

# 33. Visibility

Many controls expose:

```lua
:SetVisible(true)
:SetVisible(false)
```

Example:

```lua
local Toggle = Groupbox:AddToggle("Example", {
    Text = "Example",
    Default = true,
})

Toggle:SetVisible(false)
```

This is preferable to destroying and recreating controls when you only need to temporarily hide them.

---

# 34. Changing Control Text

Many control objects expose:

```lua
:SetText("New Text")
```

Examples:

```lua
Toggle:SetText("New Toggle Name")
Slider:SetText("New Slider Name")
Dropdown:SetText("New Dropdown Name")
Button:SetText("New Button Name")
Label:SetText("New Label")
```

---

# 35. UI Sounds

The library contains UI sound support.

Play a sound:

```lua
Library:PlayUISound(SoundId, Volume, Speed)
```

Example:

```lua
Library:PlayUISound(123456789, 0.5, 1)
```

The library also provides:

```lua
Library:PlayTabSound()
```

and:

```lua
Library:PlayConfigSound()
```

The latter is intended for config/save/load operations when an external config manager is being used.

---

# 36. Unloading the Library

The library provides:

```lua
Library:Unload()
```

Use this when the entire UI and its connections need to be cleaned up.

You can register unload callbacks:

```lua
Library:OnUnload(function()
    print("Library unloaded")
end)
```

If your script creates additional connections or instances outside the library, clean those up as well.

---

# 37. Example Complete Script

Here is a compact example combining the main features:

```lua
local Library = loadstring(game:HttpGet("YOUR_LIBRARY_URL_HERE"))()

local Window = Library:CreateWindow({
    Title = "My Script",
    Size = UDim2.fromOffset(600, 500),
    Center = true,
    AutoShow = true,
})

local MainTab = Window:AddTab("Main")

local Settings = MainTab:AddLeftGroupbox("Settings")

local Enabled = Settings:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})

Enabled:AddKeyPicker("EnabledKey", {
    Default = Enum.KeyCode.RightShift,
    Text = "Toggle",
    Mode = "Toggle",
})

Settings:AddSlider("Speed", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
})

Settings:AddDropdown("Mode", {
    Values = {
        "Normal",
        "Fast",
        "Extreme",
    },
    Default = 1,
    Text = "Mode",
})

Settings:AddInput("Name", {
    Text = "Name",
    Default = "",
    Placeholder = "Enter name...",
})

local ColorToggle = Settings:AddToggle("Color", {
    Text = "Custom Color",
    Default = true,
})

ColorToggle:AddColorPicker("ColorPicker", {
    Default = Library.AccentColor,
    Title = "Color",
})

Settings:AddButton({
    Text = "Test Notification",
    Func = function()
        Library:Notify({
            Title = "Test",
            Description = "Everything is working.",
            Time = 3,
        })
    end,
})

local ESPTab = Window:AddTab("ESP")
local ESP = ESPTab:AddLeftGroupbox("ESP Settings")

ESP:AddToggle("ESPEnabled", {
    Text = "Enabled",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewVisible(Value)
    end,
})

ESP:AddToggle("ESPBox", {
    Text = "Box",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Box", Value)
    end,
})

ESP:AddToggle("ESPName", {
    Text = "Name",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Name", Value)
    end,
})

ESP:AddToggle("ESPHealth", {
    Text = "Health",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Health", Value)
    end,
})

ESP:AddToggle("ESPDistance", {
    Text = "Distance",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Distance", Value)
    end,
})

ESP:AddToggle("ESPTracer", {
    Text = "Tracer",
    Default = true,

    Callback = function(Value)
        Library:SetESPPreviewOption("Tracer", Value)
    end,
})
```

---

# 38. Common Mistakes

## Mistake 1 — Forgetting the ID

Controls such as toggles, sliders, dropdowns, and inputs normally use:

```lua
Groupbox:AddToggle("UniqueID", {
    ...
})
```

Do not reuse the same ID for unrelated controls.

---

## Mistake 2 — Missing required slider fields

A slider needs:

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

---

## Mistake 3 — Missing dropdown values

A dropdown needs:

```lua
Values = {...}
```

Example:

```lua
Groupbox:AddDropdown("Example", {
    Values = {"A", "B", "C"},
    Default = 1,
    Text = "Example",
})
```

---

## Mistake 4 — Passing a non-function button callback

This is incorrect:

```lua
Groupbox:AddButton({
    Text = "Test",
    Func = "hello",
})
```

Use:

```lua
Groupbox:AddButton({
    Text = "Test",
    Func = function()
        print("hello")
    end,
})
```

---

## Mistake 5 — Rebuilding the theme

Do not create another unrelated color system for custom controls.

Use:

```lua
Library.MainColor
Library.BackgroundColor
Library.OutlineColor
Library.AccentColor
Library.FontColor
```

and the registry system where appropriate.

---

## Mistake 6 — Replacing the ESP Preview

The built-in ESP Preview already exists.

Use:

```lua
Library:SetESPPreviewVisible(...)
Library:SetESPPreviewOption(...)
```

instead of creating a second ESP preview window.

---

# 39. Recommended Project Structure

A clean script using this library can be organized like:

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

Keep the actual feature logic outside the UI construction code where possible.

For example:

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

This keeps the Linoria UI layer and the feature implementation easy to maintain.

---

# 40. Quick API Reference

## Library

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
Library:CreateESPPreview()
Library:SetESPPreviewVisible(...)
Library:SetESPPreviewOption(...)
Library:Unload()
Library:OnUnload(...)
```

## Window

```lua
Window:AddTab(...)
Window:Toggle(...)
```

## Tab

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

## Groupbox

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

## Toggle

```lua
Toggle:SetValue(...)
Toggle:OnChanged(...)
Toggle:SetVisible(...)
Toggle:SetDisabled(...)
Toggle:SetText(...)
Toggle:AddKeyPicker(...)
Toggle:AddColorPicker(...)
```

## Slider

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

## Dropdown

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

## Input

Use the returned input object for its supported visibility, disabled-state, text/value, and callback behavior in the current build.

## KeyPicker

```lua
KeyPicker:SetValue(...)
KeyPicker:GetState()
KeyPicker:OnClick(...)
KeyPicker:OnChanged(...)
KeyPicker:DoClick()
KeyPicker:SetModePickerVisibility(...)
KeyPicker:GetModePickerVisibility()
```

## ColorPicker

```lua
ColorPicker:SetValue(...)
ColorPicker:SetValueRGB(...)
ColorPicker:SetHSVFromRGB(...)
ColorPicker:OnChanged(...)
ColorPicker:Show()
ColorPicker:Hide()
```

---

# 41. Important Notes About This Fork

`Library (5).lua` is a customized fork rather than an untouched upstream LinoriaLib build.

The fork contains additional/custom behavior including:

- Rounded groupboxes and controls
- Rounded dropdowns
- Rounded buttons
- Rounded toggles
- Rounded sliders
- Custom theme colors
- Custom image handling
- Mobile UI controls
- Built-in ESP Preview
- ESP preview option synchronization
- UI sound helpers
- Custom cursor support
- Watermark controls
- Additional visual polish

When extending this library, preserve these conventions.

In particular, custom controls should visually use the same:

- `MainColor`
- `BackgroundColor`
- `OutlineColor`
- `AccentColor`
- `FontColor`
- corner-radius philosophy
- typography
- spacing
- hover/highlight behavior
- registry/theme system

That keeps new components visually native to the fork instead of making them look like separate Roblox UI.

---

# 42. Minimal Cheat Sheet

If you only need the basics:

```lua
local Library = loadstring(game:HttpGet("YOUR_LIBRARY_URL_HERE"))()

local Window = Library:CreateWindow({
    Title = "My UI",
    Center = true,
    AutoShow = true,
})

local Tab = Window:AddTab("Main")
local Box = Tab:AddLeftGroupbox("Settings")

Box:AddLabel("Hello")

Box:AddButton({
    Text = "Button",
    Func = function()
        print("Clicked")
    end,
})

Box:AddToggle("Toggle", {
    Text = "Enable",
    Default = false,
})

Box:AddSlider("Slider", {
    Text = "Value",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})

Box:AddDropdown("Dropdown", {
    Values = {"One", "Two", "Three"},
    Default = 1,
    Text = "Mode",
})

Box:AddInput("Input", {
    Text = "Name",
    Default = "",
})

Library:Notify("Loaded!", 3)
```

For ESP:

```lua
Library:SetESPPreviewVisible(true)

Library:SetESPPreviewOption("Box", true)
Library:SetESPPreviewOption("Name", true)
Library:SetESPPreviewOption("Health", true)
Library:SetESPPreviewOption("Distance", true)
Library:SetESPPreviewOption("Tracer", true)
```

---

**Library covered by this guide:** `Library (5).lua`
