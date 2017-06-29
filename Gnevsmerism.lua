local LibAddOnMenu2 = LibStub:GetLibrary("LibAddonMenu-2.0")

Gnevsmerism = {}
Gnevsmerism.name = "Gnevsmerism"
Gnevsmerism.version = 1

Gnevsmerism.mainBarActive = true

Gnevsmerism.settingsName = "Gnevsmerism"
Gnevsmerism.settingsAuthor = "Gnevsyrom"
Gnevsmerism.settingsCommand = "/gnmc"
Gnevsmerism.settingsVersion = "0.0.2"

Gnevsmerism.default = {
	dawnWarriorMode = "On",
	dawnWarriorModeMainBarRed = 1.0,
	dawnWarriorModeMainBarGreen = 0.0,
	dawnWarriorModeMainBarBlue = 0.0,
	dawnWarriorModeMainBarAlpha = 1.0,
	dawnWarriorModeBackupBarRed = 0.0,
	dawnWarriorModeBackupBarGreen = 0.0,
	dawnWarriorModeBackupBarBlue = 1.0,
	dawnWarriorModeBackupBarAlpha = 1.0,
	dawnWarriorModeTop = -80,
	dawnWarriorModeRight = 64,
	dawnWarriorModeWidth = 336,
	dawnWarriorModeHeight = 448,
}

function Gnevsmerism:ProcessDawnWarriorMode()
	local activeWeaponPair, activeWeaponPairLocked = GetActiveWeaponPairInfo()
	if activeWeaponPair == ACTIVE_WEAPON_PAIR_MAIN then
		Gnevsmerism.mainBarActive = true
	else
		Gnevsmerism.mainBarActive = false
	end
	if self.savedVariables.dawnWarriorMode ~= "On" then
		Gnevsmerism_DawnWarriorMode_Control:SetHidden(true)
	else
		Gnevsmerism_DawnWarriorMode_Control:ClearAnchors()
		Gnevsmerism_DawnWarriorMode_Control:SetAnchor(TOPRIGHT, GuiRoot, CENTER, self.savedVariables.dawnWarriorModeRight, self.savedVariables.dawnWarriorModeTop)
		Gnevsmerism_DawnWarriorMode_Control:SetDimensions(self.savedVariables.dawnWarriorModeWidth, self.savedVariables.dawnWarriorModeHeight)
		Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetDimensions(self.savedVariables.dawnWarriorModeWidth, self.savedVariables.dawnWarriorModeHeight)
		Gnevsmerism_DawnWarriorMode_Control:SetHidden(false)
		if Gnevsmerism.mainBarActive then
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetEdgeColor(
				self.savedVariables.dawnWarriorModeMainBarRed,
				self.savedVariables.dawnWarriorModeMainBarGreen,
				self.savedVariables.dawnWarriorModeMainBarBlue,
				self.savedVariables.dawnWarriorModeMainBarAlpha)
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetCenterColor(
				self.savedVariables.dawnWarriorModeMainBarRed,
				self.savedVariables.dawnWarriorModeMainBarGreen,
				self.savedVariables.dawnWarriorModeMainBarBlue,
				self.savedVariables.dawnWarriorModeMainBarAlpha)
		else
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetEdgeColor(
				self.savedVariables.dawnWarriorModeBackupBarRed,
				self.savedVariables.dawnWarriorModeBackupBarGreen,
				self.savedVariables.dawnWarriorModeBackupBarBlue,
				self.savedVariables.dawnWarriorModeBackupBarAlpha)
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetCenterColor(
				self.savedVariables.dawnWarriorModeBackupBarRed,
				self.savedVariables.dawnWarriorModeBackupBarGreen,
				self.savedVariables.dawnWarriorModeBackupBarBlue,
				self.savedVariables.dawnWarriorModeBackupBarAlpha)
		end
	end
end

function Gnevsmerism.OnPlayerActivated(event, initial)
	Gnevsmerism:ProcessDawnWarriorMode()
end

function Gnevsmerism.OnActionSlotsFullUpdate(eventCode, isHotBarSwap)
	Gnevsmerism:ProcessDawnWarriorMode()
