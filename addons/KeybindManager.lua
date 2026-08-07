-- KeybindManager.lua
-- Integrates with LinoriaLib and SaveManager

local KeybindManager = {}
local UserInputService = game:GetService("UserInputService")

-- Internal storage
local Keybinds = {}  -- key = "FeatureName", value = { KeyCode = Enum.KeyCode, Modifiers = table }
local Listeners = {} -- key = feature name, value = callback function

-- UI component: KeybindPicker
-- Returns a button-like object that shows current key and allows rebinding
function KeybindManager:CreateKeybindPicker(featureName, callback, defaultKey)
    -- featureName: string, unique identifier
    -- callback: function(isDown) -> fired when key state changes (down/up)
    -- defaultKey: optional table { KeyCode = Enum.KeyCode, Modifiers = {Enum.KeyCode} }

    local btn = self.Library:AddButton(featureName, function()
        -- Start listening for a new key
        local oldKey = Keybinds[featureName]
        self:StartListening(featureName, function(newKey)
            Keybinds[featureName] = newKey
            btn:SetText(self:GetKeyDisplay(newKey))
            self:Save()
            if callback then callback(newKey) end
        end)
    end)
    -- Set initial display
    local initialKey = Keybinds[featureName] or defaultKey or { KeyCode = Enum.KeyCode.None }
    btn:SetText(self:GetKeyDisplay(initialKey))
    return btn
end

-- Start listening for a key press
function KeybindManager:StartListening(featureName, callback)
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local keyCode = input.KeyCode
            if keyCode ~= Enum.KeyCode.Unknown then
                -- Capture modifiers
                local modifiers = {}
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                    table.insert(modifiers, Enum.KeyCode.LeftControl)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    table.insert(modifiers, Enum.KeyCode.LeftShift)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
                    table.insert(modifiers, Enum.KeyCode.LeftAlt)
                end
                local newKey = { KeyCode = keyCode, Modifiers = modifiers }
                callback(newKey)
                connection:Disconnect()
            end
        end
    end)
end

-- Helper: display key as string
function KeybindManager:GetKeyDisplay(keybind)
    if not keybind or keybind.KeyCode == Enum.KeyCode.None then
        return "Unbound"
    end
    local parts = {}
    for _, mod in ipairs(keybind.Modifiers or {}) do
        table.insert(parts, tostring(mod):gsub("Enum.KeyCode.", ""))
    end
    table.insert(parts, tostring(keybind.KeyCode):gsub("Enum.KeyCode.", ""))
    return table.concat(parts, "+")
end

-- Save/Load using SaveManager or internal config
function KeybindManager:Save()
    if self.SaveManager then
        self.SaveManager:SetData("Keybinds", Keybinds)
    else
        -- fallback to writefile
        writefile(self.Folder .. "/keybinds.json", game:GetService("HttpService"):JSONEncode(Keybinds))
    end
end

function KeybindManager:Load()
    if self.SaveManager then
        Keybinds = self.SaveManager:GetData("Keybinds") or {}
    else
        if isfile(self.Folder .. "/keybinds.json") then
            local data = readfile(self.Folder .. "/keybinds.json")
            Keybinds = game:GetService("HttpService"):JSONDecode(data) or {}
        end
    end
    -- Restore listeners (callbacks)
    for name, bind in pairs(Keybinds) do
        if Listeners[name] then
            self:RegisterKeybind(name, bind, Listeners[name])
        end
    end
end

-- Register a keybind to a callback (used internally)
function KeybindManager:RegisterKeybind(featureName, keybind, callback)
    if Listeners[featureName] then
        -- Remove old connection if any
        if Listeners[featureName].Connection then
            Listeners[featureName].Connection:Disconnect()
        end
    end
    local conn
    local isDown = false
    conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == keybind.KeyCode then
                -- Check modifiers
                local modMatch = true
                for _, mod in ipairs(keybind.Modifiers or {}) do
                    if not UserInputService:IsKeyDown(mod) then modMatch = false; break end
                end
                if modMatch and not isDown then
                    isDown = true
                    callback(true) -- Key down
                end
            end
        end
    end)
    local connEnd = UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == keybind.KeyCode and isDown then
                isDown = false
                callback(false) -- Key up
            end
        end
    end)
    Listeners[featureName] = { Connection = conn, EndConnection = connEnd }
end

-- Set Library and SaveManager references
function KeybindManager:SetLibrary(library)
    self.Library = library
end

function KeybindManager:SetSaveManager(saveManager)
    self.SaveManager = saveManager
    self.Folder = saveManager.Folder or "KeybindSettings"
end

-- Initialize
function KeybindManager:Init()
    self:Load()
end

return KeybindManager
