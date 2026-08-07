#  LinoriaLib – Yenk's Fork

A **feature‑rich, highly customizable UI library** for Roblox exploits, forked from the original **LinoriaLib** with a ton of new themes, video background support, and quality‑of‑life improvements.

---

##  Features

- **Clean, modern UI** with a fully customizable color scheme.
- **50+ built‑in themes** – from dark and minimal to vibrant and neon.
- **Video background support** – use `.webm` or `.mp4` videos as your UI background (per theme).
- **ThemeManager** addon – save/load custom themes, set defaults, and switch on the fly.
- **SaveManager** addon – persist your UI settings and configurations.
- **Fully documented and modular** – easy to extend and integrate.

---

##  Installation

Load the library and its addons into your script:

```lua
local repo = "https://raw.githubusercontent.com/yenkgg/LinoriaLib/refs/heads/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
```

---

##  Quick Start

```lua
local Window = Library:CreateWindow({
    Title = "My Awesome Script",
    Center = true,
    AutoShow = true,
})

local Tab = Window:AddTab("Main", "home")
local GroupBox = Tab:AddLeftGroupbox("Settings")

GroupBox:AddToggle("MyToggle", {
    Text = "Enable Feature",
    Default = false,
    Callback = function(Value) print("Toggled:", Value) end
})

-- Apply ThemeManager and SaveManager
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("MyScriptSettings")
ThemeManager:ApplyToTab(Window:AddTab("UI Settings", "settings"))

SaveManager:SetLibrary(Library)
SaveManager:SetFolder("MyScriptSettings")
SaveManager:BuildConfigSection(Window:AddTab("UI Settings", "settings"))
```

---

##  Built‑in Themes

The ThemeManager comes with **56** gorgeous themes out‑of‑the‑box (and you can add your own!). Here's a selection:

| Theme Name        | Accent Color | Vibe |
|-------------------|--------------|------|
| **Default**       | `#0055ff`    | Classic blue |
| **Neon Genesis**  | `#ff00ff`    | Neon pink & purple |
| **Cyberpunk**     | `#00ffff`    | Bright cyan & dark blue |
| **Lavender Dream**| `#a885d4`    | Soft purple |
| **Sunset Glow**   | `#ff6b35`    | Warm orange & pink |
| **Monochrome**    | `#888888`    | Sleek grayscale |
| **Inferno**       | `#ff2200`    | Fiery red |
| **Neon Nights**   | `#ff44ff`    | Animated neon (with MP4 background) (has bugs) |
| ... and 48 more!  |              | |

All themes are listed in the ThemeManager dropdown. You can also create your own custom themes via the UI.

---

##  Video Background

You can set a video as the UI background for any theme. Just add a `VideoLink` field to your theme configuration:

```lua
["My Theme"] = {
    FontColor = "ffffff",
    MainColor = "0a0a1a",
    AccentColor = "00ccff",
    BackgroundColor = "0f0f20",
    OutlineColor = "1e1e3c",
    VideoLink = "https://example.com/background.webm"  -- or .mp4
}
```

The library will automatically download and play the video when the theme is selected. Both **.webm** and **.mp4** formats are supported.

---

##  ThemeManager Usage

- **Select a theme** from the dropdown – it applies instantly.
- **Create custom themes** – tweak colors and save them as `.json` files.
- **Set a default theme** – your users will load it automatically on startup.

The ThemeManager addon also provides a full UI for managing all of this – just call `ThemeManager:ApplyToTab()` as shown above.

---

##  Addons

### ThemeManager

Handles all theme‑related functionality, including custom theme creation/deletion, video backgrounds, and default theme loading.

### SaveManager

Saves and loads your UI settings (toggles, sliders, dropdowns, etc.) to/from `.json` files. Perfect for persistent user configurations.

---

##  License

This project is open‑source and available under the **MIT License**. Feel free to use, modify, and distribute it as you wish.

---

##  Credits

- **Original LinoriaLib** – for the amazing base UI library.
- **Yenkgg** – for the fork, theme expansions, video background support, and the good AI prompts.
- **ChatGPT and Deepseek** – for building everything.

---

##  Support

If you encounter issues or have suggestions, please open a ticket on my discord server: https://discord.gg/V4GzTxZvYn

---

**Happy scripting!** 
