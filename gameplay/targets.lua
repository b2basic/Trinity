local trinity = select (2, ...)

trinity['targetUnits'] = { [1] = 'target', [2] = nil, [3] = nil }

local frame = CreateFrame ('Frame')

local textures = {}
for i = 1, 3 do
	textures[i] = frame:CreateTexture (nil, 'BACKGROUND', nil, 3 - i)
	textures[i]:SetTexture ('Interface\\PvPRankBadges\\PvPRank0' .. i)
	textures[i]:SetScale (0.8)
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

frame:SetScript ('OnMouseDown', function (self, button)
	local plate = C_NamePlate.GetNamePlateForUnit ('mouseover')
	if not plate then return end
	local index = IsControlKeyDown() and 3 or 2
	local arenaIndex = 1
	while arenaIndex <= 3 do
		local arenaPlate = C_NamePlate.GetNamePlateForUnit ('arena' .. arenaIndex)
		if arenaPlate['namePlateUnitToken'] == plate['namePlateUnitToken'] then break end
		arenaIndex = arenaIndex + 1
	end
	trinity['targetUnits'][index] = 'arena' .. arenaIndex
	-- ...
	attachTrinityTargetTexture (index, plate)
end)

CreateFrame ('Button', 'TrinitySetFocusButton', nil, 'SecureActionButtonTemplate')
TrinitySetFocusButton:SetAttribute ('type', 'focus')
TrinitySetFocusButton:SetAttribute ('unit', 'mouseover')

trinity['target'] = function()
	if select (1, IsActiveBattlefieldArena()) then
		trinity['targetUnits'][2] = nil
		trinity['targetUnits'][3] = nil
		SetBinding ('SHIFT-BUTTON1', 'CLICK frame:LeftButton')
		SetBinding ('CONTROL-BUTTON1', 'CLICK frame:LeftButton')
	else
		trinity['targetUnits'][2] = 'focus'
		trinity['targetUnits'][3] = nil
		SetBinding ('SHIFT-BUTTON1', 'CLICK TrinitySetFocusButton:LeftButton')
	end
	attachTextures()
end

trinity['untarget'] = function()
	SetBinding ('BUTTON1', 'CAMERAORSELECTORMOVE')
	for i = 1, 3 do textures[i]:Hide() end
end
