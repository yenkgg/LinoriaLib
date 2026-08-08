# LinoriaLib – Yenk's Fork

A **feature-rich, highly customizable UI library** for Roblox, forked from the original **LinoriaLib** and expanded with new themes, video backgrounds, mobile support, polished animations, UI sounds, improved controls, keybind utilities, and quality-of-life improvements.

The goal of this fork is to keep the familiar Linoria-style API while making the library feel more modern, customizable, and enjoyable to use.

---

## Features

* **Clean, modern UI** with a fully customizable color scheme.
* **50+ built-in themes** – from dark and minimal to vibrant and neon.
* **Video background support** – use `.webm` or `.mp4` videos as UI backgrounds per theme.
* **ThemeManager addon** – save/load custom themes, set defaults, and switch themes on the fly.
* **SaveManager addon** – persist UI settings and configurations.
* **Mobile support** – mobile-aware sizing, touch interaction, and mobile-only UI controls.
* **Mobile UI controls** – rounded **Toggle UI** and **Lock/Unlock UI** buttons that follow the active theme.
* **Smooth tab transitions** – polished transitions when switching between tabs.
* **Animated sliders** – smoother slider thumb/value movement.
* **Animated dropdowns** – smooth opening and closing animations.
* **Keybind list support** – display active keybinds in a dedicated UI element.
* **UI sound effects** – sounds for tab switching and configuration actions.
* **Rounded UI elements** – softer corners and a more modern appearance.
* **Theme-aware components** – custom UI elements can register their colors with the theme registry.
* **DPI scaling** – adjust the UI scale for different displays and devices.
* **Notifications** – customizable notifications with optional sound effects.
* **Developer-friendly API** – familiar Linoria-style window, tab, groupbox, and control APIs.
* **Fully documented and modular** – easy to learn, extend, and integrate.

---

## Installation

Load the library and its addons into your script:

```lua
local repo = "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
```

---

## Quick Start

```lua
local Window = Library:CreateWindow({
    Title = "My Awesome Script",
    Center = true,
    AutoShow = true,
})

local MainTab = Window:AddTab("Main", "home")
local SettingsTab = Window:AddTab("Settings", "settings")

local Main = MainTab:AddLeftGroupbox("Settings")

Main:AddToggle("MyToggle", {
    Text = "Enable Feature",
    Default = false,

    Callback = function(Value)
        print("Toggled:", Value)
    end
})

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("MyScriptSettings")
ThemeManager:ApplyToTab(SettingsTab)

SaveManager:SetLibrary(Library)
SaveManager:SetFolder("MyScriptSettings")
SaveManager:BuildConfigSection(SettingsTab)
```

---

# Learning the Library

The basic structure is:

```text
Library
└── Window
    ├── Tab
    │   ├── Left Groupbox
    │   │   └── Controls
    │   └── Right Groupbox
    │       └── Controls
    └── Tab
        └── ...
```

The most important pattern is:

```text
CreateWindow()
    ↓
AddTab()
    ↓
AddLeftGroupbox() / AddRightGroupbox()
    ↓
AddToggle() / AddButton() / AddSlider() / AddDropdown() / etc.
```

If you understand that hierarchy, you understand the core of the library.

---

## Creating a Window

```lua
local Window = Library:CreateWindow({
    Title = "My UI",
    Center = true,
    AutoShow = true,
    Resizable = true,
})
```

Common window options include:

* `Title`
* `Center`
* `AutoShow`
* `Resizable`
* `TabPadding`
* `ShowCustomCursor`
* `Size`
* `Position`

---

## Creating Tabs

```lua
local MainTab = Window:AddTab("Main", "home")
local SettingsTab = Window:AddTab("Settings", "settings")
```

Tabs can contain multiple groupboxes and controls.

---

## Creating Groupboxes

```lua
local Left = MainTab:AddLeftGroupbox("Player")
local Right = MainTab:AddRightGroupbox("Visuals")
```

Groupboxes are useful for keeping related settings together.

For example:

```text
Player
├── Movement
└── Character

Visuals
├── ESP
└── World
```

---

# Controls