end

function Gnevsmerism:Initialize()
	EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_ADD_ON_LOADED)

	self.savedVariables = ZO_SavedVars:NewAccountWide("GnevsmerismSavedVariables", self.version, nil, self.default)

	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, self.OnPlayerActivated)
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_ACTION_SLOTS_FULL_UPDATE, self.OnActionSlotsFullUpdate)
	
	self:Settings()
end

function Gnevsmerism:GetDawnWarriorMode()
	return self.savedVariables.dawnWarriorMode
end

function Gnevsmerism:SetDawnWarriorMode(value)
	self.savedVariables.dawnWarriorMode = value
	Gnevsmerism:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeMainBarColor()
	local r = self.savedVariables.dawnWarriorModeMainBarRed
	local g = self.savedVariables.dawnWarriorModeMainBarGreen
	local b = self.savedVariables.dawnWarriorModeMainBarBlue
	local a = self.savedVariables.dawnWarriorModeMainBarAlpha
	return r, g, b, a
end

function Gnevsmerism:SetDawnWarriorModeMainBarColor(r, g, b, a)
	self.savedVariables.dawnWarriorModeMainBarRed = r
	self.savedVariables.dawnWarriorModeMainBarGreen = g
	self.savedVariables.dawnWarriorModeMainBarBlue = b
	self.savedVariables.dawnWarriorModeMainBarAlpha = a
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeBackupBarColor()
	local r = self.savedVariables.dawnWarriorModeBackupBarRed
	local g = self.savedVariables.dawnWarriorModeBackupBarGreen
	local b = self.savedVariables.dawnWarriorModeBackupBarBlue
	local a = self.savedVariables.dawnWarriorModeBackupBarAlpha
	return r, g, b, a
end

function Gnevsmerism:SetDawnWarriorModeBackupBarColor(r, g, b, a)
	self.savedVariables.dawnWarriorModeBackupBarRed = r
	self.savedVariables.dawnWarriorModeBackupBarGreen = g
	self.savedVariables.dawnWarriorModeBackupBarBlue = b
	self.savedVariables.dawnWarriorModeBackupBarAlpha = a
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeRight()
	return self.savedVariables.dawnWarriorModeRight
end

function Gnevsmerism:SetDawnWarriorModeRight(value)
	self.savedVariables.dawnWarriorModeRight = value
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeTop()
	return self.savedVariables.dawnWarriorModeTop
end

function Gnevsmerism:SetDawnWarriorModeTop(value)
	self.savedVariables.dawnWarriorModeTop = value
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeWidth()
	return self.savedVariables.dawnWarriorModeWidth
end

function Gnevsmerism:SetDawnWarriorModeWidth(value)
	self.savedVariables.dawnWarriorModeWidth = value
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:GetDawnWarriorModeHeight()
	return self.savedVariables.dawnWarriorModeHeight
end

function Gnevsmerism:SetDawnWarriorModeHeight(value)
	self.savedVariables.dawnWarriorModeHeight = value
	self:ProcessDawnWarriorMode()
end

