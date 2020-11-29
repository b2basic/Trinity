local trinity = select (2, ...)

local frame = CreateFrame ('Frame')

for trinityUnit, mod in pairs (trinity['mods']) do
	for arenaIndex, key in pairs (trinity['keys']) do
		local button = CreateFrame ('Button', 'Trinity' .. trinityUnit .. arenaIndex, nil, 'SecureActionButtonTemplate')
		button:SetAttribute ('type', 'macro')
		if trinityUnit ~= 'other' then
			button:SetAttribute ('macrotext', '/' .. trinityUnit .. ' arena' .. arenaIndex)
		else
			button:SetAttribute ('macrotext', '/changeactionbar ' .. (arenaIndex + 1))
		end
	end
end

local setBindings = function()
	for trinityUnit, mod in pairs (trinity['mods']) do
		for arenaIndex, key in pairs (trinity['keys']) do
			SetBindingClick (mod .. '-' .. key, _G['Trinity' .. trinityUnit .. arenaIndex]:GetName())
		end
	end
end

for i = 1, 3 do
	local texture = frame:CreateTexture ('TrinityTexture' .. i, 'BACKGROUND', nil, 1 - i)
	texture:SetTexture ('Interface\\PvPRankBadges\\PvPRank0' .. i)
	texture:SetScale (0.7)
end

local attachTextures = function()
	for i, unit in pairs ({ 'target', 'focus', 'arena' .. (GetActionBarPage() - 1) }) do
		plate = C_NamePlate.GetNamePlateForUnit (unit)
		if not plate then _G['TrinityTexture' .. i]:Hide()
		else
			_G['TrinityTexture' .. i]:Show()
			_G['TrinityTexture' .. i]:SetPoint ('TOPRIGHT', plate['UnitFrame'])
		end
	end
	return
end

local hideTextures = function()
	for i = 1, 3 do _G['TrinityTexture' .. i]:Hide() end
end

frame:RegisterEvent ('PLAYER_TARGET_CHANGED')
frame:RegisterEvent ('PLAYER_FOCUS_CHANGED')
frame:RegisterEvent ('ACTIONBAR_PAGE_CHANGED')
frame:RegisterEvent ('NAME_PLATE_UNIT_ADDED')
frame:RegisterEvent ('NAME_PLATE_UNIT_REMOVED')
frame:RegisterEvent ('GROUP_ROSTER_UPDATE')
frame:SetScript ('OnEvent', function (self, event)
	if trinity['trinitied'] then attachTextures() end
end)

trinity['target'] = function()
	setBindings()
	attachTextures()
end

trinity['untarget'] = function()
	hideTextures()
end