## Toggle

```lua
Main:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})
```

The callback receives:

```lua
true
```

or:

```lua
false
```

---

## Button

```lua
Main:AddButton({
    Text = "Click Me",

    Func = function()
        print("Clicked!")
    end,
})
```

Buttons should generally be used for actions rather than persistent states.

---

## Slider

```lua
Main:AddSlider("Speed", {
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

This fork includes smoother slider thumb/value animations.

For decimal values:

```lua
Main:AddSlider("Amount", {
    Text = "Amount",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 2,

    Callback = function(Value)
        print("Amount:", Value)
    end,
})
```

---

## Dropdown

```lua
Main:AddDropdown("Mode", {
    Values = {
        "Default",
        "Fast",
        "Safe",
    },

    Default = 1,
    Text = "Mode",

    Callback = function(Value)
        print("Selected:", Value)
    end,
})
```

Dropdowns include smoother open/close animations.

---

## Input

```lua
Main:AddInput("Username", {
    Text = "Username",
    Default = "",

    Callback = function(Value)
        print("Username:", Value)
    end,
})
```

---

## Label

```lua
Main:AddLabel("Welcome to my script!")
```

Labels are useful for descriptions, information, and section text.

---

# Keybinds

Controls can be paired with keybinds through the key-picker system.

Example:

```lua
local Toggle = Main:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,
})

Toggle:AddKeyPicker("EnabledKey", {
    Default = "F",
    Mode = "Toggle",
    Text = "Toggle Enabled",
})
```

Keybinds are useful for activating features without opening the UI.

---

# Keybind List

The library includes a keybind-list UI for displaying active keybinds.

The keybind frame is exposed through:

```lua
Library.KeybindFrame
```

The library also exposes:

```lua
Library.ShowToggleFrameInKeybinds
```

which controls whether the UI toggle is displayed in the keybind list.

This makes it possible to build a clean floating keybind panel while using the library's existing keybind system.

---

# Themes

The ThemeManager comes with **56 built-in themes** and supports custom themes.

Some included themes are:

| Theme Name         | Accent Color | Vibe                           |
| ------------------ | ------------ | ------------------------------ |
| **Default**        | `#0055ff`    | Classic blue                   |
| **Neon Genesis**   | `#ff00ff`    | Neon pink & purple             |
| **Cyberpunk**      | `#00ffff`    | Bright cyan & dark blue        |
| **Lavender Dream** | `#a885d4`    | Soft purple                    |
| **Sunset Glow**    | `#ff6b35`    | Warm orange & pink             |
| **Monochrome**     | `#888888`    | Sleek grayscale                |
| **Inferno**        | `#ff2200`    | Fiery red                      |
| **Neon Nights**    | `#ff44ff`    | Animated neon / MP4 background |

> **Note:** Neon Nights currently has known bugs.

All available themes can be selected through the ThemeManager UI.

---

# Custom Themes

A theme can define colors such as:

```lua
["My Theme"] = {
    FontColor = "ffffff",
    MainColor = "0a0a1a",
    AccentColor = "00ccff",
    BackgroundColor = "0f0f20",
    OutlineColor = "1e1e3c",
}
```

You can also add a video background:

```lua
["My Theme"] = {
    FontColor = "ffffff",
    MainColor = "0a0a1a",
    AccentColor = "00ccff",
    BackgroundColor = "0f0f20",
    OutlineColor = "1e1e3c",
    VideoLink = "https://example.com/background.webm",
}
```

---

# Video Backgrounds

Themes can optionally have a video background.

Supported formats:

```text
.webm
.mp4
```

Example:

```lua
VideoLink = "https://example.com/background.webm"
```

The video background is configured per theme.

---

# ThemeManager

ThemeManager handles theme functionality.

