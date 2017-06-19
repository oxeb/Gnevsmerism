local LibAddOnMenu2 = LibStub:GetLibrary("LibAddonMenu-2.0")

Gnevsmerism = {}
Gnevsmerism.name = "Gnevsmerism"
Gnevsmerism.version = 1

Gnevsmerism.mainBarActive = true

Gnevsmerism.settingsName = "Gnevsmerism"
Gnevsmerism.settingsAuthor = "Gnevsyrom"
Gnevsmerism.settingsCommand = "/gnmc"
Gnevsmerism.settingsVersion = "0.0.1"

Gnevsmerism.default = {
	dawnWarriorMode = "On",
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
		Gnevsmerism_DawnWarriorMode_Control:SetHidden(false)
		if Gnevsmerism.mainBarActive then
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetEdgeColor(1.0, 0.0, 0.0, 1.0)
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetCenterColor(1.0, 0.0, 0.0, 1.0)
		else
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetEdgeColor(0.0, 0.0, 1.0, 1.0)
			Gnevsmerism_DawnWarriorMode_ControlBackdrop:SetCenterColor(0.0, 0.0, 1.0, 1.0)
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
	}

	local settingsPanelHandle = LibAddOnMenu2:RegisterAddonPanel("Gnevsmerism_Gnevsyrom", settingsPanelData)
	LibAddOnMenu2:RegisterOptionControls("Gnevsmerism_Gnevsyrom", settingsPanelControlData)
end

function Gnevsmerism.OnAddOnLoaded(event, addOnName)
	if addOnName == Gnevsmerism.name then
		Gnevsmerism:Initialize()
	end
end

EVENT_MANAGER:RegisterForEvent(Gnevsmerism.name, EVENT_ADD_ON_LOADED, Gnevsmerism.OnAddOnLoaded)