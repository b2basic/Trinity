trinityTargetUnits = { [1] = nil, [2] = nil, [3] = nil }

local trinityTexturePaths =
{
	'Interface\\PvPRankBadges\\PvPRank01',
	'Interface\\PvPRankBadges\\PvPRank02',
	'Interface\\PvPRankBadges\\PvPRank03'
}

local trinityTargets = {}
for i = 1, 3 do
	trinityTargets[i] = {}
	trinityTargets[i]['frame'] = CreateFrame ('Frame')
	trinityTargets[i]['texture'] = trinityTargets[i]['frame']:CreateTexture (nil, 'BACKGROUND', nil, 0)
	trinityTargets[i]['texture']:SetTexture (trinityTexturePaths[i])
end

local getTrinityTargetIndex = function()
	if IsControlKeyDown() then return 3
	elseif IsShiftKeyDown() then return 2
	else return 1 end
end

local attachTrinityTargetTexture = function (index, plate)
	trinityTargets[index]['texture']:Show()
	trinityTargets[index]['texture']:SetPoint ('TOPRIGHT', plate['UnitFrame'])
end

CreateFrame ('Frame', 'TrinityTargetFrame')
TrinityTargetFrame:SetScript ('OnMouseDown', function (self, button)
	local plate = C_NamePlate.GetNamePlateForUnit ('mouseover')
	if not plate then return end
	local index = getTrinityTargetIndex()
	for arenaIndex = 1, 3 do
		if C_NamePlate.GetNamePlateForUnit ('arena' .. arenaIndex)['namePlateUnitToken'] == plate['namePlateUnitToken'] then
			trinityTargetUnits[index] = 'arena' .. arenaIndex
			break
		end
	end
	attachTrinityTargetTexture (index, plate)
end)

TrinityTargetFrame:SetScript ('OnEvent', function (self, event)
	if event == 'PLAYER_ENTERING_WORLD' then for i = 1, 3 do trinityTargets[i]['texture']:Hide() end return end
	if select (1, IsActiveBattlefieldArena()) then return end
	for index, unit in pairs ({ 'target', 'focus' }) do
		trinityTargets[index]['texture']:Hide()
		local plate = C_NamePlate.GetNamePlateForUnit (unit)
		if plate then attachTrinityTargetTexture (index, plate) end
	end
end)
TrinityTargetFrame:RegisterEvent ('PLAYER_ENTERING_WORLD')
TrinityTargetFrame:RegisterEvent ('PLAYER_TARGET_CHANGED')
TrinityTargetFrame:RegisterEvent ('PLAYER_FOCUS_CHANGED')
TrinityTargetFrame:RegisterEvent ('NAME_PLATE_UNIT_ADDED')
TrinityTargetFrame:RegisterEvent ('NAME_PLATE_UNIT_REMOVED')

CreateFrame ('Button', 'TrinitySetFocusButton', nil, 'SecureActionButtonTemplate')
TrinitySetFocusButton:SetAttribute ('type', 'focus')
TrinitySetFocusButton:SetAttribute ('unit', 'mouseover')

local trinitied = false

TrinityTargetFrame:SetScript ('OnKeyDown', function (self, key)
    if key == 'TAB' then
		if trinitied then SetBinding ('BUTTON1', 'CAMERAORSELECTORMOVE') trinitied = false return end
		trinitied = true
		if select (1, IsActiveBattlefieldArena()) then
        	SetBinding ('BUTTON1', 'CLICK TrinityTargetFrame:LeftButton')
		else
			trinityTargetUnits[1] = 'target'
			trinityTargetUnits[2] = 'focus'
			trinityTargetUnits[3] = nil
			SetBinding ('SHIFT-BUTTON1', 'CLICK TrinitySetFocusButton:LeftButton')
		end
    end
end)
TrinityTargetFrame:SetPropagateKeyboardInput (true)