Setup:

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("MyScriptSettings")
ThemeManager:ApplyToTab(SettingsTab)
```

ThemeManager provides:

* Theme selection
* Custom theme creation
* Custom theme deletion
* Theme saving
* Theme loading
* Default theme support
* Video background configuration
* Switching themes on the fly

---

# Theme-Aware UI

The library has a color registry system that allows UI components to follow theme changes.

Important colors include:

```lua
Library.FontColor
Library.MainColor
Library.BackgroundColor
Library.AccentColor
Library.OutlineColor
```

When creating custom components, register theme-aware properties instead of hard-coding colors.

Example:

```lua
Library:AddToRegistry(MyFrame, {
    BackgroundColor3 = "MainColor",
    BorderColor3 = "OutlineColor",
})
```

This allows the component to update when the active theme changes.

---

# UI Animations

This fork adds several visual improvements.

## Smooth Tab Transitions

Switching tabs uses smoother transitions instead of instantly replacing the visible content.

The goal is to make navigation feel more fluid without changing the underlying tab API.

## Slider Thumb Animations

Slider thumbs smoothly move toward their target position/value.

## Dropdown Animations

Dropdowns smoothly open and close instead of appearing instantly.

These animations are intended to improve the appearance of the library while keeping controls responsive.

---

# UI Sounds

This fork includes Roblox sound effects for common UI actions.

## Tab Switching

The tab switching sound uses Roblox asset ID:

```text
624706518
```

The library exposes:

```lua
Library.TabSwitchSoundId
```

and:

```lua
Library:PlayTabSound()
```

You can manually play it with:

```lua
Library:PlayTabSound()
```

---

## Config Actions

The config sound uses Roblox asset ID:

```text
18628653569
```

The library exposes:

```lua
Library.ConfigSoundId
```

and:

```lua
Library:PlayConfigSound()
```

Example:

```lua
Library:PlayConfigSound()
```

Use it after successful config operations such as saving or loading.

---

## Generic UI Sounds

The library also provides:

```lua
Library:PlayUISound(SoundId, Volume, PlaybackSpeed)
```

Example:

```lua
Library:PlayUISound(624706518, 0.5, 1)
```

This can be used for custom UI interactions.

---

# Notifications

Basic notification:

```lua
Library:Notify("Hello!", 3)
```

Or use a notification table:

```lua
Library:Notify({
    Title = "Success",
    Description = "Config saved!",
    Time = 3,
})
```

Notifications can specify a sound:

```lua
Library:Notify({
    Title = "Success",
    Description = "Done!",
    Time = 3,
    SoundId = Library.ConfigSoundId,
})
```

Config-related notifications can automatically use the config sound when appropriate.

---

# Mobile Support

Mobile support is one of the major improvements in this fork.

The library exposes:

```lua
Library.IsMobile
```

Check it with:

```lua
if Library.IsMobile then
    print("Mobile device detected")
end
```

Mobile support includes:

* Touch-aware dragging
* Mobile-aware sizing
* Larger touch targets
* Mobile-only UI controls
* Rounded Toggle UI button
* Rounded Lock/Unlock UI button
* Theme-aware mobile controls
* Mobile UI state handling

---

# Mobile Toggle UI

Mobile users have a dedicated **Toggle UI** button.

It allows the main library window to be shown or hidden without requiring a desktop keyboard shortcut.

The button:

* Is rounded
* Uses the current theme
* Uses the current accent color
* Is designed for touch input
* Only appears on mobile

---

# Mobile Lock / Unlock UI

Mobile users can lock the UI to prevent accidental dragging.

The lock state uses:

```lua
Library.CantDragForced
```

Lock:

```lua
Library.CantDragForced = true
```

Unlock:

```lua
Library.CantDragForced = false
```

The mobile control switches between:

```text
Lock UI
```

and:

```text
Unlock UI
```

while following the current theme.

---

# DPI Scaling

The library supports DPI scaling for different displays.

Example:

```lua
Library:SetDPIScale(100)
```

Smaller:

```lua
Library:SetDPIScale(90)
```

Larger:

```lua
Library:SetDPIScale(110)
```

This is especially useful when supporting both desktop and mobile.

---

# SaveManager

SaveManager is used to persist UI configuration.

Setup:

```lua
SaveManager:SetLibrary(Library)
SaveManager:SetFolder("MyScriptSettings")
SaveManager:BuildConfigSection(SettingsTab)
```

It can save and load supported UI settings such as:

* Toggles
* Sliders
* Dropdowns
* Keybinds
* Other supported UI values

Configuration files use JSON.

---

# Config Sounds

The config sound can be played after a successful configuration operation:

```lua
Library:PlayConfigSound()
```

For example:

```lua
SaveButton = Config:AddButton({
    Text = "Save Config",

    Func = function()
        -- Save config here

        Library:PlayConfigSound()
        Library:Notify("Config saved!", 2)
    end,
})
```

The important rule is to play the sound **after** the operation succeeds.

---

# Creating Custom Components

When creating custom UI components, use the library's creation and theme systems.

Example:

```lua
local Frame = Library:Create("Frame", {
    BackgroundColor3 = Library.MainColor,
    BorderColor3 = Library.OutlineColor,
    Size = UDim2.fromOffset(200, 50),
    Parent = SomeContainer,
})

