local trinity = select (2, ...)

trinity['trinitied'] = false
trinity['mods'] = { target = 'SHIFT', focus = 'CTRL', other = 'ALT-CTRL' }
trinity['keys'] = { [1] = '´', [2] = '+', [3] = '#' }

local frame = CreateFrame ('Frame')
frame:SetScript ('OnKeyDown', function (self, key)
    if InCombatLockdown() then return end
    if key == 'TAB' then
        if trinity['trinitied'] then
            trinity['unhide']()
            trinity['unmove']()
            trinity['unparent']()
            trinity['unscale']()
            trinity['untarget']()
            trinity['unabilities']()
            trinity['trinitied'] = false
        else
            trinity['hide']()
            trinity['move']()
            trinity['parent']()
            trinity['scale']()
            trinity['target']()
            trinity['abilities']()
            trinity['trinitied'] = true
        end
    end
end)
frame:SetPropagateKeyboardInput (true)