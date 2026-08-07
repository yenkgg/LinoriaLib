# LinoriaLib (yenk's edition)

A customized fork of **LinoriaLib**, focused on keeping the familiar LinoriaLib API while providing additional UI improvements, customization, and mobile support.

> **Note:** This project is a fork/customized version of LinoriaLib. Some behavior, styling, and features may differ from the original project.

## Features

* LinoriaLib-style API
* Custom UI styling
* Tabs and groupboxes
* Toggles
* Sliders
* Dropdowns
* Buttons
* Text inputs
* Keybinds
* Color pickers
* Notifications
* Mobile support
* Mobile-specific UI controls
* UI locking / unlocking
* Resizable interface
* Custom cursor support

## Installation

Load the library using your preferred method:

```lua
local Library = loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()
```

Replace `YOUR_RAW_GITHUB_URL` with the raw URL to your fork's `Library.lua`.

## Basic Usage

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Center = true,
    AutoShow = true,
})

local MainTab = Window:AddTab("Main")
local SettingsTab = Window:AddTab("Settings")

local Main = MainTab:AddLeftGroupbox("Main")
local Settings = SettingsTab:AddLeftGroupbox("Settings")

Main:AddToggle("Enabled", {
    Text = "Enabled",
    Default = false,

    Callback = function(Value)
        print("Enabled:", Value)
    end,
})

Settings:AddButton({
    Text = "Test Button",

    Func = function()
        Library:Notify("Hello!", 2)
    end,
})
```

## Documentation

The basic hierarchy is:

```text
Library
└── Window
    ├── Tabs
    │   ├── Left Groupbox
    │   │   └── Controls
    │   └── Right Groupbox
    │       └── Controls
```

Most interfaces follow this pattern:

```lua
local Window = Library:CreateWindow(...)
local Tab = Window:AddTab("Main")
local Groupbox = Tab:AddLeftGroupbox("Example")

Groupbox:AddToggle(...)
Groupbox:AddButton(...)
Groupbox:AddSlider(...)
Groupbox:AddDropdown(...)
```

## Mobile Support

This fork includes mobile-specific functionality.

You can check whether the library is running on a mobile device with:

```lua
if Library.IsMobile then
    print("Mobile device detected")
end
```

Mobile-specific controls should only be created when `Library.IsMobile` is true.

The mobile interface includes controls for:

* Showing/hiding the UI
* Locking/unlocking UI movement
* Touch-based interaction

Desktop users keep the normal desktop interface and behavior.

## What's Different From LinoriaLib?

This fork is intended to preserve the familiar LinoriaLib structure while adding/customizing functionality.

Changes in this fork may include:

* UI appearance changes
* Mobile improvements
* Mobile UI controls
* Dragging/locking changes
* Additional customization
* Bug fixes and quality-of-life improvements

The API may remain compatible with existing LinoriaLib code where possible, but fork-specific behavior should be documented here.

## Contributing

If you find a bug or have an improvement for the library, open an issue or submit a pull request.

When submitting an issue, include:

1. What happened
2. What you expected to happen
3. A reproducible example
4. Any relevant errors

## License

This project follows the license and attribution requirements of the original LinoriaLib project, along with any additional terms applicable to modifications in this fork.