Library:AddToRegistry(Frame, {
    BackgroundColor3 = "MainColor",
    BorderColor3 = "OutlineColor",
})
```

This keeps custom components compatible with themes.

---

# Debugging

If something doesn't work, check these first.

## Duplicate IDs

Make sure control IDs are unique:

```lua
Main:AddToggle("PlayerEnabled", ...)
Settings:AddToggle("Notifications", ...)
```

Avoid:

```lua
Main:AddToggle("Enabled", ...)
Main:AddToggle("Enabled", ...)
```

---

## Dropdown Defaults

Make sure the default index exists:

```lua
Values = {
    "One",
    "Two",
    "Three",
},

Default = 1,
```

---

## Theme Colors

If a custom component does not update when the theme changes, check that its theme-aware properties were registered:

```lua
Library:AddToRegistry(Frame, {
    BackgroundColor3 = "MainColor",
})
```

---

# Recommended Way to Learn

If you're new to the library, learn it in this order.

## 1. Learn the hierarchy

Understand:

```text
Window
↓
Tab
↓
Groupbox
↓
Control
```

## 2. Learn the basic controls

Start with:

```text
Label
Button
Toggle
Slider
Dropdown
Input
```

## 3. Learn callbacks

Understand:

```lua
Callback = function(Value)
end
```

This is how UI settings connect to your script's logic.

## 4. Learn keybinds

Learn the key-picker system and how keybinds interact with controls and the keybind list.

## 5. Learn themes

Study:

```lua
Library:AddToRegistry()
```

and the main library color properties.

## 6. Learn the addons

Then learn:

```text
ThemeManager
SaveManager
```

## 7. Study the source

Don't read `Library.lua` from top to bottom.

Search for the API you're learning:

```text
CreateWindow
AddTab
AddToggle
AddSlider
AddDropdown
AddButton
AddInput
Notify
AddToRegistry
UpdateColorsUsingRegistry
```

Find the function and study that section.

---

# Best Practices

## Use descriptive IDs

Good:

```lua
PlayerEnabled
PlayerSpeed
VisualsESP
Notifications
```

Avoid:

```lua
Toggle1
Toggle2
Toggle3
```

---

## Keep callbacks simple

Good:

```lua
Callback = function(Value)
    Enabled = Value
end
```

Then handle the actual feature elsewhere.

Avoid putting an entire feature implementation inside a UI callback.

---

## Organize groupboxes

Good:

```text
Player
├── Movement
└── Combat

