local trinity = select (2, ...)

trinity['targetUnits'] = { [1] = 'target', [2] = 'focus', [3] = nil }

local frame = CreateFrame ('Frame')

local textures = {}
for i = 1, 3 do
	textures[i] = frame:CreateTexture (nil, 'BACKGROUND', nil, 3 - i)
	textures[i]:SetTexture ('Interface\\PvPRankBadges\\PvPRank0' .. i)
	textures[i]:SetScale (0.7)
end

local getPlate = function (index)
	if not trinity['targetUnits'][index] then return nil end
	return C_NamePlate.GetNamePlateForUnit (trinity['targetUnits'][index])
end

local attachTexture = function (index, plate)
	textures[index]:Show()
	textures[index]:SetPoint ('TOPRIGHT', plate['UnitFrame'])
end

local attachTextures = function()
	for i = 1, 3 do
		local plate = getPlate (i)
		if not plate then textures[i]:Hide()
		else attachTexture (i, plate) end
	end
end

frame:RegisterEvent ('PLAYER_ENTERING_WORLD')
frame:RegisterEvent ('PLAYER_TARGET_CHANGED')
frame:RegisterEvent ('PLAYER_FOCUS_CHANGED')
frame:RegisterEvent ('NAME_PLATE_UNIT_ADDED')
frame:RegisterEvent ('NAME_PLATE_UNIT_REMOVED')
frame:SetScript ('OnEvent', function (self, event)
	if trinity['trinitied'] then attachTextures() end
end)

local setTargetArenaUnit = function (index, unit)
	local prevUnit = trinity['targetUnits'][index]
	trinity['targetUnits'][index] = unit
	local otherIndex = (index == 2) and 3 or 2
	if trinity['targetUnits'][otherIndex] == unit then
		trinity['targetUnits'][otherIndex] = prevUnit
	end
end

CreateFrame ('Button', 'TrinitySetFocusButton', nil, 'SecureActionButtonTemplate')
TrinitySetFocusButton:SetAttribute ('type', 'focus')
TrinitySetFocusButton:SetAttribute ('unit', 'mouseover')

trinity['target'] = function()
	trinity['targetUnits'][3] = nil
	SetBinding ('CTRL-BUTTON1', 'CLICK TrinitySetFocusButton:LeftButton')
	attachTextures()
end

trinity['untarget'] = function()
	SetBinding ('SHIFT-BUTTON1', 'CAMERAORSELECTORMOVE')
	for i = 1, 3 do textures[i]:Hide() end
end
