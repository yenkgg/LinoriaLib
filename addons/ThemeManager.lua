local cloneref = (cloneref or clonereference or function(instance: any)
    return instance
end)
local clonefunction = (clonefunction or copyfunction or function(func) 
    return func 
end)

local httprequest = request or http_request or (http and http.request)
local getassetfunc = getcustomasset

local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local isfolder, isfile, listfiles = isfolder, isfile, listfiles;

local assert = function(condition, errorMessage) 
    if (not condition) then
        error(if errorMessage then errorMessage else "assert failed", 3)
    end
end

if typeof(clonefunction) == "function" then
    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.

    local
        isfolder_copy,
        isfile_copy,
        listfiles_copy = clonefunction(isfolder), clonefunction(isfile), clonefunction(listfiles)

    local isfolder_success, isfolder_error = pcall(function()
        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
    end)

    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return (if success then data else false)
        end

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return (if success then data else false)
        end

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return (if success then data else {})
        end
    end
end

local ThemeManager = {} do
	local ThemeFields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink" }
	ThemeManager.Folder = "LinoriaLibSettings"
	-- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

	ThemeManager.Library = nil
	ThemeManager.BuiltInThemes = {
		-- OG Default theme (kept)
		['Default']           = { 1, { FontColor = "ffffff", MainColor = "1c1c1c", AccentColor = "0055ff", BackgroundColor = "141414", OutlineColor = "323232" } },
		-- First 10 new themes (previously added)
		['Neon Genesis']      = { 2, { FontColor = "ffffff", MainColor = "0a0a1a", AccentColor = "ff00ff", BackgroundColor = "141428", OutlineColor = "2a2a4a" } },
		['Cyberpunk']         = { 3, { FontColor = "ffffff", MainColor = "0d0d1a", AccentColor = "00ffff", BackgroundColor = "1a1a2e", OutlineColor = "2d2d4a" } },
		['Midnight Rose']     = { 4, { FontColor = "ffffff", MainColor = "1a0a0a", AccentColor = "e6005c", BackgroundColor = "241212", OutlineColor = "3d1c1c" } },
		['Ocean Breeze']      = { 5, { FontColor = "e0f0ff", MainColor = "0a2a3a", AccentColor = "00bcd4", BackgroundColor = "0e3a4a", OutlineColor = "1a4a5a" } },
		['Lavender Dream']    = { 6, { FontColor = "f0e6ff", MainColor = "1a1428", AccentColor = "a885d4", BackgroundColor = "241e3a", OutlineColor = "3a2a5a" } },
		['Forest Night']      = { 7, { FontColor = "d4e8d4", MainColor = "0a1a0a", AccentColor = "3a8c3a", BackgroundColor = "142414", OutlineColor = "2a3a2a" } },
		['Sunset Glow']       = { 8, { FontColor = "fff0d4", MainColor = "2a140a", AccentColor = "ff6b35", BackgroundColor = "3a1e0e", OutlineColor = "5a2e1a" } },
		['Monochrome']        = { 9, { FontColor = "f0f0f0", MainColor = "1a1a1a", AccentColor = "888888", BackgroundColor = "2a2a2a", OutlineColor = "3a3a3a" } },
		['Cotton Candy']      = { 10, { FontColor = "fff5ff", MainColor = "1a1030", AccentColor = "ff66b2", BackgroundColor = "2a1a40", OutlineColor = "4a2a5a" } },
		['Inferno']           = { 11, { FontColor = "fff0e0", MainColor = "1a0800", AccentColor = "ff2200", BackgroundColor = "2a1000", OutlineColor = "4a1a00" } },
		-- 🚀 40 NEW themes (indices 12–51)
		['Aurora']            = { 12, { FontColor = "e0f7ff", MainColor = "0a1a2a", AccentColor = "00e5ff", BackgroundColor = "122a3a", OutlineColor = "2a4a5a" } },
		['Blood Moon']        = { 13, { FontColor = "ffd4d4", MainColor = "1a0000", AccentColor = "cc0000", BackgroundColor = "2a0a0a", OutlineColor = "4a1a1a" } },
		['Candy Crush']       = { 14, { FontColor = "ffffff", MainColor = "1a0a2a", AccentColor = "ff44aa", BackgroundColor = "2a1a3a", OutlineColor = "4a2a5a" } },
		['Dark Void']         = { 15, { FontColor = "c0c0d0", MainColor = "080810", AccentColor = "4444aa", BackgroundColor = "101020", OutlineColor = "202030" } },
		['Electric Blue']     = { 16, { FontColor = "d4f0ff", MainColor = "001020", AccentColor = "0099ff", BackgroundColor = "0a1a2a", OutlineColor = "1a3a4a" } },
		['Frostbite']         = { 17, { FontColor = "e8f8ff", MainColor = "102030", AccentColor = "80d0ff", BackgroundColor = "183040", OutlineColor = "285060" } },
		['Galaxy']            = { 18, { FontColor = "d4c4ff", MainColor = "0a0818", AccentColor = "9944ff", BackgroundColor = "141028", OutlineColor = "28204a" } },
		['Ghost']             = { 19, { FontColor = "e8e8f0", MainColor = "181818", AccentColor = "aabbcc", BackgroundColor = "222222", OutlineColor = "3a3a3a" } },
		['Gold Rush']         = { 20, { FontColor = "fff4d4", MainColor = "1a1400", AccentColor = "ffaa00", BackgroundColor = "2a2000", OutlineColor = "4a3a00" } },
		['Grunge']            = { 21, { FontColor = "cccccc", MainColor = "1c1c1c", AccentColor = "8b6b4b", BackgroundColor = "2a2a2a", OutlineColor = "3a3a3a" } },
		['Highlighter']       = { 22, { FontColor = "ffffff", MainColor = "1a1a00", AccentColor = "ffff00", BackgroundColor = "2a2a0a", OutlineColor = "4a4a1a" } },
		['Hologram']          = { 23, { FontColor = "e0e8ff", MainColor = "0a0a1e", AccentColor = "00ffff", BackgroundColor = "141428", OutlineColor = "28284a" } },
		['Iceberg']           = { 24, { FontColor = "f0ffff", MainColor = "0a1a2a", AccentColor = "66ccff", BackgroundColor = "142a3a", OutlineColor = "2a4a5a" } },
		['Lava']              = { 25, { FontColor = "ffe8d0", MainColor = "1a0800", AccentColor = "ff4400", BackgroundColor = "2a1000", OutlineColor = "4a1a00" } },
		['Lime']              = { 26, { FontColor = "f0ffe0", MainColor = "0a1a00", AccentColor = "66ff44", BackgroundColor = "142a0a", OutlineColor = "2a4a1a" } },
		['Matrix']            = { 27, { FontColor = "b0ffb0", MainColor = "000a00", AccentColor = "00ff00", BackgroundColor = "0a1a0a", OutlineColor = "1a3a1a" } },
		['Miami']             = { 28, { FontColor = "ffd4ff", MainColor = "1a0a2a", AccentColor = "ff44cc", BackgroundColor = "2a1a3a", OutlineColor = "4a2a5a" } },
		['Mystic']            = { 29, { FontColor = "e0d4f0", MainColor = "0e0a1a", AccentColor = "8844cc", BackgroundColor = "1a1428", OutlineColor = "2a2040" } },
		['Nightfall']         = { 30, { FontColor = "c0c8d0", MainColor = "080810", AccentColor = "2244aa", BackgroundColor = "10101a", OutlineColor = "202030" } },
		['Nordic']            = { 31, { FontColor = "e8f0f0", MainColor = "1a2228", AccentColor = "66aacc", BackgroundColor = "2a3238", OutlineColor = "3a4a4a" } },
		['Pastel Dream']      = { 32, { FontColor = "f5f0ff", MainColor = "1a1028", AccentColor = "ccaaff", BackgroundColor = "2a1a40", OutlineColor = "4a2a5a" } },
		['Plasma']            = { 33, { FontColor = "ffe8ff", MainColor = "0a001a", AccentColor = "ff44ff", BackgroundColor = "1a0a2a", OutlineColor = "3a1a4a" } },
		['Royal']             = { 34, { FontColor = "f0e0ff", MainColor = "0a081a", AccentColor = "aa66ff", BackgroundColor = "1a1030", OutlineColor = "2a204a" } },
		['Sakura']            = { 35, { FontColor = "ffeef0", MainColor = "1a0a14", AccentColor = "ff88aa", BackgroundColor = "2a1420", OutlineColor = "4a2a3a" } },
		['Sandstorm']         = { 36, { FontColor = "f4e8d4", MainColor = "2a1a0a", AccentColor = "cc8844", BackgroundColor = "3a2a14", OutlineColor = "5a3a1a" } },
		['Shadow']            = { 37, { FontColor = "c0c0c0", MainColor = "0a0a0a", AccentColor = "666666", BackgroundColor = "181818", OutlineColor = "2a2a2a" } },
		['Solar Flare']       = { 38, { FontColor = "fff4d0", MainColor = "1a0800", AccentColor = "ff8800", BackgroundColor = "2a1200", OutlineColor = "4a2200" } },
		['Spectral']          = { 39, { FontColor = "e8e0ff", MainColor = "0a0818", AccentColor = "8844ee", BackgroundColor = "181028", OutlineColor = "282040" } },
		['Stealth']           = { 40, { FontColor = "d0d0d0", MainColor = "0d0d0d", AccentColor = "445566", BackgroundColor = "1a1a1a", OutlineColor = "2a2a2a" } },
		['Toxic']             = { 41, { FontColor = "d4ffd4", MainColor = "001000", AccentColor = "44ff44", BackgroundColor = "0a1a0a", OutlineColor = "1a3a1a" } },
		['Vaporwave']         = { 42, { FontColor = "f0d0ff", MainColor = "0a0a1a", AccentColor = "ff66cc", BackgroundColor = "141428", OutlineColor = "2a2a4a" } },
		['Wasteland']         = { 43, { FontColor = "d4c8b0", MainColor = "1a140a", AccentColor = "8b7a5a", BackgroundColor = "2a2014", OutlineColor = "4a3a20" } },
		['Zen']               = { 44, { FontColor = "e8f0e0", MainColor = "0a1a0a", AccentColor = "88aa88", BackgroundColor = "142414", OutlineColor = "2a3a2a" } },
		['Amethyst']          = { 45, { FontColor = "f0e4ff", MainColor = "140a1a", AccentColor = "9966cc", BackgroundColor = "1e1428", OutlineColor = "3a2a4a" } },
		['Crimson Tide']      = { 46, { FontColor = "ffdcdc", MainColor = "1a0000", AccentColor = "cc2233", BackgroundColor = "2a0a0a", OutlineColor = "4a1a1a" } },
		['Deep Sea']          = { 47, { FontColor = "d4ecff", MainColor = "00101a", AccentColor = "0077cc", BackgroundColor = "0a1a2a", OutlineColor = "1a3a4a" } },
		['Emerald']           = { 48, { FontColor = "d4f0d4", MainColor = "001000", AccentColor = "22cc66", BackgroundColor = "0a1a0a", OutlineColor = "1a3a1a" } },
		['Flamingo']          = { 49, { FontColor = "ffe0e0", MainColor = "1a0a0a", AccentColor = "ff6699", BackgroundColor = "2a1414", OutlineColor = "4a2a2a" } },
		['Graphite']          = { 50, { FontColor = "d0d0d0", MainColor = "111111", AccentColor = "777777", BackgroundColor = "1a1a1a", OutlineColor = "2a2a2a" } },
		['Obsidian']          = { 51, { FontColor = "c8c8d0", MainColor = "08080c", AccentColor = "3a4a5a", BackgroundColor = "101018", OutlineColor = "202028" } },
		-- 🎬 5 NEW themes with VideoLink (webm background) – indices 52–56
		['Neon Nights']       = { 52, { FontColor = "f0e0ff", MainColor = "0a0a1a", AccentColor = "ff44ff", BackgroundColor = "141428", OutlineColor = "2a2a4a", VideoLink = "https://example.com/neon.webm" } },
		['Cyber City']        = { 53, { FontColor = "e0f0ff", MainColor = "0a0a1e", AccentColor = "00ccff", BackgroundColor = "12122e", OutlineColor = "2a2a5a", VideoLink = "https://example.com/cyber.webm" } },
		['Aurora Borealis']   = { 54, { FontColor = "d4ffd4", MainColor = "001020", AccentColor = "44ff88", BackgroundColor = "0a1a1a", OutlineColor = "1a3a3a", VideoLink = "https://example.com/aurora.webm" } },
		['Lava Flow']         = { 55, { FontColor = "ffd8b0", MainColor = "1a0800", AccentColor = "ff4400", BackgroundColor = "2a1000", OutlineColor = "4a2000", VideoLink = "https://example.com/lava.webm" } },
		['Starry Sky']        = { 56, { FontColor = "e8e8ff", MainColor = "080818", AccentColor = "6688ff", BackgroundColor = "101028", OutlineColor = "202040", VideoLink = "https://example.com/stars.webm" } },
	}

	function ApplyBackgroundVideo(videoLink)
		if
			typeof(videoLink) ~= "string" or
			not (getassetfunc and writefile and readfile and isfile) or
			not (ThemeManager.Library and ThemeManager.Library.InnerVideoBackground)
		then return; end;

		--// Variables \\--
		local videoInstance = ThemeManager.Library.InnerVideoBackground;
		local extension = videoLink:match(".*/(.-)?") or videoLink:match(".*/(.-)$"); extension = tostring(extension);
		local filename = string.sub(extension, 0, -6);
		local _, domain = videoLink:match("^(https?://)([^/]+)"); domain = tostring(domain); -- _ is protocol

		--// Check URL \\--
		if videoLink == "" then
			videoInstance:Pause();
			videoInstance.Video = "";
			videoInstance.Visible = false;
			return
		end
		if #extension > 5 and string.sub(extension, -5) ~= ".webm" then return; end;

		--// Fetch Video Data \\--
		local videoFile = ThemeManager.Folder .. "/themes/" .. string.gsub(domain .. filename, 0, 249) .. ".webm";
		if not isfile(videoFile) then
			local success, requestRes = pcall(httprequest, { Url = videoLink, Method = 'GET' })
			if not (success and typeof(requestRes) == "table" and typeof(requestRes.Body) == "string") then return; end;

			writefile(videoFile, requestRes.Body)
		end

		--// Play Video \\--
		videoInstance.Video = getassetfunc(videoFile);
		videoInstance.Visible = true;
		videoInstance:Play();
	end

	function ThemeManager:SetLibrary(library)
		self.Library = library
	end

	--// Folders \\--
	function ThemeManager:GetPaths()
	    local paths = {}

		local parts = self.Folder:split('/')
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, '/', 1, idx)
		end

		paths[#paths + 1] = self.Folder .. '/themes'
		
		return paths
	end

	function ThemeManager:BuildFolderTree()
		local paths = self:GetPaths()

		for i = 1, #paths do
			local str = paths[i]
			if isfolder(str) then continue end
			makefolder(str)
		end
	end

	function ThemeManager:CheckFolderTree()
		if isfolder(self.Folder) then return end
		self:BuildFolderTree()

		task.wait(0.1)
	end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end
	
	--// Apply, Update theme \\--
	function ThemeManager:ApplyTheme(theme)
		local customThemeData = self:GetCustomTheme(theme)
		local data = customThemeData or self.BuiltInThemes[theme]

		if not data then return end

		-- custom themes are just regular dictionaries instead of an array with { index, dictionary }
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end
		
		local scheme = data[2]
		for idx, col in next, customThemeData or scheme do
			if idx == "VideoLink" then
				self.Library[idx] = col
				
				if self.Library.Options[idx] then
					self.Library.Options[idx]:SetValue(col)
				end
				
				ApplyBackgroundVideo(col)
			else
				self.Library[idx] = Color3.fromHex(col)
				
				if self.Library.Options[idx] then
					self.Library.Options[idx]:SetValueRGB(Color3.fromHex(col))
				end
			end
		end

		self:ThemeUpdate()
	end

	function ThemeManager:ThemeUpdate()
		-- This allows us to force apply themes without loading the themes tab :)
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end

		for i, field in next, ThemeFields do
			if self.Library.Options and self.Library.Options[field] then
				self.Library[field] = self.Library.Options[field].Value

				if field == "VideoLink" then
					ApplyBackgroundVideo(self.Library.Options[field].Value)
				end
			end
		end

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry()
	end

	--// Get, Load, Save, Delete, Refresh \\--
	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. '/themes/' .. file .. '.json'
		if not isfile(path) then
			return nil
		end

		local data = readfile(path)
		local success, decoded = pcall(HttpService.JSONDecode, HttpService, data)
		
		if not success then
			return nil
		end

		return decoded
	end

	function ThemeManager:LoadDefault()
		local theme = 'Default'
		local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')

		local isDefault = true
		if content then
			if self.BuiltInThemes[content] then
				theme = content
			elseif self:GetCustomTheme(content) then
				theme = content
				isDefault = false;
			end
		elseif self.BuiltInThemes[self.DefaultTheme] then
			theme = self.DefaultTheme
		end

		if isDefault then
			self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
		else
			self:ApplyTheme(theme)
		end
	end

	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. '/themes/default.txt', theme)
	end

	function ThemeManager:SaveCustomTheme(file)
		if file:gsub(' ', '') == '' then
			self.Library:Notify('Invalid file name for theme (empty)', 3)
			return
		end

		local theme = {}
		for _, field in next, ThemeFields do
			if field == "VideoLink" then
				theme[field] = self.Library.Options[field].Value
			else
				theme[field] = self.Library.Options[field].Value:ToHex()
			end
		end

		writefile(self.Folder .. '/themes/' .. file .. '.json', HttpService:JSONEncode(theme))
	end

	function ThemeManager:Delete(name)
		if (not name) then
			return false, 'no config file is selected'
		end

		local file = self.Folder .. '/themes/' .. name .. '.json'
		if not isfile(file) then return false, 'invalid file' end

		local success = pcall(delfile, file)
		if not success then return false, 'delete file error' end
		
		return true
	end
	
	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. '/themes')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				-- i hate this but it has to be done ...

				local pos = file:find('.json', 1, true)
				local start = pos

				local char = file:sub(pos, pos)
				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1, start - 1))
				end
			end
		end

		return out
	end

	--// GUI \\--
	function ThemeManager:CreateThemeManager(groupbox)
		groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
		groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
		groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
		groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
		groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
		groupbox:AddInput('VideoLink', { Text = '.webm Video Background (Link)', Default = self.Library.VideoLink });
		
		local ThemesArray = {}
		for Name, Theme in next, self.BuiltInThemes do
			table.insert(ThemesArray, Name)
		end

		table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
		groupbox:AddButton('Set as default', function()
			self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
			self.Library:Notify(string.format('Set default theme to %q', self.Library.Options.ThemeManager_ThemeList.Value))
		end)

		self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
			self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
		end)

		groupbox:AddDivider()

		groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
		groupbox:AddButton('Create theme', function() 
			local name = self.Library.Options.ThemeManager_CustomThemeName.Value
			if name:gsub(" ", "") == "" then
                self.Library:Notify("Invalid theme name (empty)", 2)
                return
            end

            self:SaveCustomTheme(name)

            self.Library:Notify(string.format("Created theme %q", name))
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
		groupbox:AddButton('Load theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			self:ApplyTheme(name)
			self.Library:Notify(string.format('Loaded theme %q', name))
		end)
		groupbox:AddButton('Overwrite theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			self:SaveCustomTheme(name)
			self.Library:Notify(string.format('Overwrote config %q', name))
		end)
		groupbox:AddButton('Delete theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			local success, err = self:Delete(name)
			if not success then
				self.Library:Notify('Failed to delete theme: ' .. err)
				return
			end

			self.Library:Notify(string.format('Deleted theme %q', name))
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Refresh list', function()
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Set as default', function()
			if self.Library.Options.ThemeManager_CustomThemeList.Value ~= nil and self.Library.Options.ThemeManager_CustomThemeList.Value ~= '' then
				self:SaveDefault(self.Library.Options.ThemeManager_CustomThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', self.Library.Options.ThemeManager_CustomThemeList.Value))
			end
		end)
		groupbox:AddButton('Reset default', function()
			local success = pcall(delfile, self.Folder .. '/themes/default.txt')
			if not success then 
				self.Library:Notify('Failed to reset default: delete file error')
				return
			end
				
			self.Library:Notify('Set default theme to nothing')
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		self:LoadDefault()

		local function UpdateTheme() self:ThemeUpdate() end
		self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
		self.Library.Options.MainColor:OnChanged(UpdateTheme)
		self.Library.Options.AccentColor:OnChanged(UpdateTheme)
		self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
		self.Library.Options.FontColor:OnChanged(UpdateTheme)
	end

	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, 'ThemeManager:CreateGroupBox -> Must set ThemeManager.Library first!')
		return tab:AddLeftGroupbox('Themes')
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, 'ThemeManager:ApplyToTab -> Must set ThemeManager.Library first!')
		local groupbox = self:CreateGroupBox(tab)
		self:CreateThemeManager(groupbox)
	end

	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, 'ThemeManager:ApplyToGroupbox -> Must set ThemeManager.Library first!')
		self:CreateThemeManager(groupbox)
	end

	ThemeManager:BuildFolderTree()
end

getgenv().LinoriaThemeManager = ThemeManager
return ThemeManager