Visuals
├── ESP
└── World
```

Avoid putting dozens of unrelated controls into one groupbox.

---

## Keep mobile in mind

When creating custom controls:

* Use reasonable spacing.
* Make touch targets large enough.
* Avoid tiny buttons.
* Test portrait and landscape layouts.
* Make sure the UI can still be moved or locked easily.

---

## Keep custom UI theme-aware

Prefer:

```lua
Library.MainColor
Library.BackgroundColor
Library.AccentColor
Library.OutlineColor
```

and the registry system over hard-coded colors.

---

# Recommended Project Structure

For a larger project:

```text
MyProject/
├── main.lua
├── features/
│   ├── player.lua
│   ├── visuals.lua
│   └── misc.lua
├── ui/
│   ├── main.lua
│   └── settings.lua
└── Library.lua
```

Keeping UI and feature logic separate makes larger projects easier to maintain.

---

# API Quick Reference

| API                                   | Purpose                             |
| ------------------------------------- | ----------------------------------- |
| `Library:CreateWindow()`              | Create a window                     |
| `Window:AddTab()`                     | Create a tab                        |
| `Tab:AddLeftGroupbox()`               | Create a left groupbox              |
| `Tab:AddRightGroupbox()`              | Create a right groupbox             |
| `Groupbox:AddLabel()`                 | Add a label                         |
| `Groupbox:AddButton()`                | Add a button                        |
| `Groupbox:AddToggle()`                | Add a toggle                        |
| `Groupbox:AddSlider()`                | Add a slider                        |
| `Groupbox:AddDropdown()`              | Add a dropdown                      |
| `Groupbox:AddInput()`                 | Add an input                        |
| `Library:Notify()`                    | Show a notification                 |
| `Library:PlayTabSound()`              | Play the tab sound                  |
| `Library:PlayConfigSound()`           | Play the config sound               |
| `Library:PlayUISound()`               | Play a custom UI sound              |
| `Library:SetDPIScale()`               | Change UI scale                     |
| `Library:AddToRegistry()`             | Register theme-aware properties     |
| `Library:UpdateColorsUsingRegistry()` | Update registered colors            |
| `Library:AttemptSave()`               | Attempt a SaveManager save          |
| `Library.IsMobile`                    | Check mobile status                 |
| `Library.CanDrag`                     | Dragging state                      |
| `Library.CantDragForced`              | Force-lock dragging                 |
| `Library.KeybindFrame`                | Keybind list UI                     |
| `Library.ShowToggleFrameInKeybinds`   | Show/hide UI toggle in keybind list |
| `Library.TabSwitchSoundId`            | Tab sound asset ID                  |
| `Library.ConfigSoundId`               | Config sound asset ID               |

---

# Complete Example

```lua
local repo = "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "Example UI",
    Center = true,
    AutoShow = true,
    Resizable = true,
})

local MainTab = Window:AddTab("Main", "home")
local SettingsTab = Window:AddTab("Settings", "settings")

local Player = MainTab:AddLeftGroupbox("Player")
local Visuals = MainTab:AddRightGroupbox("Visuals")

Player:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})

Player:AddSlider("Speed", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,

    Callback = function(Value)
        print("Speed:", Value)
    end,
})

Visuals:AddDropdown("Mode", {
    Values = {
        "Default",
        "Detailed",
        "Minimal",
    },

    Default = 1,
    Text = "Mode",

    Callback = function(Value)
        print("Mode:", Value)
    end,
})

Visuals:AddButton({
    Text = "Test Notification",

    Func = function()
        Library:Notify({
            Title = "Test",
            Description = "Everything is working!",
            Time = 3,
        })
    end,
})

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("MyScriptSettings")
ThemeManager:ApplyToTab(SettingsTab)

SaveManager:SetLibrary(Library)
SaveManager:SetFolder("MyScriptSettings")
SaveManager:BuildConfigSection(SettingsTab)
```

---

# Credits

* **Original LinoriaLib** – for the original base UI library and API.
* **Yenkgg** – fork, theme expansions, video background support, mobile improvements, animations, sounds, and quality-of-life improvements.
* **ChatGPT and DeepSeek** – development assistance, ideas, documentation, and implementation help.

Please preserve the original project's license and attribution requirements when redistributing this fork.

---

# License

This project is available under the **MIT License**, subject to the applicable licensing and attribution requirements of the original LinoriaLib project and included third-party work.

---

# Support

If you encounter bugs, have suggestions, or want to request a feature, open an issue on GitHub or contact the project through the Discord server:

**Discord:** [our discord](https://discord.gg/V4GzTxZvYn)

When reporting a bug, include:

1. What happened
2. What you expected
3. Steps to reproduce it
4. Any relevant errors
5. Whether the issue occurs on desktop, mobile, or both

---

**Happy scripting!**