function Gnevsmerism:Settings()
	local settingsPanelData = {
		type = "panel",
		name = self.settingsName,
		displayName = self.settingsName,
		author = self.settingsAuthor,
		version = self.settingsVersion,
		slashCommand = self.settingsCommand,
		registerForRefresh = true,
		registerForDefaults = true,
	}
	local settingsPanelControlData = {
		[1] = {
			type = "header",
			name = "Gnevsmerism Modes",
		},
		[2] = {
			type = "description",
			text = "Enable and disable the various Gnevsmerism modes",
		},
		[3] = {
			type = "dropdown",
			name = "DawnWarrior Mode",
			tooltip = "",
			choices = {"On", "Off", },
			getFunc = function() return Gnevsmerism:GetDawnWarriorMode() end,
			setFunc = function(value) Gnevsmerism:SetDawnWarriorMode(value) end,
			width = "full",
			default = self.default.dawnWarriorMode,
		},
		[4] = {
			type = "header",
			name = "DawnWarrior Mode",
		},
		[5] = {
			type = "description",
			text = "Configure DawnWarrior Mode",
		},
		[6] = {
			type = "colorpicker",
			name = "Main Bar Color",
			tooltip = "",
			getFunc = function()
				local r, g, b, a = Gnevsmerism:GetDawnWarriorModeMainBarColor() 
				return r, g, b, a
			 end,
			setFunc = function(r, g, b, a)
				Gnevsmerism:SetDawnWarriorModeMainBarColor(r, g, b, a)
			end,
			width = "full",
			default = {
				r = self.default.dawnWarriorModeMainBarRed,
				g = self.default.dawnWarriorModeMainBarGreen,
				b = self.default.dawnWarriorModeMainBarBlue,
				a = self.default.dawnWarriorModeMainBarAlpha,
			},
		},
		[7] = {
			type = "colorpicker",
			name = "Backup Bar Color",
			tooltip = "",
			getFunc = function()
				local r, g, b, a = Gnevsmerism:GetDawnWarriorModeBackupBarColor() 
				return r, g, b, a
			 end,
			setFunc = function(r, g, b, a)
				Gnevsmerism:SetDawnWarriorModeBackupBarColor(r, g, b, a)
			end,
			width = "full",
			default = {
				r = self.default.dawnWarriorModeBackupBarRed,
				g = self.default.dawnWarriorModeBackupBarGreen,
				b = self.default.dawnWarriorModeBackupBarBlue,
				a = self.default.dawnWarriorModeBackupBarAlpha,
			},
		},
		[8] = {
			type = "slider",
			name = "Right",
			tooltip = "",
			min = -512,
			max = 512,
			step = 1,
			getFunc = function() return Gnevsmerism:GetDawnWarriorModeRight() end,
			setFunc = function(value) Gnevsmerism:SetDawnWarriorModeRight(value) end,
			width = "full",
			default = self.default.dawnWarriorModeRight,
		},
		[9] = {
			type = "slider",
			name = "Top",
			tooltip = "",
			min = -512,
			max = 512,
			step = 1,
			getFunc = function() return Gnevsmerism:GetDawnWarriorModeTop() end,
			setFunc = function(value) Gnevsmerism:SetDawnWarriorModeTop(value) end,
			width = "full",
			default = self.default.dawnWarriorModeTop,
		},
		[10] = {
			type = "slider",
			name = "Width",
			tooltip = "",
			min = 1,
			max = 1024,
			step = 1,
			getFunc = function() return Gnevsmerism:GetDawnWarriorModeWidth() end,
			setFunc = function(value) Gnevsmerism:SetDawnWarriorModeWidth(value) end,
			width = "full",
			default = self.default.dawnWarriorModeWidth,
		},		
		[11] = {
			type = "slider",
			name = "Height",
			tooltip = "",
			min = 1,
			max = 1024,
			step = 1,
			getFunc = function() return Gnevsmerism:GetDawnWarriorModeHeight() end,
			setFunc = function(value) Gnevsmerism:SetDawnWarriorModeHeight(value) end,
			width = "full",
			default = self.default.dawnWarriorModeHeight,
		},		
	}

	local settingsPanelHandle = LibAddOnMenu2:RegisterAddonPanel("Gnevsmerism_Gnevsyrom", settingsPanelData)
	LibAddOnMenu2:RegisterOptionControls("Gnevsmerism_Gnevsyrom", settingsPanelControlData)
end

function Gnevsmerism.OnToggleBinding()
	if Gnevsmerism.savedVariables.dawnWarriorMode == "On" then
		Gnevsmerism.savedVariables.dawnWarriorMode = "Off"
	else
		Gnevsmerism.savedVariables.dawnWarriorMode = "On"
	end
	Gnevsmerism:ProcessDawnWarriorMode()
end

function Gnevsmerism.OnAddOnLoaded(event, addOnName)
	if addOnName == Gnevsmerism.name then
		Gnevsmerism:Initialize()
	end
end

EVENT_MANAGER:RegisterForEvent(Gnevsmerism.name, EVENT_ADD_ON_LOADED, Gnevsmerism.OnAddOnLoaded)